package lt;

import java.io.IOException;
import java.util.List;

import cla.cla_list_tipo_ace;
import cla.cla_perm_ace;
import cla.cla_sis;
import cla.cla_sis_d_log;
import cla.cla_sis_dom;
import cla.cla_sis_log;
import func.busc_unico;
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
 * Servlet implementation class lt_sis_busc
 */
@WebServlet(urlPatterns = { "/00_controle/lt_sis_busc/", "/lt_sis_busc/" })

public class lt_sis_busc extends HttpServlet {
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

	public lt_sis_busc() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
    protected void ltRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {

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

			if (request.getParameter("fun").equalsIgnoreCase("Buscar")) {
				request.getSession().setAttribute("cons_true", "true");
				request.getSession().setAttribute("cons_false", "false");

				if (String.valueOf(request.getSession().getAttribute("cont_sis")) == "cad_sis") {
					request.getSession().setAttribute("aces_cad_sis", "false");
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_sis");
					
					
					List<cla_sis> lista = busc_unico.busca("tb_sis", "a", cla_sis.class);
					// Define o atributo de sessão: 1 se houver apenas 1 resultado, 2 se houver mais de 1
					int b1Value = (lista.size() > 1) ? 2 : 1;
				    
					if (b1Value == 1) {
						
						request.getSession().setAttribute("listaResultados", lista);
						
						
					}else {
						 
						request.getSession().setAttribute("listaResultados", lista);

					}
					
					
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO SISTEMA");

				}
				if (String.valueOf(request.getSession().getAttribute("cont_sis")) == "cad_clin") {
					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", "false");
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_cli");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO CLIENTE");
				}
				if (String.valueOf(request.getSession().getAttribute("cont_sis")) == "cad_forn") {
					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", "false");
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_for");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO FORNECEDOR");
				}
				if (String.valueOf(request.getSession().getAttribute("cont_sis")) == "cad_prod") {
					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", "false");
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_pro");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO PRODUTO");

				}
				if (String.valueOf(request.getSession().getAttribute("cont_sis")) == "cad_serv") {
					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", "false");
					request.getSession().setAttribute("cont_sis", "cad_serv");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO SERVICO");
				}
				if (String.valueOf(request.getSession().getAttribute("cont_sis")) == "cad_prod"
						|| (String.valueOf(request.getSession().getAttribute("cont_sis")) == "cad_serv")) {
					request.getRequestDispatcher("/00_controle/00_sistema/cadastro/cad_pro_serv.jsp").forward(request,
							response);

				} else {
					request.getRequestDispatcher("/00_controle/00_sistema/cadastro/cad.jsp").forward(request, response);

				}

			}

			if (request.getParameter("fun").equalsIgnoreCase("Novo")) {

				request.getSession().setAttribute("cons_true", "false");
				request.getSession().setAttribute("cons_false", "true");

				if (String.valueOf(request.getSession().getAttribute("cont_sis")) == "cad_sis") {
					request.getSession().setAttribute("aces_cad_sis", "false");
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_sis");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO SISTEMA");

				}
				if (String.valueOf(request.getSession().getAttribute("cont_sis")) == "cad_clin") {
					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", "false");
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_cli");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO CLIENTE");
				}
				if (String.valueOf(request.getSession().getAttribute("cont_sis")) == "cad_forn") {
					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", "false");
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_for");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO FORNECEDOR");
				}
				if (String.valueOf(request.getSession().getAttribute("cont_sis")) == "cad_prod") {
					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", "false");
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_pro");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO PRODUTO");

				}
				if (String.valueOf(request.getSession().getAttribute("cont_sis")) == "cad_serv") {
					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", "false");
					request.getSession().setAttribute("cont_sis", "cad_serv");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO SERVICO");
				}
				if (String.valueOf(request.getSession().getAttribute("cont_sis")) == "cad_prod"
						|| (String.valueOf(request.getSession().getAttribute("cont_sis")) == "cad_serv")) {
					request.getRequestDispatcher("/00_controle/00_sistema/cadastro/cad_pro_serv.jsp").forward(request,
							response);

				} else {
					request.getRequestDispatcher("/00_controle/00_sistema/cadastro/cad.jsp").forward(request, response);

				}

			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			request.getSession().setAttribute("h_titulo_pagina", "SET DEV - ERRO BUSCAR" + e.getMessage());
			request.getRequestDispatcher(w_login.getPag_inicial()).forward(request, response);

		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ltRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ltRequest(request, response);
    }
}
