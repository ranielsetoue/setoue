package lt;

import java.io.IOException;
import java.util.List;

import cla.cla_list_cnpj_nome;
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
 * Servlet implementation class lt_sis
 */
@WebServlet(urlPatterns = { "/00_controle/lt_sis/", "/lt_sis/" })
public class lt_sis extends HttpServlet {
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

		try {

			if (request.getParameter("fun").equalsIgnoreCase("cad_sis")) {
				cl_perm_ace = f_sis_login.cons_perm_ace_id_sis_log(
						Long.parseLong(String.valueOf(request.getSession().getAttribute("id_sis_log_pre"))));

				request.getSession().setAttribute("aces_cad_sis", "false");
				request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
				request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
				request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
				request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
				request.getSession().setAttribute("cons_true", "false");
				request.getSession().setAttribute("cons_false", "true");
				request.getSession().setAttribute("cont_sis", "cad_sis");
				/*
				 * List<cla_list_cnpj_nome> dadosJsonUser = f_sis.cons_list_sis_cnpj();
				 * 
				 * ObjectMapper mapper = new ObjectMapper();
				 * 
				 * String json = mapper.writeValueAsString(dadosJsonUser);
				 * 
				 * response.getWriter().write(json);
				 * 
				 * System.out.println(json);
				 * 
				 */
				List<cla_list_cnpj_nome> sisCons = f_sis.cons_list_sis_cnpj();
				request.setAttribute("sis_cons", sisCons);

				request.getSession().setAttribute("h_titulo_pagina", "CADASTRO SISTEMA");
				request.getRequestDispatcher("/00_controle/00_sistema/cadastro/cad.jsp").forward(request, response);
			}

			if (request.getParameter("fun").equalsIgnoreCase("cad_cli")) {
				cl_perm_ace = f_sis_login.cons_perm_ace_id_sis_log(
						Long.parseLong(String.valueOf(request.getSession().getAttribute("id_sis_log_pre"))));

				request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
				request.getSession().setAttribute("aces_cad_clin", "false");
				request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
				request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
				request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
				request.getSession().setAttribute("cons_true", "false");
				request.getSession().setAttribute("cons_false", "true");
				request.getSession().setAttribute("cont_sis", "cad_cli");
				List<cla_list_cnpj_nome> sisCons = f_sis.cons_list_sis_cnpj();
				request.setAttribute("sis_cons", sisCons);

				request.getSession().setAttribute("h_titulo_pagina", "CADASTRO CLIENTE");
				request.getRequestDispatcher("/00_controle/00_sistema/cadastro/cad.jsp").forward(request, response);
			}

			if (request.getParameter("fun").equalsIgnoreCase("cad_for")) {
				cl_perm_ace = f_sis_login.cons_perm_ace_id_sis_log(
						Long.parseLong(String.valueOf(request.getSession().getAttribute("id_sis_log_pre"))));

				request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
				request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
				request.getSession().setAttribute("aces_cad_forn", "false");
				request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
				request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
				request.getSession().setAttribute("cons_true", "false");
				request.getSession().setAttribute("cons_false", "true");
				request.getSession().setAttribute("cont_sis", "cad_for");
				List<cla_list_cnpj_nome> sisCons = f_sis.cons_list_sis_cnpj();
				request.setAttribute("sis_cons", sisCons);

				request.getSession().setAttribute("h_titulo_pagina", "CADASTRO FORNECEDOR");
				request.getRequestDispatcher("/00_controle/00_sistema/cadastro/cad.jsp").forward(request, response);
			}

			if (request.getParameter("fun").equalsIgnoreCase("cad_pro")) {
				cl_perm_ace = f_sis_login.cons_perm_ace_id_sis_log(
						Long.parseLong(String.valueOf(request.getSession().getAttribute("id_sis_log_pre"))));

				request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
				request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
				request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
				request.getSession().setAttribute("aces_cad_prod", "false");
				request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
				request.getSession().setAttribute("cons_true", "false");
				request.getSession().setAttribute("cons_false", "true");
				request.getSession().setAttribute("cont_sis", "cad_pro");

				request.getSession().setAttribute("h_titulo_pagina", "CADASTRO PRODUTO");
				request.getRequestDispatcher("/00_controle/00_sistema/cadastro/cad_pro_serv.jsp").forward(request,
						response);
			}

			if (request.getParameter("fun").equalsIgnoreCase("cad_serv")) {
				cl_perm_ace = f_sis_login.cons_perm_ace_id_sis_log(
						Long.parseLong(String.valueOf(request.getSession().getAttribute("id_sis_log_pre"))));

				request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
				request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
				request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
				request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
				request.getSession().setAttribute("aces_cad_serv", "false");
				request.getSession().setAttribute("cons_true", "false");
				request.getSession().setAttribute("cons_false", "true");
				request.getSession().setAttribute("cont_sis", "cad_serv");

				request.getSession().setAttribute("h_titulo_pagina", "CADASTRO SERVICO");
				request.getRequestDispatcher("/00_controle/00_sistema/cadastro/cad_pro_serv.jsp").forward(request,
						response);
			}

			if (request.getParameter("fun").equalsIgnoreCase("ini_cont")) {

				cl_perm_ace = f_sis_login.cons_perm_ace_id_sis_log(
						Long.parseLong(String.valueOf(request.getSession().getAttribute("id_sis_log_pre"))));

				request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
				request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
				request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
				request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
				request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
				request.getSession().setAttribute("cons_true", "false");
				request.getSession().setAttribute("cons_false", "true");
				request.getSession().setAttribute("h_titulo_pagina",
						request.getSession().getAttribute("h_titulo_pagina_ini"));
				request.getSession().setAttribute("h_titulo_web",
						request.getSession().getAttribute("h_titulo_web_ini"));
				request.getSession().setAttribute("cont_sis", "cad_empty");

				String web_url = String.valueOf(request.getSession().getAttribute("web_url_pre"));
				request.getRequestDispatcher(web_url).forward(request, response);
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
