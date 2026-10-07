package api_ext;

import java.net.CookieManager;
import java.net.CookiePolicy;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class api_ie_pe {

    private static final String URL =
            "https://efisco.sefaz.pe.gov.br/"
          + "sfi_trb_gcc/"
          + "PRConsultarExtratoCadastroContribuinteResumido";

    /*
     * ============================================================
     * CONSULTAR IE
     * ============================================================
     */
    public static String consultar(String t_cnpj_cpf) {

        try {

            // ----------------------------------------------------
            // 1 - LIMPAR CNPJ
            // ----------------------------------------------------

            String cnpj =
                    somenteNumeros(t_cnpj_cpf);

            if (cnpj.length() != 14) {

                return null;
            }

            // ----------------------------------------------------
            // 2 - COOKIE / SESSÃO
            // ----------------------------------------------------

            CookieManager cookieManager =
                    new CookieManager(
                            null,
                            CookiePolicy.ACCEPT_ALL);

            HttpClient client =
                    HttpClient.newBuilder()
                            .cookieHandler(cookieManager)
                            .connectTimeout(
                                    Duration.ofSeconds(20))
                            .followRedirects(
                                    HttpClient.Redirect.NORMAL)
                            .build();

            // ----------------------------------------------------
            // 3 - GET INICIAL
            // ----------------------------------------------------

            HttpRequest requestGet =
                    HttpRequest.newBuilder()
                            .uri(URI.create(URL))
                            .timeout(
                                    Duration.ofSeconds(30))
                            .header(
                                    "User-Agent",
                                    "Mozilla/5.0")
                            .header(
                                    "Accept",
                                    "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
                            .header(
                                    "Accept-Language",
                                    "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7")
                            .GET()
                            .build();

            HttpResponse<String> responseGet =
                    client.send(
                            requestGet,
                            HttpResponse.BodyHandlers.ofString(
                                    StandardCharsets.UTF_8));

            if (responseGet.statusCode() != 200) {

                return null;
            }

            String html =
                    responseGet.body();

            // ----------------------------------------------------
            // 4 - PEGAR CAMPOS HIDDEN
            // ----------------------------------------------------

            Map<String, String> hidden =
                    extrairHidden(html);

            // ----------------------------------------------------
            // 5 - MONTAR FORMULÁRIO
            // ----------------------------------------------------

            Map<String, String> campos =
                    new LinkedHashMap<>();

            /*
             * Campos definidos pelo JavaScript da SEFAZ
             */

            campos.put(
                    "id_contexto_sessao",
                    "");

            campos.put(
                    "nao_utilizar_id_contexto_sessao",
                    "true");

            campos.put(
                    "evento",
                    "processarFiltroConsulta");

            /*
             * Tipo 2 = CNPJ
             */

            campos.put(
                    "TpDocumentoIdentificacao",
                    "2");

            campos.put(
                    "NuDocumentoIdentificacao",
                    cnpj);

            campos.put(
                    "NmRazaoSocialPessoa",
                    "");

            campos.put(
                    "qt_registros_pagina",
                    "20");

            campos.put(
                    "btt_localizar",
                    "Localizar (l)");

            // ----------------------------------------------------
            // 6 - CAMPOS HIDDEN DA SESSÃO
            // ----------------------------------------------------

            adicionarSeExistir(
                    campos,
                    hidden,
                    "id_sessao");

            adicionarSeExistir(
                    campos,
                    hidden,
                    "nm_path_servlet_anterior");

            adicionarSeExistir(
                    campos,
                    hidden,
                    "nm_path_jsp_anterior");

            adicionarSeExistir(
                    campos,
                    hidden,
                    "in_enderecodomicilio_valido");

            adicionarSeExistir(
                    campos,
                    hidden,
                    "cd_menu");

            adicionarSeExistir(
                    campos,
                    hidden,
                    "dt_hoje_framework");

            adicionarSeExistir(
                    campos,
                    hidden,
                    "hr_hoje_framework");

            adicionarSeExistir(
                    campos,
                    hidden,
                    "cd_usuario");

            adicionarSeExistir(
                    campos,
                    hidden,
                    "cd_tipo_usuario_sca");

            adicionarSeExistir(
                    campos,
                    hidden,
                    "historico");

            adicionarSeExistir(
                    campos,
                    hidden,
                    "nm_titulo_pagina");

            adicionarSeExistir(
                    campos,
                    hidden,
                    "in_janela_auxiliar");

            adicionarSeExistir(
                    campos,
                    hidden,
                    "in_formulario_submetido");

            adicionarSeExistir(
                    campos,
                    hidden,
                    "nu_faixa_paginacao");

            // ----------------------------------------------------
            // 7 - FORM DATA
            // ----------------------------------------------------

            String formData =
                    montarFormulario(campos);

            // ----------------------------------------------------
            // 8 - POST PARA SEFAZ-PE
            // ----------------------------------------------------

            HttpRequest requestPost =
                    HttpRequest.newBuilder()
                            .uri(URI.create(URL))
                            .timeout(
                                    Duration.ofSeconds(30))
                            .header(
                                    "User-Agent",
                                    "Mozilla/5.0")
                            .header(
                                    "Accept",
                                    "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
                            .header(
                                    "Accept-Language",
                                    "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7")
                            .header(
                                    "Content-Type",
                                    "application/x-www-form-urlencoded")
                            .header(
                                    "Origin",
                                    "https://efisco.sefaz.pe.gov.br")
                            .header(
                                    "Referer",
                                    URL)
                            .POST(
                                    HttpRequest.BodyPublishers.ofString(
                                            formData,
                                            StandardCharsets.UTF_8))
                            .build();

            HttpResponse<String> responsePost =
                    client.send(
                            requestPost,
                            HttpResponse.BodyHandlers.ofString(
                                    StandardCharsets.UTF_8));

            if (responsePost.statusCode() != 200) {

                return null;
            }

            String htmlResultado =
                    responsePost.body();

            // ----------------------------------------------------
            // 9 - PROCURAR chave_primaria
            // ----------------------------------------------------

            String chave =
                    extrairChavePrimaria(
                            htmlResultado);

            if (chave == null
                    || chave.isBlank()) {

                return null;
            }

            // ----------------------------------------------------
            // 10 - SEPARAR CHAVE
            // ----------------------------------------------------

            String[] partes =
                    chave.split(
                            Pattern.quote("[[*]]"),
                            -1);

            if (partes.length == 0) {

                return null;
            }

            // ----------------------------------------------------
            // 11 - PEGAR IE
            // ----------------------------------------------------

            String ie =
                    partes[0];

            if (ie == null
                    || ie.isBlank()) {

                return null;
            }

            // ----------------------------------------------------
            // 12 - FORMATAR IE
            // ----------------------------------------------------

            return formatarIE(ie);

        } catch (Exception e) {

            /*
             * A API não deve interromper o sistema
             * caso a SEFAZ esteja indisponível.
             */

            System.out.println(
                    "Erro api_ie_pe: "
                    + e.getMessage());

            return null;
        }
    }

    // ============================================================
    // EXTRAI CAMPOS HIDDEN
    // ============================================================

    private static Map<String, String> extrairHidden(
            String html) {

        Map<String, String> campos =
                new LinkedHashMap<>();

        Pattern pattern =
                Pattern.compile(
                        "<input[^>]*type\\s*=\\s*[\"']hidden[\"'][^>]*>",
                        Pattern.CASE_INSENSITIVE);

        Matcher matcher =
                pattern.matcher(html);

        while (matcher.find()) {

            String input =
                    matcher.group();

            String nome =
                    extrairAtributo(
                            input,
                            "name");

            if (nome == null
                    || nome.isBlank()) {

                nome =
                        extrairAtributo(
                                input,
                                "id");
            }

            if (nome == null
                    || nome.isBlank()) {

                continue;
            }

            String valor =
                    extrairAtributo(
                            input,
                            "value");

            if (valor == null) {

                valor = "";
            }

            campos.put(
                    nome,
                    valor);
        }

        return campos;
    }

    // ============================================================
    // EXTRAI ATRIBUTO HTML
    // ============================================================

    private static String extrairAtributo(
            String html,
            String atributo) {

        Pattern pattern =
                Pattern.compile(
                        atributo
                        + "\\s*=\\s*[\"']([^\"']*)[\"']",
                        Pattern.CASE_INSENSITIVE);

        Matcher matcher =
                pattern.matcher(html);

        if (matcher.find()) {

            return matcher.group(1);
        }

        return null;
    }

    // ============================================================
    // ADICIONAR CAMPO HIDDEN
    // ============================================================

    private static void adicionarSeExistir(
            Map<String, String> destino,
            Map<String, String> origem,
            String nome) {

        if (origem.containsKey(nome)) {

            if (!destino.containsKey(nome)
                    || destino.get(nome).isEmpty()) {

                destino.put(
                        nome,
                        origem.get(nome));
            }
        }
    }

    // ============================================================
    // MONTA FORMULÁRIO
    // ============================================================

    private static String montarFormulario(
            Map<String, String> campos) {

        StringBuilder sb =
                new StringBuilder();

        for (Map.Entry<String, String> entry
                : campos.entrySet()) {

            if (sb.length() > 0) {

                sb.append("&");
            }

            sb.append(
                    URLEncoder.encode(
                            entry.getKey(),
                            StandardCharsets.UTF_8));

            sb.append("=");

            sb.append(
                    URLEncoder.encode(
                            entry.getValue() == null
                                    ? ""
                                    : entry.getValue(),
                            StandardCharsets.UTF_8));
        }

        return sb.toString();
    }

    // ============================================================
    // EXTRAI chave_primaria
    // ============================================================

    private static String extrairChavePrimaria(
            String html) {

        /*
         * Exemplo:
         *
         * name="chave_primaria"
         * value="017681901[[*]]..."
         */

        Pattern pattern =
                Pattern.compile(
                        "name\\s*=\\s*[\"']chave_primaria[\"'][^>]*value\\s*=\\s*[\"']([^\"']*)[\"']",
                        Pattern.CASE_INSENSITIVE);

        Matcher matcher =
                pattern.matcher(html);

        if (matcher.find()) {

            return matcher.group(1);
        }

        /*
         * Caso a SEFAZ coloque value antes de name.
         */

        Pattern pattern2 =
                Pattern.compile(
                        "value\\s*=\\s*[\"']([^\"']*)[\"'][^>]*name\\s*=\\s*[\"']chave_primaria[\"']",
                        Pattern.CASE_INSENSITIVE);

        Matcher matcher2 =
                pattern2.matcher(html);

        if (matcher2.find()) {

            return matcher2.group(1);
        }

        return null;
    }

    // ============================================================
    // SOMENTE NÚMEROS
    // ============================================================

    private static String somenteNumeros(
            String valor) {

        if (valor == null) {

            return "";
        }

        return valor.replaceAll(
                "\\D",
                "");
    }

    // ============================================================
    // FORMATA IE PE
    // ============================================================

    private static String formatarIE(
            String ie) {

        if (ie == null) {

            return null;
        }

        ie = ie.replaceAll(
                "\\D",
                "");

        /*
         * SEFAZ-PE retorna:
         *
         * 017681901
         *
         * Formato:
         *
         * 0176819-01
         */

        if (ie.length() == 9) {

            return ie.substring(0, 7)
                    + "-"
                    + ie.substring(7);
        }

        return ie;
    }
}