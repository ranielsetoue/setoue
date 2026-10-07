package api_ext;

import cla.cla_cnpj;

public class api_inscricao {

	public static String consultar(String t_cnpj_cpf) {

		try {

			// Consulta o CNPJ usando sua API existente
			cla_cnpj cl_cnpj = api_cnpj.cons_cnpj(t_cnpj_cpf);

			if (cl_cnpj == null) {
				return null;
			}

			// Pega a UF
			String uf = cl_cnpj.getUf();

			if (uf == null || uf.isBlank()) {
				return null;
			}

			uf = uf.trim().toUpperCase();

			// Direciona para a API do estado
			return switch (uf) {

			case "PE" -> api_ie_pe.consultar(t_cnpj_cpf);

			default -> null;
			};

		} catch (Exception e) {

			System.out.println("Erro api_inscricao: " + e.getMessage());

			return null;
		}
	}
}