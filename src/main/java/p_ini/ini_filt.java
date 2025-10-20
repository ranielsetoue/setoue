package p_ini;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import cbd.pos_cbd;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class ini_filt
 */
@WebFilter("/00_controle/*")
public class ini_filt extends HttpFilter implements Filter {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static Connection con_pos_cbd;

	/**
	 * @see HttpFilter#HttpFilter()
	 */
	public ini_filt() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		try {
			con_pos_cbd.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		try {

			HttpServletRequest req = (HttpServletRequest) request;
			HttpSession session = req.getSession();

			String l_usu_pre = (String) session.getAttribute("l_usu_pre");
			String urlParaAutenticar = req.getServletPath();

			if (l_usu_pre == null && !urlParaAutenticar.equalsIgnoreCase("/00_controle/lt_sis_log")) {

				request.setAttribute("msg", "Por favor realize o login!");
				request.getRequestDispatcher("/index.jsp?=url" + urlParaAutenticar).forward(request, response);

				return;

			} else {

				chain.doFilter(request, response);

			}

			con_pos_cbd.commit();
		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("/00_controle/erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);

			try {
				con_pos_cbd.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			// TODO: handle exception
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
		con_pos_cbd = pos_cbd.getPos_cbd();

	}

}
