package lt;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class lt_sis
 */
@WebServlet(urlPatterns = { "/00_controle/lt_sis/", "/lt_sis/" })
public class lt_sis extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public lt_sis() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getSession().setAttribute("h_titulo_pagina", "CADASTRO SISTEMA");
		request.getRequestDispatcher("/00_controle/00_sistema/cadastro/cad_sis_cons.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		request.getSession().setAttribute("cont_aces", "true");
		request.getSession().setAttribute("aces_cad_sis", "true");
		request.getSession().setAttribute("aces_cad_clin", "true");
		request.getSession().setAttribute("aces_cad_forn", "true");
		request.getSession().setAttribute("aces_cad_prod", "true");
		request.getSession().setAttribute("aces_cad_serv", "true");
		request.getSession().setAttribute("cons_true", "true");
		request.getSession().setAttribute("cons_false", "true");
		request.getSession().setAttribute("h_titulo_web", "SISTEMA");
		


		if (request.getParameter("sit_cont").equalsIgnoreCase("cad_sis")) {
			request.getSession().setAttribute("h_titulo_pagina", "CADASTRO SISTEMA");
		
			request.getSession().setAttribute("cons_true", "true");
			request.getSession().setAttribute("cons_false", "false");
			request.getRequestDispatcher("/00_controle/00_sistema/cadastro/cad_sis_cons.jsp").forward(request,
					response);
		}

	}

}
