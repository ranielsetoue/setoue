package func;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cbd.pos_cbd;
import cla.cla_sis_d_log;

public class fun_sis_d_log {

	private static Connection pos_cbd_con;

	public fun_sis_d_log() {
		pos_cbd_con = pos_cbd.getPos_cbd();
	}

	public boolean val_d_login_email(long nx1, String tx1) throws Exception {

		tx1 = tx1.replaceAll("\\s+", ""); // remove TODOS os espaços
		tx1 = tx1.toUpperCase();

		String bc_sql = "SELECT  count (1) > 0 as existe " + "FROM tb_sis_d_log " + "WHERE id_sis = " + nx1
				+ " And REPLACE(UPPER(email_1),' ','') = UPPER('" + tx1 + "')";

		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet resul = gra_bus.executeQuery();

		resul.next();
		return resul.getBoolean("existe");

	}

	public boolean val_d_login_nome(long nx1, String tx1) throws Exception {

		tx1 = tx1.replaceAll("\\s+", ""); // remove TODOS os espaços
		tx1 = tx1.toUpperCase();

		String bc_sql = "SELECT  count (1) > 0 as existe " + "FROM tb_sis_d_log " + "WHERE id_sis = " + nx1
				+ " And REPLACE(UPPER(nome_desc),' ','') = UPPER('" + tx1 + "')";

		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet resul = gra_bus.executeQuery();

		resul.next();
		return resul.getBoolean("existe");

	}

	public cla_sis_d_log cons_sis_d_log(Long nx1) throws Exception {

		cla_sis_d_log gra_inp = new cla_sis_d_log();

		String bc_sql = "select * FROM tb_sis_d_log where id_sis_log = '" + nx1 + "'";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_sis_d_log = gra_bus.executeQuery();

		while (cl_sis_d_log.next()) {

			gra_inp.setId_sis(cl_sis_d_log.getLong("id_sis"));
			gra_inp.setReg_id(cl_sis_d_log.getLong("reg_id"));
			gra_inp.setReg_data(cl_sis_d_log.getTimestamp("reg_data"));
			gra_inp.setReg_alt(cl_sis_d_log.getLong("reg_alt"));
			gra_inp.setReg_data(cl_sis_d_log.getTimestamp("reg_data"));
			gra_inp.setId_sis_d_log(cl_sis_d_log.getLong("id_sis_d_log"));
			gra_inp.setId_sis_log(cl_sis_d_log.getLong("id_sis_log"));
			gra_inp.setNome_desc(cl_sis_d_log.getString("nome_desc"));
			gra_inp.setEmail_1(cl_sis_d_log.getString("email_1"));
			gra_inp.setFoto(cl_sis_d_log.getString("foto"));
			gra_inp.setCaminho_foto(cl_sis_d_log.getString("caminho_foto"));

		}

		return gra_inp;

	}

	public cla_sis_d_log sav_d_log(cla_sis_d_log gra_bus) throws Exception {

			if (gra_bus.nv_id() && !val_d_login_nome(gra_bus.getId_sis(),gra_bus.getNome_desc())
					&& !val_d_login_email(gra_bus.getId_sis(),gra_bus.getEmail_1())) {

			    String bc_sql = "INSERT INTO public.tb_sis_d_log (id_sis, reg_id, reg_data, reg_alt, reg_data_alt, id_sis_log, nome_desc, email_1) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

			    PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			    gra_inp.setLong(1, gra_bus.getId_sis());
			    gra_inp.setLong(2, gra_bus.getReg_id());
			    gra_inp.setTimestamp(3, gra_bus.getReg_data());
			    gra_inp.setLong(4, gra_bus.getReg_alt());
			    gra_inp.setTimestamp(5, gra_bus.getReg_data_alt());
			    gra_inp.setLong(6, gra_bus.getId_sis_log());
			    gra_inp.setString(7, gra_bus.getNome_desc());
			    gra_inp.setString(8, gra_bus.getEmail_1());

			    gra_inp.execute();
			    pos_cbd_con.commit();

			} else {

			    String bc_sql = "UPDATE INTO public.tb_sis_d_log (reg_alt=?, reg_data_alt=?, nome_desc=?, email_1=?) WHERE id_sis = " + gra_bus.getId_sis() + ";";
				
				
				PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

				gra_inp.setLong(1, gra_bus.getReg_alt());
				gra_inp.setTimestamp(2, gra_bus.getReg_data_alt());
				gra_inp.setString(3, gra_bus.getNome_desc());
				gra_inp.setString(4, gra_bus.getEmail_1());
				gra_inp.executeUpdate();
				pos_cbd_con.commit();
			}
			return this.cons_sis_d_log(gra_bus.getId_sis_log());
		}
		
		
		
}
