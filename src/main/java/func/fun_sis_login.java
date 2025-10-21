package func;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cbd.pos_cbd;
import cla.cla_perm_ace;
import cla.cla_sis_d_log;
import cla.cla_sis_log;

public class fun_sis_login {
	private static Connection pos_cbd_con;

	public fun_sis_login() {
		pos_cbd_con = pos_cbd.getPos_cbd();
		// TODO Auto-generated constructor stub
	}

	public cla_sis_log cons_sis_log_l_usu(String l_usu, String l_sen) throws Exception {

		cla_sis_log gra_inp = new cla_sis_log();

		String bc_sql = "select * FROM tb_sis_log where l_usu = '" + l_usu + "'AND l_sen = '" + l_sen + "'";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_sis_log = gra_bus.executeQuery();

		while (cl_sis_log.next()) {

			gra_inp.setId_sis(cl_sis_log.getLong("id_sis"));
			gra_inp.setReg_id(cl_sis_log.getLong("reg_id"));
			gra_inp.setReg_data(cl_sis_log.getDate("reg_data"));
			gra_inp.setReg_alt(cl_sis_log.getLong("reg_alt"));
			gra_inp.setReg_data_alt(cl_sis_log.getDate("reg_data_alt"));
			gra_inp.setId_sis_log(cl_sis_log.getLong("id_sis_log"));
			gra_inp.setId_sis_dom(cl_sis_log.getLong("id_sis_dom"));
			gra_inp.setL_usu(cl_sis_log.getString("l_usu"));
			gra_inp.setL_sen(cl_sis_log.getString("l_sen"));

		}
		return gra_inp;

	}

	public cla_sis_d_log cons_sis_d_log_id_sis_log(Long id_sis_log) throws Exception {

		cla_sis_d_log gra_inp = new cla_sis_d_log();

		String bc_sql = "select * FROM tb_sis_d_log where id_sis_log = '" + id_sis_log + "'";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_sis_d_log = gra_bus.executeQuery();

		while (cl_sis_d_log.next()) {

			gra_inp.setNome_desc(cl_sis_d_log.getString("nome_desc"));
			gra_inp.setEmail_1(cl_sis_d_log.getString("email_1"));
			gra_inp.setFoto(cl_sis_d_log.getString("foto"));
			gra_inp.setCaminho_foto(cl_sis_d_log.getString("caminho_foto"));

		}

		return gra_inp;

	}

	public cla_perm_ace cons_perm_ace_id_sis_log(long id_sis_log) throws Exception {

		cla_perm_ace gra_inp = new cla_perm_ace();

		String bc_sql = "select * FROM tb_perm_ace where id_sis_log = '" + id_sis_log + "'";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_perm_ace = gra_bus.executeQuery();

		while (cl_perm_ace.next()) {

			gra_inp.setId_sis(cl_perm_ace.getLong("id_sis"));
			gra_inp.setId_sis_log(cl_perm_ace.getLong("id_sis_log"));
			gra_inp.setAces_cad_sis(cl_perm_ace.getBoolean("aces_cad_sis"));
			gra_inp.setAces_cad_clin(cl_perm_ace.getBoolean("aces_cad_clin"));
			gra_inp.setAces_cad_forn(cl_perm_ace.getBoolean("aces_cad_forn"));
			gra_inp.setAces_cad_prod(cl_perm_ace.getBoolean("aces_cad_prod"));
			gra_inp.setAces_cad_serv(cl_perm_ace.getBoolean("aces_cad_serv"));

		}

		return gra_inp;

	}

}
