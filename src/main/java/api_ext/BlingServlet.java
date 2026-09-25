package api_ext;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/bling")
public class BlingServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");

		HttpSession session = request.getSession();

		/*
		 * ===================================================== PEGA O JWT SALVO NA
		 * SESSÃO =====================================================
		 */

		String accessToken = (String) session.getAttribute("bling_access_token");

		/*
		 * ===================================================== VERIFICA SE O BLING
		 * ESTÁ AUTORIZADO =====================================================
		 */

		if (accessToken == null || accessToken.isBlank()) {

			response.getWriter().println("<h3>Bling não está conectado.</h3>");

			response.getWriter().println(
					"<a href='" + request.getContextPath() + "/bling_autorizacao'>" + "Conectar com Bling" + "</a>");

			return;
		}

		/*
		 * ===================================================== CRIA A API USANDO O JWT
		 * =====================================================
		 */

		BlingApi blingApi = new BlingApi(accessToken);

		try {

			/*
			 * ================================================= TESTE DE CONEXÃO COM O
			 * BLING =================================================
			 *
			 * Aqui estamos consultando as ordens de serviço.
			 */

			String resultado = blingApi.get("/ordens-servicos");

			/*
			 * ================================================ MOSTRA O JSON RECEBIDO
			 * ================================================
			 */

			response.getWriter().println("<h3>Conexão com Bling OK</h3>");

			response.getWriter().println("<pre>");

			response.getWriter().println(resultado);

			response.getWriter().println("</pre>");

		} catch (Exception e) {

			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

			response.getWriter().println("<h3>Erro ao consultar o Bling</h3>");

			response.getWriter().println("<pre>");

			e.printStackTrace(response.getWriter());

			response.getWriter().println("</pre>");
		}
	}
}
