package api_ext;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

public class api_ie {

	private static final HttpClient CLIENT = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(10))
			.followRedirects(HttpClient.Redirect.NORMAL).build();

	public static String consultar(String cnpj, String uf) {

		if (cnpj == null || cnpj.isBlank()) {
			return null;
		}

		if (uf == null || uf.isBlank()) {
			return null;
		}

		cnpj = cnpj.replaceAll("\\D", "");
		uf = uf.trim().toUpperCase();

		return switch (uf) {

		case "PE" -> consultarPE(cnpj);

		default -> null;
		};
	}

	private static String consultarPE(String cnpj) {

		try {

			String url = "https://efisco.sefaz.pe.gov.br/" + "sfi_trb_gcc/"
					+ "PRConsultarExtratoCadastroContribuinteResumido";

			HttpRequest request = HttpRequest.newBuilder().uri(URI.create(url)).timeout(Duration.ofSeconds(20))
					.header("User-Agent", "Mozilla/5.0").header("Accept", "text/html,application/xhtml+xml").GET()
					.build();

			HttpResponse<String> response = CLIENT.send(request, HttpResponse.BodyHandlers.ofString());

			if (response.statusCode() != 200) {
				return null;
			}

			String html = response.body();

			/*
			 * Neste ponto temos a página oficial.
			 *
			 * Precisamos localizar os campos reais do formulário e descobrir:
			 *
			 * - nome do campo do tipo de documento - nome do campo CNPJ - nome do
			 * botão/ação - URL utilizada no submit
			 */

			System.out.println("SEFAZ-PE respondeu: " + html.length() + " caracteres");

			return null;

		} catch (Exception e) {

			System.out.println("Erro IE PE: " + e.getMessage());

			return null;
		}
	}
}
