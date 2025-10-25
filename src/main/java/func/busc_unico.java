package func;

import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Timestamp;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import cbd.pos_cbd; // classe de conexão existente

public class busc_unico {

    public static <T> List<T> busca(String tabela, String termo, Class<T> classe) throws Exception {
        Connection con = pos_cbd.getPos_cbd();

        if (con == null || con.isClosed()) {
            throw new Exception("❌ Conexão com o banco não está inicializada!");
        }

        if (termo == null || termo.isBlank()) {
            throw new Exception("❌ Termo de busca vazio!");
        }

        termo = termo.trim();
        String colunaBusca;
        String sql;

        if (isCNPJ(termo) || isCPF(termo)) {
            colunaBusca = "cnpj_cpf";
        } else if (termo.matches("\\d+")) {
            colunaBusca = "id_sis";
        } else {
            colunaBusca = "nome_desc";
            termo = "%" + termo + "%"; // busca parcial
        }

        sql = "SELECT * FROM " + tabela + " WHERE " + colunaBusca + (colunaBusca.equals("nome_desc") ? " ILIKE ?" : " = ?");

        List<T> lista = new ArrayList<>();

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            if (colunaBusca.equals("id_sis")) {
                ps.setLong(1, Long.parseLong(termo));
            } else {
                ps.setString(1, termo);
            }

            try (ResultSet rs = ps.executeQuery()) {
                ResultSetMetaData rsMeta = rs.getMetaData();

                while (rs.next()) {
                    T obj = classe.getDeclaredConstructor().newInstance();

                    for (int i = 1; i <= rsMeta.getColumnCount(); i++) {
                        String nomeColuna = rsMeta.getColumnName(i);
                        Object valor = rs.getObject(i);

                        // DEBUG: mostra o valor vindo do banco
                        /*
                         * System.out.println("Coluna: " + nomeColuna + " | Valor: " + valor);
                         */

                        if (valor == null) continue;

                        String metodoNome = "set" + Character.toUpperCase(nomeColuna.charAt(0)) + nomeColuna.substring(1);

                        for (Method metodo : classe.getMethods()) {
                            if (metodo.getName().equalsIgnoreCase(metodoNome) && metodo.getParameterCount() == 1) {
                                try {
                                    Class<?> tipo = metodo.getParameterTypes()[0];

                                    if (tipo == String.class) {
                                        metodo.invoke(obj, valor.toString());
                                    } else if (tipo == Long.class || tipo == long.class) {
                                        metodo.invoke(obj, ((Number) valor).longValue());
                                    } else if (tipo == Integer.class || tipo == int.class) {
                                        metodo.invoke(obj, ((Number) valor).intValue());
                                    } else if (tipo == Double.class || tipo == double.class) {
                                        metodo.invoke(obj, ((Number) valor).doubleValue());
                                    } else if (tipo == Boolean.class || tipo == boolean.class) {
                                        if (valor instanceof Boolean)
                                            metodo.invoke(obj, valor);
                                        else
                                            metodo.invoke(obj, valor.toString().equalsIgnoreCase("true") || valor.toString().equals("1"));
                                    } else if (Date.class.isAssignableFrom(tipo)) {
                                        if (valor instanceof Timestamp) {
                                            if (tipo == java.util.Date.class) {
                                                metodo.invoke(obj, new java.util.Date(((Timestamp) valor).getTime()));
                                            } else {
                                                metodo.invoke(obj, new java.sql.Date(((Timestamp) valor).getTime()));
                                            }
                                        } else if (valor instanceof java.sql.Date) {
                                            metodo.invoke(obj, valor);
                                        } else {
                                            System.out.println("⚠ Tipo de data inesperado para " + nomeColuna + ": " + valor.getClass());
                                            metodo.invoke(obj, valor);
                                        }
                                    } else {
                                        metodo.invoke(obj, valor);
                                    }
                                    break;
                                } catch (Exception e) {
                                    System.out.println("Erro ao setar coluna " + nomeColuna + ": " + e.getMessage());
                                    e.printStackTrace();
                                }
                            }
                        }
                    }

                    lista.add(obj);
                }
            }
        }

        return lista;
    }

    // -------------------------------
    // 🔢 Validação de CPF e CNPJ
    // -------------------------------
    private static boolean isCPF(String cpf) {
        cpf = cpf.replaceAll("\\D", "");
        if (cpf.length() != 11 || cpf.matches("(\\d)\\1{10}")) return false;

        try {
            int soma = 0;
            for (int i = 0; i < 9; i++) soma += (cpf.charAt(i) - '0') * (10 - i);
            int dig1 = 11 - (soma % 11);
            if (dig1 > 9) dig1 = 0;

            soma = 0;
            for (int i = 0; i < 10; i++) soma += (cpf.charAt(i) - '0') * (11 - i);
            int dig2 = 11 - (soma % 11);
            if (dig2 > 9) dig2 = 0;

            return dig1 == (cpf.charAt(9) - '0') && dig2 == (cpf.charAt(10) - '0');
        } catch (Exception e) {
            return false;
        }
    }

    private static boolean isCNPJ(String cnpj) {
        cnpj = cnpj.replaceAll("\\D", "");
        if (cnpj.length() != 14 || cnpj.matches("(\\d)\\1{13}")) return false;

        try {
            int[] peso1 = {5,4,3,2,9,8,7,6,5,4,3,2};
            int[] peso2 = {6,5,4,3,2,9,8,7,6,5,4,3,2};

            int soma = 0;
            for (int i = 0; i < 12; i++) soma += (cnpj.charAt(i) - '0') * peso1[i];
            int dig1 = soma % 11 < 2 ? 0 : 11 - (soma % 11);

            soma = 0;
            for (int i = 0; i < 13; i++) soma += (cnpj.charAt(i) - '0') * peso2[i];
            int dig2 = soma % 11 < 2 ? 0 : 11 - (soma % 11);

            return dig1 == (cnpj.charAt(12) - '0') && dig2 == (cnpj.charAt(13) - '0');
        } catch (Exception e) {
            return false;
        }
    }
}
