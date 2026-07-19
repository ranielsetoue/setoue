package lt;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import cla.cla_bc_cam;
import cla.cla_list_cnpj_nome;
import cla.cla_list_tipo_ace;
import cla.cla_perm_ace;
import cla.cla_sis;
import cla.cla_sis_cont;
import cla.cla_sis_d_log;
import cla.cla_sis_dom;
import cla.cla_sis_log;
import func.fun_blio;
import func.fun_sis;
import func.fun_sis_cont;
import func.fun_sis_dom;
import func.fun_sis_login;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import st.win_login;

/**
 * Servlet implementation class lt_sis_busc
 */
@WebServlet(urlPatterns = { "/00_controle/lt_sis_excluir/", "/lt_sis_excluir/" })

public class lt_sis_excluir extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	win_login w_login = new win_login();

	fun_blio f_blio = new fun_blio();
	fun_sis_login f_sis_login = new fun_sis_login();
	cla_sis_log cl_sis_log = new cla_sis_log();
	cla_bc_cam win = new cla_bc_cam();

	cla_sis_d_log cl_sis_d_log = new cla_sis_d_log();
	fun_sis_dom f_sis_dom = new fun_sis_dom();
	cla_sis_dom cl_sis_dom = new cla_sis_dom();
	fun_sis f_sis = new fun_sis();
	cla_sis cl_sis = new cla_sis();
	cla_perm_ace cl_perm_ace = new cla_perm_ace();
	Calendar calend = Calendar.getInstance();
	SimpleDateFormat formatData = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	cla_sis_cont cl_sis_cont = new cla_sis_cont();
	fun_sis_cont f_sis_cont = new fun_sis_cont();

	public lt_sis_excluir() {
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
			if (request.getParameter("fun").equalsIgnoreCase("excluir")) {
				request.getSession().setAttribute("cons_list", false);

				try {
					cl_perm_ace = f_sis_login.cons_perm_ace_id_sis_log(
							Long.parseLong(String.valueOf(request.getSession().getAttribute("id_sis_log_pre"))));

				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
					request.getSession().setAttribute("h_titulo_pagina",
							"SET DEV - ERRO BUSCAR PERMISSAO ACESSO" + e.getMessage());
					request.getRequestDispatcher(w_login.getPag_inicial()).forward(request, response);

				}

				try {
					List<cla_list_tipo_ace> sis_list_tipo_ace = f_sis.cons_list_tipo_ace();
					request.setAttribute("sis_list_tipo_ace", sis_list_tipo_ace);

				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
					request.getSession().setAttribute("h_titulo_pagina",
							"SET DEV - ERRO BUSCAR TIPO DE ACESSO" + e.getMessage());
					request.getRequestDispatcher(w_login.getPag_inicial()).forward(request, response);

				}

				request.getSession().setAttribute("cons_true", "false");
				request.getSession().setAttribute("cons_false", "true");

				if ("cad_sis".equals(request.getSession().getAttribute("cont_sis"))) {
					request.getSession().setAttribute("aces_cad_sis", "false");
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_sis");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO SISTEMA");

					List<cla_list_cnpj_nome> sisCons = f_sis.cons_list_sis_cnpj();
					request.setAttribute("sis_cons", sisCons);

					String tx1 = request.getParameter("busc_cnpj_cpf");
					cl_sis = f_sis.cons_sis_cnpj_cpf(tx1);
					System.out.println(cl_sis.getId_sis() + " - " + cl_sis.getNome_desc());
					f_blio.del_dado(win.getWin_sis(), win.getCol_sis_id(), cl_sis.getId_sis());

				}
				if ("cad_clin".equals(request.getSession().getAttribute("cont_sis"))) {

					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", "false");
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_cli");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO CLIENTE");
				}
				if ("cad_forn".equals(request.getSession().getAttribute("cont_sis"))) {

					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", "false");
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_for");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO FORNECEDOR");

					/*
					 * List<cla_list_cnpj_nome> sisCons = f_sis.cons_list_sis_cnpj();
					 * request.setAttribute("sis_cons", sisCons);
					 */

				}
				if ("cad_prod".equals(request.getSession().getAttribute("cont_sis"))) {

					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", "false");
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_pro");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO PRODUTO");

					/*
					 * List<cla_list_cnpj_nome> sisCons = f_sis.cons_list_sis_cnpj();
					 * request.setAttribute("sis_cons", sisCons);
					 */

				}
				if ("cad_serv".equals(request.getSession().getAttribute("cont_sis"))) {

					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", "false");
					request.getSession().setAttribute("cont_sis", "cad_serv");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO SERVICO");

					/*
					 * List<cla_list_cnpj_nome> sisCons = f_sis.cons_list_sis_cnpj();
					 * request.setAttribute("sis_cons", sisCons);
					 */

				}

				if ("cad_prod".equals(request.getSession().getAttribute("cont_sis"))
						|| ("cad_serv".equals(request.getSession().getAttribute("cont_sis")))) {
					request.getRequestDispatcher("/00_controle/00_sistema/cadastro/cad_pro_serv.jsp").forward(request,
							response);

				} else {
					request.getRequestDispatcher("/00_controle/00_sistema/cadastro/cad.jsp").forward(request, response);

				}

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
/*
 * inicio do post
 */
		try {

			if (request.getParameter("fun").equalsIgnoreCase("excluir_sis_cont")) {

				String cont_id_sis_cont = request.getParameter("id_sis_cont");
				f_sis_cont.del_sis_cont(cont_id_sis_cont);

		        response.getWriter().print("OK");

			}

		} catch (Exception e) {
			// TODO: handle exception
		}

	}
	
	/*
	 * fim post
	 */
}
