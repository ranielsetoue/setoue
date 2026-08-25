package lt;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import com.fasterxml.jackson.databind.ObjectMapper;

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
@WebServlet(urlPatterns = { "/00_controle/lt_modal/", "/lt_modal/" })

public class lt_modal extends HttpServlet {
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
	cla_sis_cont cl_sis_cont = new cla_sis_cont();
	fun_sis_cont f_sis_cont = new fun_sis_cont();

	Calendar calend = Calendar.getInstance();
	SimpleDateFormat formatData = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public lt_modal() {
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

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*
		 * CADASTRO SISTEMA
		 */
		try {

			if ("cad_sis".equals(request.getSession().getAttribute("cont_sis"))) {

				if (request.getParameter("fun").equalsIgnoreCase("busc_dom_modal")) {

					String id_dom = request.getParameter("id_sis_dom");

					cl_sis_dom = f_sis_dom.cons_sis_dom(Long.parseLong(id_dom));

					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");

					ObjectMapper mapper = new ObjectMapper();
					mapper.writeValue(response.getWriter(), cl_sis_dom);

				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}

		/*
		 * CADASTRO SISTEMA
		 */

	}
}
