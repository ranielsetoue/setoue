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
import st.win_login;

/**
 * Servlet implementation class lt_sis_log
 */

@WebServlet(urlPatterns = { "/00_controle/lt_sis_log/", "/lt_sis_log/" })
public class lt_sis_log extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	win_login w_login = new win_login();
	fun_blio f_blio = new fun_blio();
	fun_sis_login f_sis_login = new fun_sis_login();
	cla_sis_log cl_sis_log = new cla_sis_log();
	cla_sis_d_log cl_sis_d_log = new cla_sis_d_log();
	fun_sis_dom f_sis_dom = new fun_sis_dom();
	cla_sis_dom cl_sis_dom = new cla_sis_dom();
	fun_sis f_sis = new fun_sis();
	cla_sis cl_sis = new cla_sis();
	cla_perm_ace cl_perm_ace = new cla_perm_ace();

	public lt_sis_log() {
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
		String f_out_log = request.getParameter("f_out_log");

		if (f_out_log != null && !f_out_log.isEmpty() && f_out_log.equalsIgnoreCase("f_out_log")) {
			request.getSession().invalidate();

			request.getRequestDispatcher(w_login.getPag_inicial()).forward(request, response);

		} else {
			doPost(request, response);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		try {
			w_login.setTx1(request.getParameter("l_usu"));
			w_login.setTx2(request.getParameter("l_sen"));
			String web_url = request.getParameter("url");

			if (w_login.getTx1() == null || w_login.getTx1().isEmpty() || w_login.getTx2() == null
					|| w_login.getTx2().isEmpty()) {

				request.setAttribute("msg_erro", "Campo faltando Preenchimento");
				request.getRequestDispatcher(w_login.getPag_inicial()).forward(request, response);

			} else {

				if (f_blio.val_str2(w_login.getWin1(), w_login.getC1l(), w_login.getTx1(), w_login.getC2l(),
						w_login.getTx2()) == true) {

					cl_sis_log = f_sis_login.cons_sis_log_l_usu(w_login.getTx1(), w_login.getTx2());
					cl_sis_d_log = f_sis_login.cons_sis_d_log_id_sis_log(cl_sis_log.getId_sis_log());

					cl_sis_dom = f_sis_dom.cons_sis_dom_id_sis_dom(cl_sis_log.getId_sis_dom());
					cl_sis = f_sis.cons_titulo_web(cl_sis_log.getId_sis());
					cl_perm_ace = f_sis_login.cons_perm_ace_id_sis_log(cl_sis_log.getId_sis_log());

					request.getSession().setAttribute("id_sis_pre", cl_sis_log.getId_sis());
					request.getSession().setAttribute("id_sis_dom_pre", cl_sis_dom.getId_sis_dom());
					request.getSession().setAttribute("id_sis_log_pre", cl_sis_log.getId_sis_log());
					request.getSession().setAttribute("web_url_pre", cl_sis_dom.getSis_url());
					request.getSession().setAttribute("h_titulo_pagina", cl_sis.getTitulo_web());
					request.getSession().setAttribute("h_titulo_web", cl_sis.getTitulo_web());
					request.getSession().setAttribute("l_usu_pre", w_login.getTx1());
					request.getSession().setAttribute("h_titulo_pagina_ini", cl_sis.getTitulo_web());
					request.getSession().setAttribute("h_titulo_web_ini", cl_sis.getTitulo_web());

					if (web_url == null || web_url.equals("null") || web_url.isEmpty()) {
						web_url = w_login.getWeb_publ();
					}

					String usu_comp = cl_sis_d_log.getNome_desc();
					String usu_nome = usu_comp.contains(" ") ? usu_comp.substring(0, usu_comp.indexOf(" ")) : usu_comp;
					request.getSession().setAttribute("usu_html", usu_nome);
					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("aces_desv", cl_perm_ace.getAces_desv());

					request.getSession().setAttribute("cons_true", "false");
					request.getSession().setAttribute("cons_false", "true");

					request.getRequestDispatcher(cl_sis_dom.getSis_url()).forward(request, response);

				} else {
					if (f_blio.val_str1(w_login.getWin1(), w_login.getC1l(), w_login.getTx1()) == false) {
						request.setAttribute("msg_erro", "Login do Usuario Incorrento");

					} else {
						if (f_blio.val_str1(w_login.getWin1(), w_login.getC2l(), w_login.getTx2()) == false) {
							request.setAttribute("msg_erro", "Senha Incorrenta");

						}

					}
					request.getSession().setAttribute("h_titulo_pagina", "SET DEV");
					request.getRequestDispatcher(w_login.getPag_inicial()).forward(request, response);

				}

			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			request.getSession().setAttribute("h_titulo_pagina", "SET DEV - ERRO LOGIN - " + e.getMessage());
			request.getRequestDispatcher(w_login.getPag_inicial()).forward(request, response);

		}

	}

}
