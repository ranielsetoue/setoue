package api_ext;

import java.io.IOException;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/bling_autorizacao")
public class BlingAutorizacao extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static final String CLIENT_ID = "b28a6dee8e25126e63994b91bfdf71d84e0420ef";

	private static final String CLIENT_SECRET = "8fb07301357d6047f3dbc800aa0df8dae2651d77bcd42007b7b8107ad359";

	private static final String REDIRECT_URI = "http://localhost:8080/setoue/bling_callback";

	@Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String state =
                UUID.randomUUID().toString();

        HttpSession session =
                request.getSession();

        session.setAttribute(
                "bling_state",
                state);

        BlingOAuth oauth =
                new BlingOAuth(
                        CLIENT_ID,
                        CLIENT_SECRET,
                        REDIRECT_URI);

        String url =
                oauth.criarUrlAutorizacao(state);

        response.sendRedirect(url);
    }
}
