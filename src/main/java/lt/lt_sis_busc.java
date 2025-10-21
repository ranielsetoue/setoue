package lt;

import java.io.IOException;

import cla.cla_perm_ace;
import cla.cla_sis;
import cla.cla_sis_d_log;
import cla.cla_sis_dom;
import cla.cla_sis_log;
import func.fun_blio;
import func.fun_sis;
import func.fun_sis_dom;
import func.fun_sis_login;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class lt_sis_busc
 */
@WebServlet(urlPatterns = { "/00_controle/lt_sis_busc/", "/lt_sis_busc/" })

public class lt_sis_busc extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	fun_blio f_blio = new fun_blio();
	fun_sis_login f_sis_login = new fun_sis_login();
	cla_sis_log cl_sis_log = new cla_sis_log();
	cla_sis_d_log cl_sis_d_log = new cla_sis_d_log();
	fun_sis_dom f_sis_dom = new fun_sis_dom();
	cla_sis_dom cl_sis_dom = new cla_sis_dom();
	fun_sis f_sis = new fun_sis();
	cla_sis cl_sis = new cla_sis();
	cla_perm_ace cl_perm_ace = new cla_perm_ace();

	public lt_sis_busc() {
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
		try {

						if (request.getParameter("fun").equalsIgnoreCase("Buscar") && String.valueOf(request.getSession().getAttribute("cont_sis")) == "cad_sis" ) {

					cl_perm_ace = f_sis_login.cons_perm_ace_id_sis_log(
						Long.parseLong(String.valueOf(request.getSession().getAttribute("id_sis_log_pre"))));

				request.getSession().setAttribute("aces_cad_sis", "false");
				request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
				request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
				request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
				request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
				request.getSession().setAttribute("cons_true", "true");
				request.getSession().setAttribute("cons_false", "false");
				request.getSession().setAttribute("cont_sis", "cad_sis");

				request.getSession().setAttribute("h_titulo_pagina", "CADASTRO BUSCAR");
				request.getRequestDispatcher("/00_controle/00_sistema/cadastro/cad.jsp").forward(request, response);
			}

		} catch (Exception e) {
			// TODO: handle exception
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
