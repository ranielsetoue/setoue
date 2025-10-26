package lt;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import cla.cla_list_cnpj_nome;
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

@WebServlet(urlPatterns = { "/00_controle/lt_dev/", "/lt_dev/" })
public class lt_dev extends HttpServlet {
    private static final long serialVersionUID = 1L;

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

    public lt_dev() {
        super();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fun = request.getParameter("fun");
        String paginaDestino = null;

        try {
            cl_perm_ace = f_sis_login.cons_perm_ace_id_sis_log(
                    Long.parseLong(String.valueOf(request.getSession().getAttribute("id_sis_log_pre"))));

            // Configura permissões e flags de sessão
            request.getSession().setAttribute("aces_cad_sis", "false");
            request.getSession().setAttribute("aces_cad_clin", cl_perm_ace.getAces_cad_clin());
            request.getSession().setAttribute("aces_cad_forn", cl_perm_ace.getAces_cad_forn());
            request.getSession().setAttribute("aces_cad_prod", cl_perm_ace.getAces_cad_prod());
            request.getSession().setAttribute("aces_cad_serv", cl_perm_ace.getAces_cad_serv());
            request.getSession().setAttribute("aces_dev", cl_perm_ace.getAces_desv());

            request.getSession().setAttribute("cons_true", "false");
            request.getSession().setAttribute("cons_false", "true");
            request.getSession().setAttribute("cont_sis", "cad_sis");
            
            List<cla_list_cnpj_nome> sisCons = f_sis.cons_list_sis_cnpj();
            request.setAttribute("sis_cons", sisCons);

            
            String termo = request.getParameter("termo");
            List<cla_sis> lista = new ArrayList<>();

            if (termo != null && !termo.isBlank()) {
                // Busca os dados
                lista = busc_unico.busca("tb_sis", termo, cla_sis.class);

                if (lista.size() == 1) {
                    request.getSession().setAttribute("b1", "1");
                } else if (lista.size() > 1) {
                    request.getSession().setAttribute("b1", "2");
                }
            }

            request.setAttribute("listaResultados", lista);

            // Define a página de destino
            if ("buscar_dado".equalsIgnoreCase(fun)) {
                request.getSession().setAttribute("h_titulo_pagina", "Buscar Dado");
                paginaDestino = "/00_controle/00_sistema/modelo/busca2.jsp";
            } else if ("pg_ini".equalsIgnoreCase(fun)) {
                request.getSession().setAttribute("h_titulo_pagina", "Pagina Inicial");
                paginaDestino = "/00_controle/00_sistema/modelo/pag_ini.jsp";
            } else if ("buscar1".equalsIgnoreCase(fun)){
                // Função desconhecida
                request.getSession().setAttribute("h_titulo_pagina", "Página Inicial Padrão");
                paginaDestino = "/00_controle/00_sistema/modelo/busca1.jsp";
            }else{
                request.getSession().setAttribute("h_titulo_pagina", "ERRO FUN VAZIO");
                paginaDestino = w_login.getPag_inicial();
            	
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("h_titulo_pagina", "ERRO: " + e.getMessage());
            paginaDestino = w_login.getPag_inicial();
        }

        // Faz o forward apenas uma vez
        if (paginaDestino != null) {
            request.getRequestDispatcher(paginaDestino).forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
