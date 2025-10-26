package func;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cbd.pos_cbd;
import cla.cla_sis;
import cla.cla_tab_bc;

public class fun_tb {

	private static Connection pos_cbd_con;

	public fun_tb() {
		pos_cbd_con = pos_cbd.getPos_cbd();
		// TODO Auto-generated constructor stub
	}

	

	public cla_tab_bc cons_tb(String tx1) throws Exception {

		cla_tab_bc gra_inp = new cla_tab_bc();

		String bc_sql = "select * FROM tb_tab_bc where cont_sis = '" + tx1 + "'";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_sis = gra_bus.executeQuery();

		while (cl_sis.next()) {

			gra_inp.setTabela(cl_sis.getString("tabela"));
			gra_inp.setSequencia(cl_sis.getString("sequencia"));
			gra_inp.setCont_sis(cl_sis.getString("cont_sis"));
		}

		return gra_inp;

	}

	
}
