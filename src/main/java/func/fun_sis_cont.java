package func;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cbd.pos_cbd;
import cla.cla_sis_cont;

public class fun_sis_cont {

	private static Connection pos_cbd_con;

	public fun_sis_cont() {
		pos_cbd_con = pos_cbd.getPos_cbd();
		// TODO Auto-generated constructor stub
	}

	public boolean val_1(long nx1, String tx1) throws Exception {

		tx1 = tx1.replaceAll("\\s+", ""); // remove TODOS os espaços
		tx1 = tx1.toUpperCase();

		String bc_sql = "SELECT count (1) > 0 as existe " + "FROM tb_sis_cont " + "WHERE id_sis = " + nx1
				+ " And REPLACE(UPPER(nome_desc),' ','') = REPLACE(UPPER('" + tx1 + "'),' ','')";

		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet resul = gra_bus.executeQuery();

		resul.next();
		return resul.getBoolean("existe");

	}

	public cla_sis_cont cons_sis_cont_id(Long id_sis_cont) throws Exception {

		cla_sis_cont gra_inp = new cla_sis_cont();

		String bc_sql = "select * FROM tb_sis_cont where id_sis_cont = '" + id_sis_cont + "'";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_sis_cont = gra_bus.executeQuery();

		while (cl_sis_cont.next()) {

			gra_inp.setId_sis(cl_sis_cont.getLong("id_sis"));
			gra_inp.setReg_id(cl_sis_cont.getLong("reg_id"));
			gra_inp.setReg_data(cl_sis_cont.getTimestamp("reg_data"));
			gra_inp.setReg_alt(cl_sis_cont.getLong("reg_alt"));
			gra_inp.setReg_data_alt(cl_sis_cont.getTimestamp("reg_data_alt"));
			gra_inp.setId_sis_cont(cl_sis_cont.getLong("id_sis_cont"));
			gra_inp.setNome_desc(cl_sis_cont.getString("nome_desc"));
			gra_inp.setTel_1(cl_sis_cont.getString("tel_1"));
			gra_inp.setTel_2(cl_sis_cont.getString("tel_2"));
			gra_inp.setEmail_1(cl_sis_cont.getString("email_1"));
			gra_inp.setEmail_2(cl_sis_cont.getString("email_2"));
			gra_inp.setSetor_1(cl_sis_cont.getString("setor_1"));
			gra_inp.setObs(cl_sis_cont.getString("obs"));
			gra_inp.setId_sis_log(cl_sis_cont.getLong("id_sis_log"));

		}

		return gra_inp;

	}

	public List<cla_sis_cont> list_sis_cont_id(long nx1, long offset) throws Exception {

		/*
		 * limite de paginação select * FROM tb_sistema_dominio where id_sistema = 1
		 * order by id_sistema offset 0 limit 3
		 */
		List<cla_sis_cont> retorno = new ArrayList<>();

		String bc_sql = "select * FROM tb_sis_cont where id_sis = " + nx1 + " order by nome_desc offset " + offset
				+ " limit 5 ";
		PreparedStatement gra_dado = pos_cbd_con.prepareStatement(bc_sql);
		ResultSet gra_bus = gra_dado.executeQuery();

		while (gra_bus.next()) {

			cla_sis_cont gra_inp = new cla_sis_cont();

			gra_inp.setId_sis(gra_bus.getLong("id_sis"));
			gra_inp.setId_sis_cont(gra_bus.getLong("id_sis_cont"));
			gra_inp.setNome_desc(gra_bus.getString("nome_desc"));
			gra_inp.setTel_1(gra_bus.getString("tel_1"));
			gra_inp.setTel_2(gra_bus.getString("tel_2"));
			gra_inp.setEmail_1(gra_bus.getString("email_1"));
			gra_inp.setEmail_2(gra_bus.getString("email_2"));
			gra_inp.setSetor_1(gra_bus.getString("setor_1"));
			gra_inp.setObs(gra_bus.getString("obs"));
			gra_inp.setId_sis_log(gra_bus.getLong("id_sis_log"));

			retorno.add(gra_inp);

		}

		return retorno;
	}

	public void del_sis_cont(String t_uni) throws Exception {

		String bc_sql = "DELETE FROM public.tb_sis_cont WHERE id_sis_cont = ?;";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);
		gra_bus.setLong(1, Long.parseLong(t_uni));
		gra_bus.executeUpdate();
		pos_cbd_con.commit();

	}

	public cla_sis_cont sav_sis_cont(cla_sis_cont gra_bus) throws Exception {

	    String bc_sql1 = "SELECT nextval('seq_sis_log')";

	    PreparedStatement stmt = pos_cbd_con.prepareStatement(bc_sql1);

	    ResultSet rs = stmt.executeQuery();

	    Long id_log = null;

	    if (rs.next()) {
	    	id_log  = rs.getLong(1);
	    }

	    rs.close();
	    stmt.close();

	    pos_cbd_con.commit();

		
		if (gra_bus.nv_id() && !val_1(gra_bus.getId_sis(), gra_bus.getNome_desc())) {

			String bc_sql = "INSERT INTO public.tb_sis_cont(\r\n"

					+ "id_sis, reg_id, reg_data, reg_alt, reg_data_alt, nome_desc, tel_1, tel_2, email_1, email_2, setor_1, obs, id_sis_log) \r\n"
					+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

			PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			gra_inp.setLong(1, gra_bus.getId_sis());
			gra_inp.setLong(2, gra_bus.getReg_id());
			gra_inp.setTimestamp(3, gra_bus.getReg_data());
			gra_inp.setLong(4, gra_bus.getReg_alt());
			gra_inp.setTimestamp(5, gra_bus.getReg_data_alt());
			gra_inp.setString(6, gra_bus.getNome_desc());
			gra_inp.setString(7, gra_bus.getTel_1());
			gra_inp.setString(8, gra_bus.getTel_2());
			gra_inp.setString(9, gra_bus.getEmail_1());
			gra_inp.setString(10, gra_bus.getEmail_2());
			gra_inp.setString(11, gra_bus.getSetor_1());
			gra_inp.setString(12, gra_bus.getObs());
			gra_inp.setLong(13, id_log);

			gra_inp.execute();
			pos_cbd_con.commit();
		} else {

			String bc_sql = "UPDATE public.tb_sis_cont\r\n"

					+ " SET reg_alt=?, reg_data_alt=?, nome_desc=?, tel_1=?, tel_2=?, email_1=?, email_2=?, setor_1=?, obs=?\r\n"
					+ " WHERE id_sis_cont = " + gra_bus.getId_sis_cont() + ";";

			PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			gra_inp.setLong(1, gra_bus.getReg_alt());
			gra_inp.setTimestamp(2, gra_bus.getReg_data_alt());
			gra_inp.setString(3, gra_bus.getNome_desc());
			gra_inp.setString(4, gra_bus.getTel_1());
			gra_inp.setString(5, gra_bus.getTel_2());
			gra_inp.setString(6, gra_bus.getEmail_1());
			gra_inp.setString(7, gra_bus.getEmail_2());
			gra_inp.setString(8, gra_bus.getSetor_1());
			gra_inp.setString(9, gra_bus.getObs());

			gra_inp.executeUpdate();
			pos_cbd_con.commit();
		}
		return this.cons_sis_cont_id(gra_bus.getId_sis_cont());
	}

}
