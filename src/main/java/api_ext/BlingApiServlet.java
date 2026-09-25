package api_ext;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/bling/api")
public class BlingApiServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. Verifica se está autenticado
		HttpSession session = request.getSession();
		String accessToken = (String) session.getAttribute("bling_access_token");

		if (accessToken == null || accessToken.isBlank()) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().println("{\"erro\": \"Não autenticado. Conecte o Bling primeiro.\"}");
			return;
		}

		// 2. Verifica qual função foi chamada
		String func = request.getParameter("func");
		BlingApi blingApi = new BlingApi(accessToken);

		try {
			String resultadoJson = "";

			if ("buscarOS".equals(func)) {
				String numero = request.getParameter("numero");

				// Monta o endpoint da API v3 do Bling
				// Nota: Verifique na documentação do Bling se o filtro é "numero" ou outro
				// nome.
				String endpoint = "/ordens-servicos";
				if (numero != null && !numero.isEmpty()) {
					endpoint += "?numero=" + URLEncoder.encode(numero, StandardCharsets.UTF_8);
				}

				// Chama a API do Bling
				resultadoJson = blingApi.get(endpoint);
			} else {
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				response.setContentType("application/json;charset=UTF-8");
				response.getWriter().println("{\"erro\": \"Função não reconhecida. Use ?func=buscarOS\"}");
				return;
			}

			// 3. Retorna o JSON exatamente como o Bling enviou para o seu frontend
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().println(resultadoJson);

		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.setContentType("application/json;charset=UTF-8");
			// Escapa as aspas para não quebrar o JSON de erro
			String msgErro = e.getMessage().replace("\"", "\\\"").replace("\n", " ");
			response.getWriter().println("{\"erro\": \"" + msgErro + "\"}");
			e.printStackTrace();
		}
	}
}