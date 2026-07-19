package lt;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import cla.cla_bc_cam;
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
import func.fun_sis_d_log;
import func.fun_sis_dom;
import func.fun_sis_login;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import st.win_login;

/**
 * Servlet implementation class lt_sis_salvar
 */
@WebServlet(urlPatterns = { "/00_controle/lt_sis_salvar/", "/lt_sis_salvar/" })

public class lt_sis_salvar extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */

	win_login w_login = new win_login();

	fun_blio f_blio = new fun_blio();
	fun_sis_login f_sis_login = new fun_sis_login();
	fun_sis_d_log f_sis_d_log = new fun_sis_d_log();

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

	
	public lt_sis_salvar() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		String t_nome_desc = request.getParameter("nome_desc");
		String t_no_fan = request.getParameter("no_fan");
		String t_cnpj_cpf = request.getParameter("cnpj_cpf");
		String t_end_rua = request.getParameter("end_rua");
		String t_end_num = request.getParameter("end_num");
		String t_end_com = request.getParameter("end_com");
		String t_end_bar = request.getParameter("end_bar");
		String t_end_mun = request.getParameter("end_mun");
		String t_end_uf = request.getParameter("end_uf");
		String t_end_cep = request.getParameter("end_cep");
		String t_ins_est = request.getParameter("ins_est");
		String t_ins_mun = request.getParameter("ins_mun");
		String t_tel_1 = request.getParameter("tel_1");
		String t_email_1 = request.getParameter("email_1");
		String t_obs = request.getParameter("obs");

		try {
			if (request.getParameter("fun").equalsIgnoreCase("salvar")) {
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

					cl_sis = f_sis.cons_sis_cnpj_cpf(t_cnpj_cpf);

					String id_log = String.valueOf(request.getSession().getAttribute("id_sis_log_pre"));

					cl_sis.setId_sis(cl_sis.getId_sis());
					cl_sis.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
					cl_sis.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
					cl_sis.setReg_alt(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
					cl_sis.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
					cl_sis.setTruefalse(false);
					cl_sis.setNome_desc(t_nome_desc);
					cl_sis.setNo_fan(t_no_fan);
					cl_sis.setCnpj_cpf(t_cnpj_cpf);
					cl_sis.setEnd_rua(t_end_rua);
					cl_sis.setEnd_num(t_end_num);
					cl_sis.setEnd_com(t_end_com);
					cl_sis.setEnd_bar(t_end_bar);
					cl_sis.setEnd_mun(t_end_mun);
					cl_sis.setEnd_uf(t_end_uf);
					cl_sis.setEnd_cep(t_end_cep);
					cl_sis.setIns_est(t_ins_est);
					cl_sis.setIns_mun(t_ins_mun);
					cl_sis.setTel_1(t_tel_1);
					cl_sis.setEmail_1(t_email_1);
					cl_sis.setObs(t_obs);

					f_sis.sav_sis(cl_sis);

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

				/*
				 * 
				 * if ("cad_prod".equals(request.getSession().getAttribute("cont_sis")) ||
				 * ("cad_serv".equals(request.getSession().getAttribute("cont_sis")))) {
				 * request.getRequestDispatcher(
				 * "/00_controle/00_sistema/cadastro/cad_pro_serv.jsp").forward(request,
				 * response);
				 * 
				 * } else {
				 * request.getRequestDispatcher("/00_controle/00_sistema/cadastro/cad.jsp").
				 * forward(request, response);
				 * 
				 * }
				 * 
				 */

			}
			
			/*
			 * salvar_dominio
			 */

			if (request.getParameter("fun").equalsIgnoreCase("salvar_dom")) {
				
				if ("cad_sis".equals(request.getSession().getAttribute("cont_sis"))) {

					String t_no_dom = request.getParameter("no_dom");
					String t_sis_url = request.getParameter("sis_url");
					String t_sis_tp_site = request.getParameter("sis_tp_site");
					String t_titulo_web = request.getParameter("titulo_web");
					String t_sis_tipo_ace = request.getParameter("sis_tipo_ace");
					String t_nome_desc_usu = request.getParameter("nome_desc_usu");
					String t_email_1_usu = request.getParameter("email_1_usu");
					String t_l_usu = request.getParameter("l_usu");
					String t_l_sen = request.getParameter("l_sen");
					boolean modal_dominio_visivel = false;
					String msg_tela = "Cadastro Já Existe";
					boolean SIMNAO = false;

					cl_sis = f_sis.cons_sis_cnpj_cpf(t_cnpj_cpf);

					long id_sis = cl_sis.getId_sis();

				
					
					if (f_sis_dom.val_str1_sis_dom_no_dom(t_no_dom) == false 
							&& f_sis_login.val_login(t_l_usu) == false
							&& f_sis_login.val_login_email(id_sis,t_email_1_usu) == false
							&& f_sis_login.val_login_Nome(id_sis,t_nome_desc_usu) == false) {

	/*
	 * 					
						System.out.println("------");

						System.out.println("Novo"); 
						 * 					
						 */


						String id_log = String.valueOf(request.getSession().getAttribute("id_sis_log_pre"));

						cl_sis_dom.setId_sis(id_sis);
						cl_sis_dom.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
						cl_sis_dom.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
						cl_sis_dom.setReg_alt(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
						cl_sis_dom.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
						cl_sis_dom.setId_sis_dom(0L);   
						cl_sis_dom.setNo_dom(t_no_dom);
						cl_sis_dom.setSis_url(t_sis_url);
						cl_sis_dom.setTp_sit(t_sis_tp_site);
						cl_sis_dom.setTitulo_web(t_titulo_web);
						cl_sis_dom.setAce_per_aut(t_sis_tipo_ace);
						cl_sis_dom.setNome_desc(t_nome_desc_usu);
						cl_sis_dom.setEmail_1(t_email_1_usu);
						cl_sis_dom.setId_sis_log(0L);
						cl_sis_dom.setL_usu(t_l_usu);
						cl_sis_dom.setL_sen(t_l_sen);

								cl_sis_dom = f_sis_dom.sav_dom(cl_sis_dom,cl_sis_log);
							
								cl_sis_log.setId_sis(cl_sis_dom.getId_sis());
								cl_sis_log.setReg_id(cl_sis_dom.getReg_id());
								cl_sis_log.setReg_data(cl_sis_dom.getReg_data());
								cl_sis_log.setReg_alt(cl_sis_dom.getReg_alt());
								cl_sis_log.setReg_data_alt(cl_sis_dom.getReg_data_alt());
								cl_sis_log.setId_sis_dom(cl_sis_dom.getId_sis_dom());   
								cl_sis_log.setId_sis_log(cl_sis_dom.getId_sis_log());
								cl_sis_log.setL_usu(cl_sis_dom.getL_usu());
								cl_sis_log.setL_sen(cl_sis_dom.getL_sen());
								
								cl_sis_log = f_sis_login.sav_login_dom(cl_sis_log);

								/*
								 * cl_sis_d_log = f_sis_dom.id_d_ger(cl_sis_d_log);
								 */
								 
								cl_sis_d_log.setId_sis(id_sis);
								cl_sis_d_log.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
								cl_sis_d_log.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
								cl_sis_d_log.setReg_alt(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
								cl_sis_d_log.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
								cl_sis_d_log.setId_sis_d_log(0L); 
								cl_sis_d_log.setId_sis_log(cl_sis_log.getId_sis_log()); 
								cl_sis_d_log.setNome_desc(t_nome_desc_usu);
								cl_sis_d_log.setEmail_1(t_email_1_usu);
								
								
							  	cl_sis_d_log = f_sis_d_log.sav_d_log(cl_sis_d_log);
							 
							
								
								
						modal_dominio_visivel = true;
						
					} else {
						SIMNAO = false;
						if (f_sis_dom.val_str1_sis_dom_no_dom(t_no_dom) 
								|| f_sis_login.val_login(t_l_usu)
								|| f_sis_login.val_login_email(id_sis,t_email_1_usu)
								|| f_sis_login.val_login_Nome(id_sis,t_nome_desc_usu)) {

							if (f_sis_dom.val_str1_sis_dom_no_dom(t_no_dom)  ) {
								cl_sis_dom = f_sis_dom.cons_sis_dom_no_dom(t_no_dom);
								cl_sis_d_log = f_sis_login.cons_sis_d_log_id_sis_log(cl_sis_dom.getId_sis_log());	
														
										}					else {
											msg_tela = "Cadastro Dominio Já Existe";
											
										}

							
														
							if (f_sis_dom.val_str1_sis_dom_no_dom(t_no_dom) 
									&& cl_sis.getId_sis().equals(cl_sis_dom.getId_sis()) ) {

			
								if (f_sis_login.val_login(t_l_usu) == false
										&& f_sis_login.val_login_email(id_sis,t_email_1_usu) == false
										&& f_sis_login.val_login_Nome(id_sis,t_nome_desc_usu) == false) {

									System.out.println("------");

									System.out.println("Uptade - 1");
									modal_dominio_visivel = true;
									SIMNAO = true;
							
								

								} else {

							
									
									
								    String dom_tx1 = t_l_usu.replaceAll("\\s+", "").toUpperCase(); // remove TODOS os espaços
								    String dom_tx2 = cl_sis_dom.getL_usu().replaceAll("\\s+", "").toUpperCase(); // remove TODOS os espaços

								    

								    
								    
									if (f_sis_login.val_login(t_l_usu) 
											&& dom_tx1.equals(dom_tx2)
											&& f_sis_login.val_login_email(id_sis,t_email_1_usu) == false
											&& f_sis_login.val_login_Nome(id_sis,t_nome_desc_usu) == false) {
										
										System.out.println("------");

										System.out.println("Uptade - 2");
										modal_dominio_visivel = true;
										SIMNAO = true;
									}

								    String dom_tx3 = t_email_1_usu.replaceAll("\\s+", "").toUpperCase(); // remove TODOS os espaços
								    String dom_tx4 = cl_sis_d_log.getEmail_1().replaceAll("\\s+", "").toUpperCase(); // remove TODOS os espaços

									
									if (f_sis_login.val_login(t_l_usu) == false
											&& f_sis_login.val_login_email(id_sis,t_email_1_usu)
											&& dom_tx3.equals(dom_tx4)
											&& f_sis_login.val_login_Nome(id_sis,t_nome_desc_usu) == false) {

										System.out.println("------");

										System.out.println("Uptade - 3");
										modal_dominio_visivel = true;
										SIMNAO = true;
									}

								    String dom_tx5 = t_nome_desc_usu.replaceAll("\\s+", "").toUpperCase(); // remove TODOS os espaços
								    String dom_tx6 = cl_sis_d_log.getNome_desc().replaceAll("\\s+", "").toUpperCase(); // remove TODOS os espaços

									
									if (f_sis_login.val_login(t_l_usu) == false
											&& f_sis_login.val_login_email(id_sis,t_email_1_usu) == false
											&& f_sis_login.val_login_Nome(id_sis,t_nome_desc_usu)
											&& dom_tx5.equals(dom_tx6)) {
										
										System.out.println("------");

										System.out.println("Uptade - 4");
										modal_dominio_visivel = true;
										SIMNAO = true;
									}

									
									if (f_sis_login.val_login(t_l_usu) 
											&& dom_tx1.equals(dom_tx2)
											&& f_sis_login.val_login_email(id_sis,t_email_1_usu)
											&& dom_tx3.equals(dom_tx4)
											&& f_sis_login.val_login_Nome(id_sis,t_nome_desc_usu)
											&& dom_tx5.equals(dom_tx6)) {
									
										System.out.println("------");

										System.out.println("Uptade - 5");
										modal_dominio_visivel = true;
										SIMNAO = true;
									}

									
									if (f_sis_login.val_login(t_l_usu) == false 
											&& f_sis_login.val_login_email(id_sis,t_email_1_usu)
											&& dom_tx3.equals(dom_tx4)
											&& f_sis_login.val_login_Nome(id_sis,t_nome_desc_usu)
											&& dom_tx5.equals(dom_tx6)) {
									
										System.out.println("------");

										System.out.println("Uptade - 6");
										modal_dominio_visivel = true;
										SIMNAO = true;
									}

									if (f_sis_login.val_login(t_l_usu) 
											&& dom_tx1.equals(dom_tx2)
											&& f_sis_login.val_login_email(id_sis,t_email_1_usu) == false
											&& f_sis_login.val_login_Nome(id_sis,t_nome_desc_usu)
											&& dom_tx5.equals(dom_tx6)) {
									
										System.out.println("------");

										System.out.println("Uptade - 7");
										modal_dominio_visivel = true;
										SIMNAO = true;
									}
									
									if (f_sis_login.val_login(t_l_usu) 
											&& dom_tx1.equals(dom_tx2)
											&& f_sis_login.val_login_email(id_sis,t_email_1_usu)
											&& dom_tx3.equals(dom_tx4)
											&& f_sis_login.val_login_Nome(id_sis,t_nome_desc_usu) == false) {
									
										System.out.println("------");

										System.out.println("Uptade - 8");
										modal_dominio_visivel = true;
										SIMNAO = true;
									}

									
									
								}
								
								
								if (SIMNAO) {
									System.out.println("Uptade");
								}

							} else {

			
								
								
									
								if (f_sis_dom.val_str1_sis_dom_no_dom(t_no_dom) == false) {
									modal_dominio_visivel = false;

									if (f_sis_login.val_login(t_l_usu)) {
										msg_tela = "Cadastro Login Já Existe";
									}

									if (f_sis_login.val_login_email(id_sis,t_email_1_usu)) {
										msg_tela = "Cadastro E-mail Já Existe";
									}

									if (f_sis_login.val_login_Nome(id_sis,t_nome_desc_usu)) {
										msg_tela = "Cadastro Nome do Usuario Já Existe";
									}

									
									

									
								}

								if (f_sis_dom.val_str1_sis_dom_no_dom(t_no_dom)) {
									modal_dominio_visivel = false;

										msg_tela = "Cadastro Dominio Já Existe";
									}

								
								
							}

						}

					}

						if (modal_dominio_visivel) {
						response.getWriter().write("{\"status\":\"ok\",\"msg\":\"Dado Atualizado\"}");
					} else {
						response.getWriter().write("{\"status\":\"erro\",\"msg\":\"" + msg_tela + "\"}");

					}

				}

			
				
			}
			/*
			 * salvar_dominio
			 */
			/*
			 * salvar_sis_cont
			 */
			if (request.getParameter("fun").equalsIgnoreCase("salvar_sis_cont")) {
				
				if ("cad_sis".equals(request.getSession().getAttribute("cont_sis"))) {

					String id_log = String.valueOf(request.getSession().getAttribute("id_sis_log_pre"));

	 				String sis_cont_cnpj_cpf = request.getParameter("cnpj_cpf");
					String sis_cont_nome_desc = request.getParameter("cont_nome_desc");
					String sis_cont_tel_1 = request.getParameter("cont_tel_1");
					String sis_cont_tel_2 = request.getParameter("cont_tel_2");
					String sis_cont_email_1 = request.getParameter("cont_email_1");
					String sis_cont_email_2 = request.getParameter("cont_email_2");
					String sis_cont_setor_1 = request.getParameter("cont_setor_1");
					String sis_cont_obs = request.getParameter("cont_obs");
/*
 * Inicio dado para modal					
 */
					boolean modal_dominio_visivel = false;
					String msg_tela = "Cadastro Já Existe";
/*
* Fim dado para modal					
*/
					
					cl_sis = f_sis.cons_sis_cnpj_cpf(sis_cont_cnpj_cpf);
					cl_sis_cont.setId_sis(cl_sis.getId_sis());			
					cl_sis_cont.setReg_id(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
					cl_sis_cont.setReg_data(Timestamp.valueOf(formatData.format(calend.getTime())));
					cl_sis_cont.setReg_alt(id_log != null && !id_log.isEmpty() ? Long.parseLong(id_log) : 0L);
					cl_sis_cont.setReg_data_alt(Timestamp.valueOf(formatData.format(calend.getTime())));
					cl_sis_cont.setId_sis_cont(0L);
					cl_sis_cont.setNome_desc(sis_cont_nome_desc);
					cl_sis_cont.setTel_1(sis_cont_tel_1);
					cl_sis_cont.setTel_2(sis_cont_tel_2);
					cl_sis_cont.setEmail_1(sis_cont_email_1);
					cl_sis_cont.setEmail_2(sis_cont_email_2);
					cl_sis_cont.setSetor_1(sis_cont_setor_1);
					cl_sis_cont.setObs(sis_cont_obs);
					cl_sis_cont.setId_sis_log(0L);
			
					  	cl_sis_cont = f_sis_cont.sav_sis_cont(cl_sis_cont);						
						modal_dominio_visivel = true;
					
					
					if (modal_dominio_visivel) {
						response.getWriter().write("{\"status\":\"ok\",\"msg\":\"Dado Atualizado\"}");
					} else {
						response.getWriter().write("{\"status\":\"erro\",\"msg\":\"" + msg_tela + "\"}");

					}

					
				}

				
				
				
				
			}
			/*
			 * salvar_sis_cont
			 */

			/*
			 * inicio atualizar lista dominio 
			 */

			if (request.getParameter("fun").equalsIgnoreCase("atual_list_sis_dom")) {

 				String dom_cnpj_cpf = request.getParameter("dom_cnpj_cpf");
				cl_sis = f_sis.cons_sis_cnpj_cpf(dom_cnpj_cpf);
				Integer offset = Integer.parseInt("0");
					List<cla_sis_dom> dominio_list = f_sis_dom.cons_dom_id_p1(cl_sis.getId_sis(),offset);
				request.setAttribute("dom_list", dominio_list);	


				    StringBuilder html = new StringBuilder();

				    for(cla_sis_dom d : dominio_list){

				        html.append("<tr>");

				        html.append("<td>")
				            .append(d.getNo_dom())
				            .append("</td>");

				        html.append("<td>")
				        .append("<a onclick=\"exc_dom(")
				        .append(d.getId_sis_dom())
				        .append(", this); return false;\" class=\"btn btn-danger\">Excluir</a>")
				        .append("</td>");

				        html.append("<td>")
				            .append("<button type='button' class='btn btn-warning' ")
				            .append("onclick=\"edit_dom2('")
				            .append(d.getId_sis_dom())
				            .append("');edit_dom1('")
				            .append(d.getSis_url())
				            .append("');edit_dom('")
				            .append(d.getNo_dom())
				            .append("');\">Detalhes</button>")
				            .append("</td>");

				        html.append("</tr>");
				    }

				    response.setContentType("text/html;charset=UTF-8");
				    response.getWriter().print(html.toString());

				    return;

			}			
/*
 * fim atualizar lista dominio 
 */
			
			/*
			 * inicio atualizar Sistema lista Contato 
			 */

			if (request.getParameter("fun").equalsIgnoreCase("atual_list_sis_cont")) {

 				String cont_cnpj_cpf = request.getParameter("cont_cnpj_cpf");
				cl_sis = f_sis.cons_sis_cnpj_cpf(cont_cnpj_cpf);
				Integer offsetcont = Integer.parseInt("0");
					List<cla_sis_cont> cont_sis_list = f_sis_cont.list_sis_cont_id(cl_sis.getId_sis(),offsetcont);
					request.setAttribute("cont_list", cont_sis_list);	

				    StringBuilder html = new StringBuilder();

				    for(cla_sis_cont d : cont_sis_list){

				        html.append("<tr>");

				        html.append("<td>")
				            .append(d.getNome_desc())
				            .append("</td>");

				        html.append("<td>")
			            .append(d.getTel_1())
			            .append("</td>");

				        html.append("<td>")
			            .append(d.getEmail_1())
			            .append("</td>");
				        
				        html.append("<td>")
				        .append("<a onclick=\"exc_cont(")
				        .append(d.getId_sis_cont())
				        .append(", this); return false;\" class=\"btn btn-danger\">Excluir</a>")
				        .append("</td>");

				        html.append("<td>")
				            .append("<button type='button' class='btn btn-warning' ")
				            .append("onclick=\"edit_cont('")
				            .append(d.getId_sis_cont())
				            .append("');edit_cont1('")
				            .append(d.getNome_desc())
				            .append("');edit_cont2('")
				            .append(d.getTel_1())
				            .append("');edit_cont3('")
				            .append(d.getEmail_1())
				            .append("');\">Detalhes</button>")
				            .append("</td>");

				        html.append("</tr>");
				    }

				    response.setContentType("text/html;charset=UTF-8");
				    response.getWriter().print(html.toString());

				    return;

			}			
/*
 * fim atualizar sistema lista Contato 
 */
			
		} catch (Exception e) {
			// TODO: handle exception
		}

	}

}
