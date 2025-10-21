package func;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cbd.pos_cbd;
import cla.cla_sis;

public class fun_sis {
	private static Connection pos_cbd_con;

	public fun_sis() {
		pos_cbd_con = pos_cbd.getPos_cbd();
		// TODO Auto-generated constructor stub
	}

	public cla_sis cons_titulo_web(long id_sis) throws Exception {

		cla_sis gra_inp = new cla_sis();

		String bc_sql = "select titutlo_web FROM tb_sis where id_sis = '" + id_sis + "'";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_sis = gra_bus.executeQuery();

		while (cl_sis.next()) {


			gra_inp.setTitutlo_web(cl_sis.getString("titutlo_web"));

		}

		return gra_inp;

	}

}
