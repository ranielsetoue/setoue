package func;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cbd.pos_cbd;
import cla.cla_perm_ace;

public class fun_perm_ace {
	private static Connection pos_cbd_con;

	public fun_perm_ace() {
		pos_cbd_con = pos_cbd.getPos_cbd();
// TODO Auto-generated constructor stub

// TODO Auto-generated constructor stub
	}

	public boolean val_1(long nx1, long nx2) throws Exception {

		String bc_sql = "SELECT count (1) > 0 as existe FROM tb_perm_ace WHERE id_sis = " + nx1 + " And id_sis_log = "
				+ nx2;

		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet resul = gra_bus.executeQuery();

		resul.next();
		return resul.getBoolean("existe");

	}

	public cla_perm_ace cons_perm_ace_nx1(Long nx1, Long nx2) throws Exception {

		cla_perm_ace gra_inp = new cla_perm_ace();

		String bc_sql = " select * FROM tb_perm_ace where id_sis = " + nx1 + " And id_sis_log = '" + nx1 + "'";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_perm_ace = gra_bus.executeQuery();

		while (cl_perm_ace.next()) {

			gra_inp.setId_sis(cl_perm_ace.getLong("id_sis"));
			gra_inp.setReg_id(cl_perm_ace.getLong("reg_id"));
			gra_inp.setReg_data(cl_perm_ace.getTimestamp("reg_data"));
			gra_inp.setReg_alt(cl_perm_ace.getLong("reg_alt"));
			gra_inp.setReg_data_alt(cl_perm_ace.getTimestamp("reg_data_alt"));
			gra_inp.setPer_ace_id(cl_perm_ace.getLong("per_ace_id"));
			gra_inp.setId_sis_log(cl_perm_ace.getLong("id_sis_log"));
			gra_inp.setNome_desc(cl_perm_ace.getString("nome_desc"));
			gra_inp.setAces_cad_sis(cl_perm_ace.getBoolean("aces_cad_sis"));
			gra_inp.setAces_cad_clin(cl_perm_ace.getBoolean("aces_cad_clin"));
			gra_inp.setAces_cad_forn(cl_perm_ace.getBoolean("aces_cad_forn"));
			gra_inp.setAces_cad_prod(cl_perm_ace.getBoolean("aces_cad_prod"));
			gra_inp.setAces_cad_serv(cl_perm_ace.getBoolean("aces_cad_serv"));

		}

		return gra_inp;

	}

	public cla_perm_ace sav_perm_ace(cla_perm_ace gra_bus) throws Exception {

		if (gra_bus.nv_id() && !val_1(gra_bus.getId_sis(), gra_bus.getId_sis_log())) {

			String bc_sql = "INSERT INTO public.tb_perm_ace(\r\n"
					+ "id_sis, reg_id, reg_data, reg_alt, reg_data_alt, id_sis_log, nome_desc, aces_cad_sis, aces_cad_clin, aces_cad_forn, aces_cad_prod, aces_cad_serv, aces_desv) \r\n"
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

					PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);


					gra_inp.setLong(1, gra_bus.getId_sis());
					gra_inp.setLong(2, gra_bus.getReg_id());
					gra_inp.setTimestamp(3, gra_bus.getReg_data());
					gra_inp.setLong(4, gra_bus.getReg_alt());
					gra_inp.setTimestamp(5, gra_bus.getReg_data_alt());
					gra_inp.setLong(6, gra_bus.getId_sis_log());
					gra_inp.setString(7, gra_bus.getNome_desc());
					gra_inp.setBoolean(8, gra_bus.getAces_cad_sis());
					gra_inp.setBoolean(9, gra_bus.getAces_cad_clin());
					gra_inp.setBoolean(10, gra_bus.getAces_cad_forn());
					gra_inp.setBoolean(11, gra_bus.getAces_cad_prod());
					gra_inp.setBoolean(12, gra_bus.getAces_cad_serv());
					gra_inp.setBoolean(13, gra_bus.getAces_desv());

			gra_inp.execute();
			pos_cbd_con.commit();
		} else {

			String bc_sql = "UPDATE public.tb_perm_ace\r\n"

					+ "SET reg_alt=?, reg_data_alt=?, aces_cad_clin=?, aces_cad_forn=?, aces_cad_prod=?, aces_desv=?) \r\n"
					+ " WHERE id_sis_log = " + gra_bus.getId_sis_log() + ";";

			PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			gra_inp.setLong(1, gra_bus.getReg_alt());

			gra_inp.setBoolean(2, gra_bus.getAces_cad_sis());
			gra_inp.setBoolean(3, gra_bus.getAces_cad_clin());
			gra_inp.setBoolean(4, gra_bus.getAces_cad_forn());

			gra_inp.setBoolean(5, gra_bus.getAces_cad_serv());
			gra_inp.setBoolean(6, gra_bus.getAces_desv());

			gra_inp.executeUpdate();
			pos_cbd_con.commit();
		}
		return this.cons_perm_ace_nx1(gra_bus.getId_sis(), gra_bus.getId_sis_log());
	}

}