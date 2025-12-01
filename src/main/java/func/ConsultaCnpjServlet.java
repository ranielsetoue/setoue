package func;

import java.io.IOException;

import com.google.gson.Gson;

import api_ext.api_cnpj;
import cla.cla_cnpj;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/consultaCnpj")
public class ConsultaCnpjServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String cnpj = req.getParameter("cnpj");

		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");

		if (cnpj == null || cnpj.isEmpty()) {
			resp.getWriter().write("{\"erro\":\"CNPJ não informado\"}");
			return;
		}

		try {
			cla_cnpj dados = api_cnpj.cons_cnpj(cnpj);

			// Converte a resposta da classe para JSON
			String json = new Gson().toJson(dados);

			resp.getWriter().write(json);

		} catch (Exception e) {
			resp.setStatus(500);
			resp.getWriter().write("{\"erro\": \"" + e.getMessage() + "\"}");
		}
	}
}
