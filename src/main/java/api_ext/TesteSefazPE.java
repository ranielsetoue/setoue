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

public class TesteSefazPE {

	private static final String URL = "https://efisco.sefaz.pe.gov.br/" + "sfi_trb_gcc/"
			+ "PRConsultarExtratoCadastroContribuinteResumido";

	private static final CookieManager COOKIE_MANAGER = new CookieManager(null, CookiePolicy.ACCEPT_ALL);

	private static final HttpClient CLIENT = HttpClient.newBuilder().cookieHandler(COOKIE_MANAGER)
			.connectTimeout(Duration.ofSeconds(20)).followRedirects(HttpClient.Redirect.NORMAL).build();

	public static void main(String[] args) {

		String cnpj = "20.300.157/0052-90";

		String iea1 = api_inscricao.consultar("24.150.377/0003-57");

		System.out.println("Inscrição Estadual: " + iea1);

		System.out.println("====================================");
		System.out.println();
		System.out.println("TESTE SEFAZ-PE");
		System.out.println();

		try {

			// =====================================================
			// 1 - ABRIR A PÁGINA
			// =====================================================

			System.out.println("1 - Abrindo página da SEFAZ-PE...");
			System.out.println();

			HttpRequest requestGet = HttpRequest.newBuilder().uri(URI.create(URL)).timeout(Duration.ofSeconds(30))
					.header("User-Agent", "Mozilla/5.0")
					.header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
					.header("Accept-Language", "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7").GET().build();

			HttpResponse<String> responseGet = CLIENT.send(requestGet,
					HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

			System.out.println("HTTP GET: " + responseGet.statusCode());

			System.out.println("URL: " + responseGet.uri());

			String htmlGet = responseGet.body();

			System.out.println("HTML recebido: " + htmlGet.length() + " caracteres");

			System.out.println();

			if (responseGet.statusCode() != 200) {

				System.out.println("ERRO: GET retornou HTTP " + responseGet.statusCode());

				return;
			}

			// =====================================================
			// 2 - MOSTRAR COOKIES
			// =====================================================

			System.out.println("2 - Cookies recebidos:");
			System.out.println();

			COOKIE_MANAGER.getCookieStore().getCookies().forEach(cookie -> {

				System.out.println(cookie.getName() + " = " + cookie.getValue());
			});

			System.out.println();

			// =====================================================
			// 3 - CAMPOS HIDDEN
			// =====================================================

			System.out.println("3 - Campos hidden encontrados:");

			Map<String, String> hidden = extrairHidden(htmlGet);

			System.out.println("Quantidade: " + hidden.size());

			System.out.println();

			for (Map.Entry<String, String> entry : hidden.entrySet()) {

				System.out.println(entry.getKey() + " = " + entry.getValue());
			}

			System.out.println();

			// =====================================================
			// 4 - ID_SESSAO
			// =====================================================

			String idSessao = hidden.get("id_sessao");

			System.out.println("id_sessao usado: " + idSessao);

			System.out.println();

			// =====================================================
			// 5 - PREPARAR FORMULÁRIO
			// =====================================================

			System.out.println("4 - Preparando consulta...");

			String cnpjSomenteNumeros = somenteNumeros(cnpj);

			System.out.println("CNPJ enviado: " + cnpjSomenteNumeros);

			System.out.println("Tipo documento: 2");

			System.out.println();

			Map<String, String> campos = new LinkedHashMap<>();

			/*
			 * ==================================================== CAMPOS IMPORTANTES
			 * ====================================================
			 */

			// Campo usado pelo JavaScript da SEFAZ
			campos.put("id_contexto_sessao", "");

			// A página define este valor como true
			campos.put("nao_utilizar_id_contexto_sessao", "true");

			// Evento chamado pelo JavaScript
			campos.put("evento", "processarFiltroConsulta");

			// Tipo de documento:
			// 1 = IE
			// 2 = CNPJ
			// 3 = CPF
			campos.put("TpDocumentoIdentificacao", "2");

			// CNPJ
			campos.put("NuDocumentoIdentificacao", cnpjSomenteNumeros);

			// Nome/Razão Social
			campos.put("NmRazaoSocialPessoa", "");

			// Quantidade de registros
			campos.put("qt_registros_pagina", "20");

			// Botão
			campos.put("btt_localizar", "Localizar (l)");

			/*
			 * ==================================================== CAMPOS HIDDEN DA PÁGINA
			 * ====================================================
			 */

			adicionarSeExistir(campos, hidden, "id_sessao");

			adicionarSeExistir(campos, hidden, "nm_path_servlet_anterior");

			adicionarSeExistir(campos, hidden, "nm_path_jsp_anterior");

			adicionarSeExistir(campos, hidden, "in_enderecodomicilio_valido");

			adicionarSeExistir(campos, hidden, "cd_menu");

			adicionarSeExistir(campos, hidden, "dt_hoje_framework");

			adicionarSeExistir(campos, hidden, "hr_hoje_framework");

			adicionarSeExistir(campos, hidden, "cd_usuario");

			adicionarSeExistir(campos, hidden, "cd_tipo_usuario_sca");

			adicionarSeExistir(campos, hidden, "historico");

			adicionarSeExistir(campos, hidden, "nm_titulo_pagina");

			adicionarSeExistir(campos, hidden, "in_janela_auxiliar");

			adicionarSeExistir(campos, hidden, "in_formulario_submetido");

			adicionarSeExistir(campos, hidden, "nu_faixa_paginacao");

			System.out.println("Campos enviados:");

			System.out.println();

			for (Map.Entry<String, String> entry : campos.entrySet()) {

				System.out.println(entry.getKey() + " = " + entry.getValue());
			}

			System.out.println();

			// =====================================================
			// 6 - MONTAR POST
			// =====================================================

			String formData = montarFormulario(campos);

			System.out.println("5 - Enviando CNPJ para a SEFAZ...");

			System.out.println();

			System.out.println("POST URL: " + URL);

			System.out.println();

			// =====================================================
			// 7 - POST
			// =====================================================

			HttpRequest requestPost = HttpRequest.newBuilder().uri(URI.create(URL)).timeout(Duration.ofSeconds(30))
					.header("User-Agent", "Mozilla/5.0")
					.header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
					.header("Accept-Language", "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7")
					.header("Content-Type", "application/x-www-form-urlencoded")
					.header("Origin", "https://efisco.sefaz.pe.gov.br").header("Referer", URL)
					.POST(HttpRequest.BodyPublishers.ofString(formData, StandardCharsets.UTF_8)).build();

			HttpResponse<String> responsePost = CLIENT.send(requestPost,
					HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

			System.out.println("HTTP POST: " + responsePost.statusCode());

			System.out.println("URL final: " + responsePost.uri());

			String htmlResultado = responsePost.body();

			System.out.println("HTML resultado: " + htmlResultado.length() + " caracteres");

			System.out.println();

			// =====================================================
			// 8 - PROCURAR chave_primaria
			// =====================================================

			System.out.println("6 - Procurando chave_primaria...");

			System.out.println();

			String chave = extrairChavePrimaria(htmlResultado);

			if (chave == null) {

				System.out.println("NÃO FOI ENCONTRADA a chave_primaria.");

				System.out.println();

				// Mostra algumas informações para diagnóstico

				if (htmlResultado.contains("Número do Documento")) {

					System.out.println("A página retornou novamente " + "o formulário de consulta.");
				}

				if (htmlResultado.contains("Nenhum registro")) {

					System.out.println("A SEFAZ informou que não encontrou " + "registro.");
				}

				return;
			}

			System.out.println("chave_primaria encontrada:");

			System.out.println(chave);

			System.out.println();

			// =====================================================
			// 9 - SEPARAR A CHAVE
			// =====================================================

			String[] partes = chave.split(Pattern.quote("[[*]]"), -1);

			System.out.println("Quantidade de partes: " + partes.length);

			System.out.println();

			for (int i = 0; i < partes.length; i++) {

				System.out.println("Parte " + i + ": " + partes[i]);
			}

			System.out.println();

			// =====================================================
			// 10 - IE
			// =====================================================

			if (partes.length > 0) {

				String ie = partes[0];

				System.out.println("====================================");

				System.out.println("INSCRIÇÃO ESTADUAL:");

				System.out.println(formatarIE(ie));

				System.out.println("====================================");
			}

			// =====================================================
			// 11 - CNPJ
			// =====================================================

			if (partes.length > 1) {

				System.out.println("CNPJ encontrado:");

				System.out.println(partes[1]);
			}

			// =====================================================
			// 12 - RAZÃO SOCIAL
			// =====================================================

			if (partes.length > 2) {

				System.out.println("Razão Social:");

				System.out.println(partes[2]);
			}

			// =====================================================
			// 13 - NOME FANTASIA
			// =====================================================

			if (partes.length > 4) {

				System.out.println("Nome Fantasia:");

				System.out.println(partes[4]);
			}

		} catch (Exception e) {

			System.out.println();
			System.out.println("ERRO NO TESTE:");

			e.printStackTrace();
		}
	}

	// =========================================================
	// EXTRAI CAMPOS HIDDEN
	// =========================================================

	private static Map<String, String> extrairHidden(String html) {

		Map<String, String> campos = new LinkedHashMap<>();

		Pattern pattern = Pattern.compile("<input[^>]*type\\s*=\\s*[\"']hidden[\"'][^>]*>", Pattern.CASE_INSENSITIVE);

		Matcher matcher = pattern.matcher(html);

		while (matcher.find()) {

			String input = matcher.group();

			String nome = extrairAtributo(input, "name");

			if (nome == null || nome.isBlank()) {

				nome = extrairAtributo(input, "id");
			}

			if (nome == null || nome.isBlank()) {

				continue;
			}

			String valor = extrairAtributo(input, "value");

			if (valor == null) {
				valor = "";
			}

			campos.put(nome, valor);
		}

		return campos;
	}

	// =========================================================
	// EXTRAI ATRIBUTO HTML
	// =========================================================

	private static String extrairAtributo(String html, String atributo) {

		Pattern pattern = Pattern.compile(atributo + "\\s*=\\s*[\"']([^\"']*)[\"']", Pattern.CASE_INSENSITIVE);

		Matcher matcher = pattern.matcher(html);

		if (matcher.find()) {

			return matcher.group(1);
		}

		return null;
	}

	// =========================================================
	// ADICIONA HIDDEN SE EXISTIR
	// =========================================================

	private static void adicionarSeExistir(Map<String, String> destino, Map<String, String> origem, String nome) {

		if (origem.containsKey(nome)) {

			/*
			 * Não substituir os campos que foram definidos manualmente acima.
			 */
			if (!destino.containsKey(nome) || destino.get(nome).isEmpty()) {

				destino.put(nome, origem.get(nome));
			}
		}
	}

	// =========================================================
	// MONTA FORMULÁRIO
	// =========================================================

	private static String montarFormulario(Map<String, String> campos) {

		StringBuilder sb = new StringBuilder();

		for (Map.Entry<String, String> entry : campos.entrySet()) {

			if (sb.length() > 0) {

				sb.append("&");
			}

			sb.append(URLEncoder.encode(entry.getKey(), StandardCharsets.UTF_8));

			sb.append("=");

			sb.append(URLEncoder.encode(entry.getValue() == null ? "" : entry.getValue(), StandardCharsets.UTF_8));
		}

		return sb.toString();
	}

	// =========================================================
	// SOMENTE NÚMEROS
	// =========================================================

	private static String somenteNumeros(String valor) {

		if (valor == null) {

			return "";
		}

		return valor.replaceAll("\\D", "");
	}

	// =========================================================
	// PROCURA chave_primaria
	// =========================================================

	private static String extrairChavePrimaria(String html) {

		Pattern pattern = Pattern.compile("name\\s*=\\s*[\"']chave_primaria[\"'][^>]*value\\s*=\\s*[\"']([^\"']*)[\"']",
				Pattern.CASE_INSENSITIVE);

		Matcher matcher = pattern.matcher(html);

		if (matcher.find()) {

			return matcher.group(1);
		}

		/*
		 * Tenta também caso o value venha antes do name no HTML.
		 */

		Pattern pattern2 = Pattern.compile(
				"value\\s*=\\s*[\"']([^\"']*)[\"'][^>]*name\\s*=\\s*[\"']chave_primaria[\"']",
				Pattern.CASE_INSENSITIVE);

		Matcher matcher2 = pattern2.matcher(html);

		if (matcher2.find()) {

			return matcher2.group(1);
		}

		return null;
	}

	// =========================================================
	// FORMATA IE
	// =========================================================

	private static String formatarIE(String ie) {

		if (ie == null) {

			return null;
		}

		ie = ie.replaceAll("\\D", "");

		/*
		 * Exemplo retornado:
		 *
		 * 017681901
		 *
		 * Formato exibido:
		 *
		 * 0176819-01
		 */

		if (ie.length() == 9) {

			return ie.substring(0, 7) + "-" + ie.substring(7);
		}

		return ie;
	}

}