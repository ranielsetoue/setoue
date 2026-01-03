package lt;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import api_ext.api_cnpj;
import cla.cla_cnpj;
import cla.cla_list_cnpj_nome;
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
	Calendar calend = Calendar.getInstance();
	SimpleDateFormat formatData = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

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

			if (request.getParameter("fun").equalsIgnoreCase("novo")) {
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

		try {

			String id_log = String.valueOf(request.getSession().getAttribute("id_sis_log_pre"));

			request.getSession().setAttribute("insc_ocult", true);

			if (request.getParameter("fun").equalsIgnoreCase("Buscar")) {
				request.getSession().setAttribute("cons_list", true);

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

				request.getSession().setAttribute("cons_true", true);
				request.getSession().setAttribute("cons_false", false);
				request.getSession().setAttribute("cons_list_not", false);

				if ("cad_sis".equals(request.getSession().getAttribute("cont_sis"))) {
					request.getSession().setAttribute("aces_cad_sis", "false");
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_sis");

					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO SISTEMA");
					request.getSession().setAttribute("cons_true", true);

					String t_cnpj_cpf = request.getParameter("bus_cnpj_cpf");
					if (fun_blio.isCNPJ(t_cnpj_cpf)) {
						request.getSession().setAttribute("insc_ocult", true);

					} else {
						request.getSession().setAttribute("insc_ocult", false);

					}

					if (t_cnpj_cpf != null) {

						List<cla_sis> lista = busc_unico.busca("tb_sis", t_cnpj_cpf, cla_sis.class);

						int b1Value = (lista.size() > 1) ? 2 : 1;

						if (b1Value == 1) {

							for (cla_sis item : lista) {

								t_cnpj_cpf = item.getCnpj_cpf(); // usando getter

							}

							cl_sis = f_sis.cons_sis_cnpj_cpf(t_cnpj_cpf);

							if (cl_sis.getId_sis() == null || cl_sis.getId_sis() == 0L) {

								if (fun_blio.isCNPJ(t_cnpj_cpf)) {
									cla_cnpj cl_cnpj = api_cnpj.cons_cnpj(t_cnpj_cpf);
									cl_sis.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
									cl_sis.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
									cl_sis.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
									cl_sis.setReg_alt(
											id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
									cl_sis.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
									cl_sis.setCnpj_cpf(cl_cnpj.getCnpj());
									cl_sis.setNome_desc(cl_cnpj.getNome());
									cl_sis.setNo_fan(cl_cnpj.getFantasia());
									cl_sis.setEnd_rua(cl_cnpj.getLogradouro());
									cl_sis.setEnd_num(cl_cnpj.getNumero());
									cl_sis.setEnd_com(cl_cnpj.getComplemento());
									cl_sis.setEnd_bar(cl_cnpj.getBairro());
									cl_sis.setEnd_mun(cl_cnpj.getMunicipio());
									cl_sis.setEnd_uf(cl_cnpj.getUf());
									cl_sis.setEnd_cep(cl_cnpj.getCep());
									cl_sis.setEmail_1(cl_cnpj.getEmail());
									String telefone = cl_cnpj.getTelefone();

									if (telefone != null
											&& telefone.matches("^\\(?\\d{2}\\)?\\s?(?:9\\d{4}|\\d{4})-?\\d{4}$")) {
										// telefones como (11) 98765-4321, 11987654321, (11) 3456-7890
										cl_sis.setTel_1(telefone);
									} else {
										cl_sis.setObs(telefone);
									}

									cl_sis.setTruefalse(false);
									cl_sis.setTipo_ace("CLIENTE");

									f_sis.sav_sis_consultar_refeita_federal(cl_sis);

								} 

								if (fun_blio.isCPF(t_cnpj_cpf)) {

									cl_sis.setCnpj_cpf(t_cnpj_cpf);
									cl_sis.setNome_desc(t_cnpj_cpf);
									cl_sis.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
									cl_sis.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
									cl_sis.setReg_alt(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
									cl_sis.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
									cl_sis.setTruefalse(false);
									cl_sis.setTipo_ace("CLIENTE");

									cl_sis = f_sis.sav_sis_consultar_refeita_federal(cl_sis);	
								}							
							} //if (cl_sis.getId_sis() == null || cl_sis.getId_sis() == 0L) {

							cl_sis = f_sis.cons_sis_cnpj_cpf(t_cnpj_cpf);

							request.getSession().setAttribute("pre_glo", cl_sis);
							request.getSession().setAttribute("cons_true", true);
							
						} // (b1Value == 1)

						if (b1Value > 1) {

							request.getSession().setAttribute("listaResultados", lista);
							request.getSession().setAttribute("cons_true", false);

						} //(b1Value > 1)
						
					} /// 					if (t_cnpj_cpf != null) {

				} // cad_sis

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
				}
				if ("cad_prod".equals(request.getSession().getAttribute("cont_sis"))) {
					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", "false");
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_pro");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO PRODUTO");

				}
				if ("cad_serv".equals(request.getSession().getAttribute("cont_sis"))) {
					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", "false");
					request.getSession().setAttribute("cont_sis", "cad_serv");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO SERVICO");
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
			e.printStackTrace();
			request.getSession().setAttribute("h_titulo_pagina", "SET DEV - ERRO BUSCAR" + e.getMessage());
			request.getRequestDispatcher(w_login.getPag_inicial()).forward(request, response);

		}

	}
}
