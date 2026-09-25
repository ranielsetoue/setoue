package api_ext;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/bling_callback")
public class BlingCallback extends HttpServlet {

	private static final long serialVersionUID = 1L;

	/*
	 * COLOQUE OS DADOS DO SEU APLICATIVO
	 */
	private static final String CLIENT_ID = "b28a6dee8e25126e63994b91bfdf71d84e0420ef";

	private static final String CLIENT_SECRET = "8fb07301357d6047f3dbc800aa0df8dae2651d77bcd42007b7b8107ad359";

	private static final String REDIRECT_URI = "http://localhost:8080/setoue/bling_callback";

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String code = request.getParameter("code");

		String state = request.getParameter("state");

		if (code == null || code.isBlank()) {

			response.setContentType("text/plain;charset=UTF-8");

			response.getWriter().println("Código de autorização não recebido.");

			return;
		}

		try {

			BlingOAuth oauth = new BlingOAuth(CLIENT_ID, CLIENT_SECRET, REDIRECT_URI);

			BlingToken token = oauth.obterToken(code);

			HttpSession session = request.getSession();

			session.setAttribute("bling_access_token", token.getAccess_token());

			session.setAttribute("bling_refresh_token", token.getRefresh_token());

			session.setAttribute("bling_expires_in", token.getExpires_in());

			response.setContentType("text/html;charset=UTF-8");

			response.getWriter().println("<h3>Integração Bling autorizada!</h3>");

			response.getWriter().println("<p>JWT recebido com sucesso.</p>");

			response.getWriter().println("<p>State: " + state + "</p>");

		} catch (Exception e) {

			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

			response.setContentType("text/plain;charset=UTF-8");

			response.getWriter().println("Erro ao autenticar com o Bling:");

			response.getWriter().println(e.getMessage());
		}
	}
}
