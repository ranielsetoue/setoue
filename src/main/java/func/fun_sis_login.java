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

	public cla_sis_log cons_sis_log_id_sis_log(long id_sis_log) throws Exception {

		cla_sis_log gra_inp = new cla_sis_log();

		String bc_sql = "select * FROM tb_sis_log where id_sis_log = '" + id_sis_log + "'";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_sis_log = gra_bus.executeQuery();

		while (cl_sis_log.next()) {

			gra_inp.setId_sis(cl_sis_log.getLong("id_sis"));
			gra_inp.setReg_id(cl_sis_log.getLong("reg_id"));
			gra_inp.setReg_data(cl_sis_log.getTimestamp("reg_data"));
			gra_inp.setReg_alt(cl_sis_log.getLong("reg_alt"));
			gra_inp.setReg_data_alt(cl_sis_log.getTimestamp("reg_data_alt"));
			gra_inp.setId_sis_log(cl_sis_log.getLong("id_sis_log"));
			gra_inp.setId_sis_dom(cl_sis_log.getLong("id_sis_dom"));
			gra_inp.setL_usu(cl_sis_log.getString("l_usu"));
			gra_inp.setL_sen(cl_sis_log.getString("l_sen"));

		}

		return gra_inp;

	}

	public cla_sis_log cons_sis_log_l_usu(String l_usu, String l_sen) throws Exception {

		cla_sis_log gra_inp = new cla_sis_log();

		String bc_sql = "select * FROM tb_sis_log where l_usu = '" + l_usu + "'AND l_sen = '" + l_sen + "'";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_sis_log = gra_bus.executeQuery();

		while (cl_sis_log.next()) {

			gra_inp.setId_sis(cl_sis_log.getLong("id_sis"));
			gra_inp.setReg_id(cl_sis_log.getLong("reg_id"));
			gra_inp.setReg_data(cl_sis_log.getTimestamp("reg_data"));
			gra_inp.setReg_alt(cl_sis_log.getLong("reg_alt"));
			gra_inp.setReg_data_alt(cl_sis_log.getTimestamp("reg_data_alt"));
			gra_inp.setId_sis_log(cl_sis_log.getLong("id_sis_log"));
			gra_inp.setId_sis_dom(cl_sis_log.getLong("id_sis_dom"));
			gra_inp.setL_usu(cl_sis_log.getString("l_usu"));
			gra_inp.setL_sen(cl_sis_log.getString("l_sen"));

		}
		return gra_inp;

	}

	public cla_sis_d_log cons_sis_d_log_id_sis_log(long id_sis_log) throws Exception {

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

	
	public boolean val_login_email(long nx1, String tx1) throws Exception {

	    tx1 = tx1.replaceAll("\\s+", ""); // remove TODOS os espaços
	    tx1 = tx1.toUpperCase();

	    String bc_sql =
	        "SELECT  count (1) > 0 as existe " +
	        "FROM tb_sis_d_log " +
	        "WHERE id_sis = " + nx1 + " And REPLACE(UPPER(email_1),' ','') = UPPER('" + tx1 + "')";

	    PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

	    ResultSet resul = gra_bus.executeQuery();

		resul.next();
		return resul.getBoolean("existe");

		}

	public boolean val_login(String tx1) throws Exception {

		
	    tx1 = tx1.replaceAll("\\s+", ""); // remove TODOS os espaços
	    tx1 = tx1.toUpperCase();

	    String bc_sql =
	        "SELECT  count (1) > 0 as existe " +
	        "FROM tb_sis_log " +
	        "WHERE REPLACE(UPPER(l_usu),' ','') = UPPER('" + tx1 + "')";

	    PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

	    ResultSet resul = gra_bus.executeQuery();

		resul.next();
		return resul.getBoolean("existe");

		}

	
	public boolean val_login_Nome(long nx1,String tx1) throws Exception {
		
	    tx1 = tx1.replaceAll("\\s+", ""); // remove TODOS os espaços
	    tx1 = tx1.toUpperCase();

	    String bc_sql =
	        "SELECT  count (1) > 0 as existe " +
	        "FROM tb_sis_d_log " +
	        "WHERE id_sis = " + nx1 + " And REPLACE(UPPER(nome_desc),' ','') = UPPER('" + tx1 + "')";

	    PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

	    ResultSet resul = gra_bus.executeQuery();

		resul.next();
		return resul.getBoolean("existe");

		}
	
	public cla_sis_log sav_login(cla_sis_log gra_bus) throws Exception {

		if (gra_bus.nv_id() && !val_login(gra_bus.getL_usu())
				) {

			String bc_sql = "INSERT INTO public.tb_sis_log(\r\n"

					+ "id_sis, reg_id, reg_data, reg_alt, reg_data_alt, \r\n"
					+ "            id_sis_dom, l_usu, l_sen) \r\n"
					+ " VALUES (?, ?, ?, ?, ?,  \r\n"
					+ "            ?, ?, ?);";

			PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			gra_inp.setLong(1, gra_bus.getId_sis());
			gra_inp.setLong(2, gra_bus.getReg_id());
			gra_inp.setTimestamp(3, gra_bus.getReg_data());
			gra_inp.setLong(4, gra_bus.getReg_alt());
			gra_inp.setTimestamp(5, gra_bus.getReg_data_alt());
			gra_inp.setLong(6, gra_bus.getId_sis_dom());
			gra_inp.setString(7, gra_bus.getL_usu());
			gra_inp.setString(8, gra_bus.getL_sen());
			gra_inp.execute(); 
			pos_cbd_con.commit();
		} else {

			String bc_sql = "UPDATE public.tb_sis_log\r\n"

					+ " SET reg_alt=?, reg_data_alt=?, l_usu=?, l_sen=? \r\n"
					+ " WHERE id_sis_log = " + gra_bus.getId_sis_log() + ";";
						
			PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			gra_inp.setLong(1, gra_bus.getReg_alt());
			gra_inp.setTimestamp(2, gra_bus.getReg_data_alt());
			gra_inp.setString(3, gra_bus.getL_usu());
			gra_inp.setString(4, gra_bus.getL_sen());
		

			gra_inp.executeUpdate();
			pos_cbd_con.commit();
		}
		return this.cons_sis_log_id_sis_log(gra_bus.getId_sis_log());
	}

	public cla_sis_log sav_login_dom(cla_sis_log gra_bus) throws Exception {

	    String bc_sql =
	        "INSERT INTO public.tb_sis_log ( " +
	        "id_sis, reg_id, reg_data, reg_alt, id_sis_dom, reg_data_alt, l_usu, l_sen " +
	        ") VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

	    PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

	    gra_inp.setLong(1, gra_bus.getId_sis());
	    gra_inp.setLong(2, gra_bus.getReg_id());
	    gra_inp.setTimestamp(3, gra_bus.getReg_data());
	    gra_inp.setLong(4, gra_bus.getReg_alt());
	    gra_inp.setLong(5, gra_bus.getId_sis_dom());
	    gra_inp.setTimestamp(6, gra_bus.getReg_data_alt());
	    gra_inp.setString(7, gra_bus.getL_usu());
	    gra_inp.setString(8, gra_bus.getL_sen());

	    gra_inp.execute();
	    pos_cbd_con.commit();

	    return gra_bus;
	}
}
