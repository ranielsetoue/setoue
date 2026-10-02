package lt;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import api_ext.api_cnpj;
import cla.cla_cnpj;
import cla.cla_glo_ad;
import cla.cla_list_cnpj_nome;
import cla.cla_list_tipo_ace;
import cla.cla_list_tp_site;
import cla.cla_perm_ace;
import cla.cla_sis;
import cla.cla_sis_cont;
import cla.cla_sis_d_log;
import cla.cla_sis_dom;
import cla.cla_sis_log;
import func.fun_blio;
import func.fun_clin;
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
	fun_sis_cont f_sis_cont = new fun_sis_cont();
	fun_clin f_clin = new fun_clin();
	cla_glo_ad cl_glo_ad = new cla_glo_ad();

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
			request.getSession().setAttribute("list_cons_ocult", false);

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
				if ("cad_cli".equals(request.getSession().getAttribute("cont_sis"))) {

					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", "false");
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_cli");
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO CLIENTE");
					request.getSession().setAttribute("tab_cont_ocult", true);

					long id_sis = Long.valueOf(request.getSession().getAttribute("id_sis_pre").toString());

					List<cla_list_cnpj_nome> sisCons = f_clin.cons_list_cnpj(id_sis);
					request.setAttribute("sis_cons", sisCons);

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
			request.getSession().setAttribute("naoexitedado", false);
			request.getSession().setAttribute("list_cons_ocult", false);

			String id_log = String.valueOf(request.getSession().getAttribute("id_sis_log_pre"));
			request.getSession().setAttribute("insc_ocult", true);

			if (request.getParameter("fun").equalsIgnoreCase("pag_cont")) {

				if ("cad_sis".equals(request.getSession().getAttribute("cont_sis"))) {

					String cont_cnpj_cpf = request.getParameter("cont_cnpj_cpf");
					cl_sis = f_sis.cons_sis_cnpj_cpf(cont_cnpj_cpf);
					String cont_bus_cont = request.getParameter("cont_bus_cont");

					int offsetcont = Integer.parseInt(request.getParameter("offset"));
					List<cla_sis_cont> cont_sis_list = f_sis_cont.list_sis_cont_proc(cl_sis.getId_sis(), offsetcont,
							cont_bus_cont);
					request.setAttribute("cont_list", cont_sis_list);
					StringBuilder html = new StringBuilder();

					for (cla_sis_cont d : cont_sis_list) {

						html.append("<tr>");

						html.append("<td>").append(d.getNome_desc()).append("</td>");

						html.append("<td>").append(d.getTel_1()).append("</td>");

						html.append("<td>").append(d.getEmail_1()).append("</td>");

						html.append("<td>").append("<a onclick=\"exc_cont(").append(d.getId_sis_cont())
								.append(", this); return false;\" class=\"btn btn-danger\">Excluir</a>")
								.append("</td>");

						html.append("<td>").append("<button type='button' ").append("onclick=\"detalhe_cont(this)\" ")
								.append("data-nome_desc=\"").append(d.getNome_desc()).append("\" ")
								.append("data-tel_1=\"").append(d.getTel_1()).append("\" ").append("data-tel_2=\"")
								.append(d.getTel_2()).append("\" ").append("data-email_1=\"").append(d.getEmail_1())
								.append("\" ").append("data-email_2=\"").append(d.getEmail_2()).append("\" ")
								.append("data-setor_1=\"").append(d.getSetor_1()).append("\" ").append("data-obs=\"")
								.append(d.getObs()).append("\" ").append("class=\"btn btn-warning\" ")
								.append("data-bs-toggle=\"modal\">").append("Detalhes").append("</button>")
								.append("</td>");

						html.append("</tr>");
					}

					response.setContentType("text/html;charset=UTF-8");
					response.getWriter().print(html.toString());

					return;

				}

			}

			if (request.getParameter("fun").equalsIgnoreCase("pag_dom")) {

				if ("cad_sis".equals(request.getSession().getAttribute("cont_sis"))) {

					int offset = Integer.parseInt(request.getParameter("offset"));

					String dom_cnpj_cpf = request.getParameter("dom_cnpj_cpf");
					String cont_no_dom = request.getParameter("cont_no_dom");

					cl_sis = f_sis.cons_sis_cnpj_cpf(dom_cnpj_cpf);

					List<cla_sis_dom> dominio_list = f_sis_dom.cons_dom_proc(cl_sis.getId_sis(), offset, cont_no_dom);
					/*
					 * List<cla_sis_dom> dominio_list = f_sis_dom.cons_dom_id_p1(cl_sis.getId_sis(),
					 * offset);
					 */

					request.setAttribute("dom_list", dominio_list);

					StringBuilder html = new StringBuilder();

					for (cla_sis_dom d : dominio_list) {

						html.append("<tr>");

						html.append("<td>").append(d.getNo_dom()).append("</td>");

						html.append("<td>").append("<a onclick=\"exc_dom(").append(d.getId_sis_dom())
								.append(", this); return false;\" class=\"btn btn-danger\">Excluir</a>")
								.append("</td>");

						html.append("<td>").append("<button type='button' ").append("id='adicionar_dom' ")
								.append("onclick=\"detalhe_dom(this)\" ").append("data-no_dom=\"").append(d.getNo_dom())
								.append("\" ").append("data-sis_url=\"").append(d.getSis_url()).append("\" ")
								.append("data-tp_sit=\"").append(d.getTp_sit()).append("\" ")
								.append("data-titulo_web=\"").append(d.getTitulo_web()).append("\" ")
								.append("data-ace_per_aut=\"").append(d.getAce_per_aut()).append("\" ")
								.append("data-nome_desc=\"").append(d.getNome_desc()).append("\" ")
								.append("data-email_1=\"").append(d.getEmail_1()).append("\" ").append("data-l_usu=\"")
								.append(d.getL_usu()).append("\" ").append("data-l_sen=\"").append(d.getL_sen())
								.append("\" ").append("class=\"btn btn-warning\" ").append("data-bs-toggle=\"modal\">")
								.append("Detalhes").append("</button>").append("</td>");
					}

					response.setContentType("text/html;charset=UTF-8");
					response.getWriter().print(html.toString());

					return;
				}
			}
			
			if (request.getParameter("fun").equalsIgnoreCase("pag_cons")) {

				
				if ("cad_sis".equals(request.getSession().getAttribute("cont_sis"))) {

					int offset = Integer.parseInt(request.getParameter("offset"));

					String cons_tx1 = request.getParameter("cons");
					long id_sis = Long.valueOf(request.getSession().getAttribute("id_sis_pre").toString());

					cl_sis = f_sis.cons_sis_cnpj_cpf(cons_tx1);

					List<cla_sis> list_cons = f_sis.list_sis_cons(id_sis, offset,cons_tx1); // Simplificado
		            request.setAttribute("list_cons_dado", list_cons); // <-- AQUI ESTÁ A MUDANÇA
		            request.getSession().setAttribute("list_cons_ocult", true);
	
		            
					List<cla_sis> cons_list_qt = f_sis.sis_list_qt(cl_sis.getId_sis());
					request.setAttribute("cons_list_qt", cons_list_qt);
		            
					
					
					StringBuilder html = new StringBuilder();

					for (cla_sis d : list_cons) {

						html.append("<tr>");

						
						html.append("<td>").append(d.getCnpj_cpf()).append("</td>");
						html.append("<td>").append(d.getNome_desc()).append("</td>");
						html.append("<td>").append(d.getNo_fan()).append("</td>");

						html.append("<td>").append("<a onclick=\"sel_cons(").append(d.getCnpj_cpf())
								.append(", this); return false;\" class=\"btn btn-danger\">Selecionarr</a>")
								.append("</td>");


					}

					response.setContentType("text/html;charset=UTF-8");
					response.getWriter().print(html.toString());

					return;
				}
				
				
				
				if ("cad_cli".equals(request.getSession().getAttribute("cont_sis"))) {

					int offset = Integer.parseInt(request.getParameter("offset"));

					String cons_tx1 = request.getParameter("cons");
					long id_sis = Long.valueOf(request.getSession().getAttribute("id_sis_pre").toString());

					cl_sis = f_clin.cons_clin(id_sis,cons_tx1 );

					List<cla_sis> list_cons = f_clin.list_clin_cons(id_sis, offset,cons_tx1); // Simplificado
		            request.setAttribute("list_cons_dado", list_cons); // <-- AQUI ESTÁ A MUDANÇA
		            request.getSession().setAttribute("list_cons_ocult", true);
	
		            int cons_list_qt  = f_clin.cli_list_qt(id_sis,cons_tx1);
					request.setAttribute("cons_list_qt", cons_list_qt);
	

					StringBuilder html = new StringBuilder();

					for (cla_sis d : list_cons) {

						html.append("<tr>");

						
						html.append("<td>").append(d.getCnpj_cpf()).append("</td>");
						html.append("<td>").append(d.getNome_desc()).append("</td>");
						html.append("<td>").append(d.getNo_fan()).append("</td>");

						html.append("<td>").append("<a onclick=\"sel_cons(").append(d.getCnpj_cpf())
								.append(", this); return false;\" class=\"btn btn-danger\">Selecionarr</a>")
								.append("</td>");


					}

					response.setContentType("text/html;charset=UTF-8");
					response.getWriter().print(html.toString());

					return;
				}
				
				
				
			}


			if (request.getParameter("fun").equalsIgnoreCase("Buscar")) {
				request.getSession().setAttribute("naoexitedado", false);
				request.getSession().setAttribute("cons_list", true);
				request.getSession().setAttribute("ocul_excluir", false);

				List<cla_list_tp_site> sisConstp_site = f_sis.cons_list_sis_tp_site();
				request.setAttribute("sis_cons_tp_site", sisConstp_site);
				List<cla_list_tipo_ace> sisConstipoace = f_sis.cons_list_tipo_ace();
				request.setAttribute("sis_cons_tip_ace", sisConstipoace);

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
				request.getSession().setAttribute("tab_dom_ocult", false);

				if ("cad_sis".equals(request.getSession().getAttribute("cont_sis"))) {
					request.getSession().setAttribute("aces_cad_sis", "false");
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_sis");
					request.getSession().setAttribute("cons_dom", true);
					request.getSession().setAttribute("tab_dom_ocult", true);
					request.getSession().setAttribute("tab_cont_ocult", true);
					request.getSession().setAttribute("ocul_excluir", true);

					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO SISTEMA");
					request.getSession().setAttribute("cons_true", true);

					Boolean simnaosis = true;
					cl_glo_ad.vz_id();
					cl_sis.vz_id();
					cl_sis.setId_sis(0l);
					cl_sis.setClin_id(0l);
					cl_sis_log.setId_sis(0l);

					long id_sis = Long.valueOf(request.getSession().getAttribute("id_sis_pre").toString());
					request.getSession().setAttribute("insc_ocult", true);

					String t_cnpj_cpf = request.getParameter("bus_cnpj_cpf");

					if (fun_blio.isCNPJ(t_cnpj_cpf)) {
						if (f_sis.val_str1_sis_cnpj_cpf(t_cnpj_cpf)) {
							cl_sis = f_sis.cons_sis_cnpj_cpf(t_cnpj_cpf);
							cl_glo_ad = f_sis.cons_sis_adi(cl_sis.getId_sis());
						} else {

							cl_sis.setId_sis(id_sis);
							cl_sis.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
							cl_sis.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
							cl_sis.setReg_alt(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
							cl_sis.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
							cl_sis.setTruefalse(false);
							cl_sis.setAce_per_aut("CLIENTE");

							cla_cnpj cl_cnpj = api_cnpj.cons_cnpj(t_cnpj_cpf);
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
							cl_glo_ad.setEmail_2(cl_cnpj.getEmail());
							cl_glo_ad.setTel_2(cl_cnpj.getTelefone());
							cl_sis.setClin_id(0l);

							cl_sis = f_sis.sav_sis(cl_sis);

							cl_glo_ad.setId_sis(id_sis);
							cl_glo_ad.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
							cl_glo_ad.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
							cl_glo_ad.setReg_alt(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
							cl_glo_ad.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
							cl_glo_ad.setTruefalse(false);
							cl_glo_ad.setClin_id(0L);

							cl_glo_ad = f_sis.sav_sis_adi(cl_glo_ad);

						}
					} else {

						if (fun_blio.isCPF(t_cnpj_cpf)) {
							request.getSession().setAttribute("insc_ocult", false);
							if (f_sis.val_str1_sis_cnpj_cpf(t_cnpj_cpf)) {
								cl_sis = f_sis.cons_sis_cnpj_cpf(t_cnpj_cpf);
								cl_glo_ad = f_sis.cons_sis_adi(cl_sis.getId_sis());

								request.getSession().setAttribute("pre_glo", cl_sis);

								request.getSession().setAttribute("pre_glo_ad", cl_glo_ad);

							} else {

								cl_sis.setId_sis(id_sis);
								cl_sis.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
								cl_sis.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
								cl_sis.setReg_alt(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
								cl_sis.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
								cl_sis.setTruefalse(false);
								cl_sis.setAce_per_aut("CLIENTE");
								cl_sis.setCnpj_cpf(t_cnpj_cpf);
								cl_sis.setNome_desc(t_cnpj_cpf);

								cl_sis.setClin_id(0l);

								cl_sis = f_clin.sav_clin(cl_sis);

								cl_glo_ad.setId_sis(id_sis);
								cl_glo_ad.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
								cl_glo_ad.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
								cl_glo_ad.setReg_alt(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
								cl_glo_ad.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
								cl_glo_ad.setTruefalse(false);
								cl_glo_ad.setClin_id(0L);

								cl_glo_ad = f_sis.sav_sis_adi(cl_glo_ad);

							}
						} else {

							cl_glo_ad.vz_id();
							cl_sis.vz_id();
							cl_sis.setId_sis(0l);
							cl_sis.setClin_id(0l);
							cl_sis_log.setId_sis(0l);
							request.getSession().setAttribute("cons_list", false);
							request.getSession().setAttribute("cons_true", false);
							request.getSession().setAttribute("cons_false", "true");
							request.getSession().setAttribute("tab_cont_ocult", false);
							request.getSession().setAttribute("insc_ocult", false);
							simnaosis = false;
							List<cla_list_cnpj_nome> sisCons = f_clin.cons_list_cnpj(id_sis);
							request.setAttribute("sis_cons", sisCons);
							
							Integer sis_qt = f_sis.val_sis_nome(t_cnpj_cpf);

							if (sis_qt > 0) {

								if (sis_qt == 1) {
									cl_sis = f_sis.cons_sis_like(t_cnpj_cpf);
									cl_glo_ad = f_sis.cons_sis_adi(cl_sis.getId_sis());
									simnaosis = true;

									request.getSession().setAttribute("cons_list", true);
									request.getSession().setAttribute("cons_true", true);
									request.getSession().setAttribute("cons_false", false);
									request.getSession().setAttribute("tab_cont_ocult", true);

									if (fun_blio.isCNPJ(cl_sis.getCnpj_cpf())) {
										request.getSession().setAttribute("insc_ocult", true);
									}

								} else {
									/*
									 * System.out.println("Encontrado quantidade: " + sis_qt);
									 */
										
									List<cla_sis> list_cons = f_sis.list_sis_cons(id_sis, 0,t_cnpj_cpf); // Simplificado
						            request.setAttribute("list_cons_dado", list_cons); // <-- AQUI ESTÁ A MUDANÇA
						            request.getSession().setAttribute("list_cons", true);
								
								}
							} else {
								request.getSession().setAttribute("naoexitedado", true);
								
							}

						}
					}

					if (simnaosis) {
						request.getSession().setAttribute("pre_glo", cl_sis);

						request.getSession().setAttribute("pre_glo_ad", cl_glo_ad);

						Integer offset = Integer.parseInt("0");
						List<cla_sis_dom> dominio_list = f_sis_dom.cons_dom_id_p1(cl_sis.getId_sis(), offset);
						request.setAttribute("dom_list", dominio_list);
						List<cla_sis_dom> dom_list_qt = f_sis_dom.dom_list_qt(cl_sis.getId_sis());
						request.setAttribute("dom_list_qt", dom_list_qt);

						Integer offsetcont = Integer.parseInt("0");
						List<cla_sis_cont> cont_sis_list = f_sis_cont.list_sis_cont_id(cl_sis.getId_sis(), offsetcont);
						request.setAttribute("cont_list", cont_sis_list);
						List<cla_sis_cont> cont_list_qt = f_sis_cont.cont_list_qt(cl_sis.getId_sis());
						request.setAttribute("cont_list_qt", cont_list_qt);

						request.getSession().setAttribute("cons_true", true);

					}

				} // cad_sis

				if ("cad_cli".equals(request.getSession().getAttribute("cont_sis"))) {
					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", "false");
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_cli");
					request.getSession().setAttribute("tab_cont_ocult", true);
					request.getSession().setAttribute("h_titulo_pagina", "CADASTRO CLIENTE");
					request.getSession().setAttribute("ocul_excluir", true);
					Boolean simnaoclin = true;
					cl_glo_ad.vz_id();
					cl_sis.vz_id();
					cl_sis.setId_sis(0l);
					cl_sis.setClin_id(0l);
					cl_sis_log.setId_sis(0l);

					long id_sis = Long.valueOf(request.getSession().getAttribute("id_sis_pre").toString());
					long id_dom = Long.valueOf(request.getSession().getAttribute("id_sis_dom_pre").toString());
					request.getSession().setAttribute("insc_ocult", true);

					String t_cnpj_cpf = request.getParameter("bus_cnpj_cpf");
					if (fun_blio.isCNPJ(t_cnpj_cpf)) {
						if (f_clin.val_clin(id_sis, t_cnpj_cpf)) {
							cl_sis = f_clin.cons_clin(id_sis, t_cnpj_cpf);
							cl_glo_ad = f_clin.cons_clin_adi(id_sis, cl_sis.getClin_id());

						} else {

							cl_sis.setId_sis(id_sis);
							cl_sis.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
							cl_sis.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
							cl_sis.setReg_alt(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
							cl_sis.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
							cl_sis.setTruefalse(false);
							cl_sis.setAce_per_aut("CLIENTE");

							cla_cnpj cl_cnpj = api_cnpj.cons_cnpj(t_cnpj_cpf);
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
							cl_glo_ad.setEmail_2(cl_cnpj.getEmail());
							cl_glo_ad.setTel_2(cl_cnpj.getTelefone());
							cl_sis.setClin_id(0l);

							cl_sis = f_clin.sav_clin(cl_sis);

							cl_glo_ad.setId_sis(id_sis);
							cl_glo_ad.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
							cl_glo_ad.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
							cl_glo_ad.setReg_alt(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
							cl_glo_ad.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
							cl_glo_ad.setTruefalse(false);
							cl_glo_ad.setClin_id(cl_sis.getClin_id());
							cl_glo_ad.setL_usu(cl_sis.getCnpj_cpf());

							if (cl_glo_ad.getL_sen() == null || cl_glo_ad.getL_sen().trim().isEmpty()) {
								String nh1 = fun_sis_login.gerarSenhaNumerica();
								String nha2 = String.valueOf(nh1); // "99999"
								int nha3 = (nha2.length() - 3) / 2; // (5 - 3) / 2 = 1
								String senha1 = nha2.substring(nha3, nha3 + 3);

								String nhx2 = fun_sis_login.gerarSenhaForte();
								String nha4 = String.valueOf(nhx2); // "99999"
								int nha5 = (nha4.length() - 3) / 2; // (5 - 3) / 2 = 1
								String senha2 = nha4.substring(nha5, nha5 + 3);

								cl_glo_ad.setL_sen(senha1 + senha2);

								if (f_sis_login.val_log_nha(cl_glo_ad.getL_sen())) {

									String anh1 = fun_sis_login.gerarSenhaNumerica();
									String anha2 = String.valueOf(anh1); // "99999"
									int anha3 = (anha2.length() - 3) / 2; // (5 - 3) / 2 = 1
									String asenha1 = anha2.substring(anha3, anha3 + 3);

									String anh2x = fun_sis_login.gerarSenhaForte();
									String anha4 = String.valueOf(anh2x); // "99999"
									int anha5 = (anha4.length() - 3) / 2; // (5 - 3) / 2 = 1
									String asenha2 = nha4.substring(anha5, anha5 + 3);

									cl_glo_ad.setL_sen(asenha1 + asenha2);

								}

							}

							cl_glo_ad = f_clin.sav_clin_adi(cl_glo_ad);

							cl_sis_log.setId_sis(id_sis);
							cl_sis_log.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
							cl_sis_log.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
							cl_sis_log.setReg_alt(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
							cl_sis_log.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
							cl_sis_log.setId_sis_log(cl_glo_ad.getLogin_id());
							cl_sis_log.setId_sis_dom(id_dom);
							cl_sis_log.setL_usu(cl_sis.getCnpj_cpf());
							cl_sis_log.setL_sen(cl_glo_ad.getL_sen());

							cl_sis_log = f_sis_login.sav_login_id(cl_sis_log);

						}
					} else {

						if (fun_blio.isCPF(t_cnpj_cpf)) {
							request.getSession().setAttribute("insc_ocult", false);
							if (f_clin.val_clin(id_sis, t_cnpj_cpf)) {
								cl_sis = f_clin.cons_clin(id_sis, t_cnpj_cpf);
								cl_glo_ad = f_clin.cons_clin_adi(id_sis, cl_sis.getClin_id());

								request.getSession().setAttribute("pre_glo", cl_sis);

								request.getSession().setAttribute("pre_glo_ad", cl_glo_ad);

							} else {

								cl_sis.setId_sis(id_sis);
								cl_sis.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
								cl_sis.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
								cl_sis.setReg_alt(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
								cl_sis.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
								cl_sis.setTruefalse(false);
								cl_sis.setAce_per_aut("CLIENTE");
								cl_sis.setCnpj_cpf(t_cnpj_cpf);
								cl_sis.setNome_desc(t_cnpj_cpf);

								cl_sis.setClin_id(0l);

								cl_sis = f_clin.sav_clin(cl_sis);

								cl_glo_ad.setId_sis(id_sis);
								cl_glo_ad.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
								cl_glo_ad.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
								cl_glo_ad.setReg_alt(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
								cl_glo_ad.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
								cl_glo_ad.setTruefalse(false);
								cl_glo_ad.setClin_id(cl_sis.getClin_id());
								cl_glo_ad.setL_usu(cl_sis.getCnpj_cpf());

								if (cl_glo_ad.getL_sen() == null || cl_glo_ad.getL_sen().trim().isEmpty()) {
									String nh1 = fun_sis_login.gerarSenhaNumerica();
									String nha2 = String.valueOf(nh1); // "99999"
									int nha3 = (nha2.length() - 3) / 2; // (5 - 3) / 2 = 1
									String senha1 = nha2.substring(nha3, nha3 + 3);

									String nhx2 = fun_sis_login.gerarSenhaForte();
									String nha4 = String.valueOf(nhx2); // "99999"
									int nha5 = (nha4.length() - 3) / 2; // (5 - 3) / 2 = 1
									String senha2 = nha4.substring(nha5, nha5 + 3);

									cl_glo_ad.setL_sen(senha1 + senha2);

									if (f_sis_login.val_log_nha(cl_glo_ad.getL_sen())) {

										String anh1 = fun_sis_login.gerarSenhaNumerica();
										String anha2 = String.valueOf(anh1); // "99999"
										int anha3 = (anha2.length() - 3) / 2; // (5 - 3) / 2 = 1
										String asenha1 = anha2.substring(anha3, anha3 + 3);

										String anh2x = fun_sis_login.gerarSenhaForte();
										String anha4 = String.valueOf(anh2x); // "99999"
										int anha5 = (anha4.length() - 3) / 2; // (5 - 3) / 2 = 1
										String asenha2 = nha4.substring(anha5, anha5 + 3);

										cl_glo_ad.setL_sen(asenha1 + asenha2);

									}

								}

								cl_glo_ad = f_clin.sav_clin_adi(cl_glo_ad);

								cl_sis_log.setId_sis(id_sis);
								cl_sis_log.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
								cl_sis_log.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
								cl_sis_log
										.setReg_alt(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
								cl_sis_log.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
								cl_sis_log.setId_sis_log(cl_glo_ad.getLogin_id());
								cl_sis_log.setId_sis_dom(id_dom);
								cl_sis_log.setL_usu(cl_sis.getCnpj_cpf());
								cl_sis_log.setL_sen(cl_glo_ad.getL_sen());

								cl_sis_log = f_sis_login.sav_login_id(cl_sis_log);

							}
						} else {

							cl_glo_ad.vz_id();
							cl_sis.vz_id();
							cl_sis.setId_sis(0l);
							cl_sis.setClin_id(0l);
							cl_sis_log.setId_sis(0l);
							request.getSession().setAttribute("cons_list", false);
							request.getSession().setAttribute("cons_true", false);
							request.getSession().setAttribute("cons_false", "true");
							request.getSession().setAttribute("tab_cont_ocult", false);
							request.getSession().setAttribute("insc_ocult", false);
							simnaoclin = false;
							List<cla_list_cnpj_nome> sisCons = f_clin.cons_list_cnpj(id_sis);
							request.setAttribute("sis_cons", sisCons);

							Integer cli_qt = f_clin.val_cli_nome(id_sis, t_cnpj_cpf);

							if (cli_qt > 0) {

								if (cli_qt == 1) {

									cl_sis = f_clin.cons_clin_like(id_sis, t_cnpj_cpf);
									cl_glo_ad = f_clin.cons_clin_adi(id_sis, cl_sis.getClin_id());
									simnaoclin = true;

									request.getSession().setAttribute("cons_list", true);
									request.getSession().setAttribute("cons_true", true);
									request.getSession().setAttribute("cons_false", false);
									request.getSession().setAttribute("tab_cont_ocult", true);

									if (fun_blio.isCNPJ(cl_sis.getCnpj_cpf())) {
										request.getSession().setAttribute("insc_ocult", true);
									}

								} else {
									/*
									 * System.out.println("Encontrado quantidade: " + cli_qt);
									 */

									int offset = (request.getParameter("offset") != null) 
										    ? Integer.parseInt(request.getParameter("offset")) 
										    : 0;	
																	  								    
									List<cla_sis> list_cons = f_clin.list_clin_cons(id_sis, offset,t_cnpj_cpf); // Simplificado
						            request.setAttribute("list_cons_dado", list_cons); // <-- AQUI ESTÁ A MUDANÇA
						            request.getSession().setAttribute("list_cons_ocult", true);
					
									int cons_list_qt = f_clin.cli_list_qt(id_sis,t_cnpj_cpf);
									request.setAttribute("cons_list_qt", cons_list_qt);
						          
								}

							} else {
								request.getSession().setAttribute("naoexitedado", true);
		
							}

						}
					}

					if (simnaoclin) {
						request.getSession().setAttribute("pre_glo", cl_sis);

						request.getSession().setAttribute("pre_glo_ad", cl_glo_ad);

					}

				} // CADASTRO DE CLIENTE

				if ("cad_forn".equals(request.getSession().getAttribute("cont_sis"))) {
					request.getSession().setAttribute("aces_cad_sis", cl_perm_ace.getAces_cad_sis());
					request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
					request.getSession().setAttribute("aces_cad_forn", "false");
					request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
					request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
					request.getSession().setAttribute("cont_sis", "cad_for");
					request.getSession().setAttribute("cons_dom", false);
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
					request.getSession().setAttribute("cons_dom", false);

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
