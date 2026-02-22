package func;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cbd.pos_cbd;
import cla.cla_sis_dom;

public class fun_sis_dom {

	private static Connection pos_cbd_con;

	public fun_sis_dom() {
		pos_cbd_con = pos_cbd.getPos_cbd();

	}

	public boolean val_str1_sis_dom_no_dom(String tx1) throws Exception {

	    tx1 = tx1.replaceAll("\\s+", ""); // remove TODOS os espaços
	    tx1 = tx1.toUpperCase();

	    String bc_sql =
	        "SELECT  count (1) > 0 as existe " +
	        "FROM tb_sis_dom " +
	        "WHERE REPLACE(UPPER(no_dom),' ','') = UPPER('" + tx1 + "')";

	    PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

	    ResultSet resul = gra_bus.executeQuery();

		resul.next();
		return resul.getBoolean("existe");

	    
		}	
	
	
	public cla_sis_dom cons_sis_dom_id_sis_dom(Long id_sis_log) throws Exception {

		cla_sis_dom gra_inp = new cla_sis_dom();

		String bc_sql = "select * FROM tb_sis_dom where id_sis_log = '" + id_sis_log + "'";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_sis_dom = gra_bus.executeQuery();

		while (cl_sis_dom.next()) {

			gra_inp.setId_sis(cl_sis_dom.getLong("id_sis"));
			gra_inp.setReg_id(cl_sis_dom.getLong("reg_id"));
			gra_inp.setReg_alt(cl_sis_dom.getLong("reg_alt"));
			gra_inp.setId_sis_dom(cl_sis_dom.getLong("id_sis_dom"));
			gra_inp.setNo_dom(cl_sis_dom.getString("no_dom"));
			gra_inp.setSis_url(cl_sis_dom.getString("sis_url"));
			gra_inp.setId_sis_log(cl_sis_dom.getLong("id_sis_log"));
			gra_inp.setL_usu(cl_sis_dom.getString("l_usu"));
			gra_inp.setL_sen(cl_sis_dom.getString("l_sen"));
			gra_inp.setTp_sit(cl_sis_dom.getString("tp_sit"));
			gra_inp.setAce_per_aut(cl_sis_dom.getString("ace_per_aut"));
			gra_inp.setTitulo_web(cl_sis_dom.getString("titulo_web"));

		}

		return gra_inp;

	}

	public cla_sis_dom cons_sis_dom_no_dom(String tx1) throws Exception {

		cla_sis_dom gra_inp = new cla_sis_dom();

	    tx1 = tx1.replaceAll("\\s+", ""); // remove TODOS os espaços
	    tx1 = tx1.toUpperCase();
		
		String bc_sql = "select * FROM tb_sis_dom where REPLACE(UPPER(no_dom),' ','') = upper('" + tx1 + "')";

		
		
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_sis_dom = gra_bus.executeQuery();

		while (cl_sis_dom.next()) {

			gra_inp.setId_sis(cl_sis_dom.getLong("id_sis"));
			gra_inp.setReg_id(cl_sis_dom.getLong("reg_id"));
			gra_inp.setReg_data(cl_sis_dom.getTimestamp("reg_data"));
			gra_inp.setReg_alt(cl_sis_dom.getLong("reg_alt"));
			gra_inp.setReg_data_alt(cl_sis_dom.getTimestamp("reg_data_alt"));
			gra_inp.setId_sis_dom(cl_sis_dom.getLong("id_sis_dom"));
			gra_inp.setNo_dom(cl_sis_dom.getString("no_dom"));
			gra_inp.setSis_url(cl_sis_dom.getString("sis_url"));
			gra_inp.setId_sis_log(cl_sis_dom.getLong("id_sis_log"));
			gra_inp.setL_usu(cl_sis_dom.getString("l_usu"));
			gra_inp.setL_sen(cl_sis_dom.getString("l_sen"));
			gra_inp.setTp_sit(cl_sis_dom.getString("tp_sit"));
			gra_inp.setAce_per_aut(cl_sis_dom.getString("ace_per_aut"));
			gra_inp.setTitulo_web(cl_sis_dom.getString("titulo_web"));

		}

		return gra_inp;

	}

}
