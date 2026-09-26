package func;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cbd.pos_cbd;
import cla.cla_glo_ad;
import cla.cla_list_cnpj_nome;
import cla.cla_sis;

public class fun_clin {

	private static Connection pos_cbd_con;

	public fun_clin() {
		pos_cbd_con = pos_cbd.getPos_cbd();
		// TODO Auto-generated constructor stub

		// TODO Auto-generated constructor stub
	}

	public List<cla_list_cnpj_nome> cons_list_cnpj() throws Exception {

		List<cla_list_cnpj_nome> retorno = new ArrayList<cla_list_cnpj_nome>();

		String bc_sql = "SELECT cnpj_cpf, nome_desc FROM tb_clin ORDER BY nome_desc";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet gran_inp = gra_bus.executeQuery();

		while (gran_inp.next()) { /* percorrer as linhas de resultado do SQL */

			String cnpjCpf = gran_inp.getString("cnpj_cpf");
			String nomeDesc = gran_inp.getString("nome_desc");
			retorno.add(new cla_list_cnpj_nome(cnpjCpf, nomeDesc));
		}

		return retorno;
	}

	public boolean val_clin(String tx1) throws Exception {

		String bc_sql = "SELECT  count (1) > 0 as existe " + "FROM tb_clin " + "WHERE cnpj_cpf = '" + tx1 + "'";

		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet resul = gra_bus.executeQuery();

		resul.next();
		return resul.getBoolean("existe");

	}

	public cla_sis cons_clin(String tx1) throws Exception {

		cla_sis gra_inp = new cla_sis();

		String bc_sql = "select * FROM tb_clin where cnpj_cpf = '" + tx1 + "'";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_sis = gra_bus.executeQuery();

		while (cl_sis.next()) {

			gra_inp.setId_sis(cl_sis.getLong("id_sis"));
			gra_inp.setReg_id(cl_sis.getLong("reg_id"));
			gra_inp.setReg_data(cl_sis.getTimestamp("reg_data"));
			gra_inp.setReg_data_alt(cl_sis.getTimestamp("reg_data_alt"));
			gra_inp.setTruefalse(cl_sis.getBoolean("truefalse"));
			gra_inp.setNome_desc(cl_sis.getString("nome_desc"));
			gra_inp.setNo_fan(cl_sis.getString("no_fan"));
			gra_inp.setCnpj_cpf(cl_sis.getString("cnpj_cpf"));
			gra_inp.setEnd_rua(cl_sis.getString("end_rua"));
			gra_inp.setEnd_num(cl_sis.getString("end_num"));
			gra_inp.setEnd_com(cl_sis.getString("end_com"));
			gra_inp.setEnd_bar(cl_sis.getString("end_bar"));
			gra_inp.setEnd_mun(cl_sis.getString("end_mun"));
			gra_inp.setEnd_uf(cl_sis.getString("end_uf"));
			gra_inp.setEnd_cep(cl_sis.getString("end_cep"));
			gra_inp.setIns_est(cl_sis.getString("ins_est"));
			gra_inp.setIns_mun(cl_sis.getString("ins_mun"));
			gra_inp.setTel_1(cl_sis.getString("tel_1"));
			gra_inp.setEmail_1(cl_sis.getString("email_1"));
			gra_inp.setObs(cl_sis.getString("obs"));

		}

		return gra_inp;

	}

	public cla_sis sav_clin(cla_sis gra_bus) throws Exception {

		if (!val_clin(gra_bus.getCnpj_cpf())) {

			String bc_sql = "INSERT INTO public.tb_clin(\r\n"
					+ "id_sis, reg_id, reg_data, reg_alt, reg_data_alt, truefalse, ace_per_aut, nome_desc, no_fan, cnpj_cpf, end_rua, end_num, end_com, end_bar, end_mun, end_uf, end_cep, ins_est, ins_mun, tel_1, email_1, obs) \r\n"
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

			PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			gra_inp.setLong(1, gra_bus.getId_sis());

			gra_inp.setLong(2, gra_bus.getReg_id());
			gra_inp.setTimestamp(3, gra_bus.getReg_data());
			gra_inp.setLong(4, gra_bus.getReg_alt());
			gra_inp.setTimestamp(5, gra_bus.getReg_data_alt());
			gra_inp.setBoolean(6, gra_bus.getTruefalse());
			gra_inp.setString(7, gra_bus.getAce_per_aut());
			gra_inp.setString(8, gra_bus.getNome_desc());
			gra_inp.setString(9, gra_bus.getNo_fan());
			gra_inp.setString(10, gra_bus.getCnpj_cpf());
			gra_inp.setString(11, gra_bus.getEnd_rua());
			gra_inp.setString(12, gra_bus.getEnd_num());
			gra_inp.setString(13, gra_bus.getEnd_com());
			gra_inp.setString(14, gra_bus.getEnd_bar());
			gra_inp.setString(15, gra_bus.getEnd_mun());
			gra_inp.setString(16, gra_bus.getEnd_uf());
			gra_inp.setString(17, gra_bus.getEnd_cep());
			gra_inp.setString(18, gra_bus.getIns_est());
			gra_inp.setString(19, gra_bus.getIns_mun());
			gra_inp.setString(20, gra_bus.getTel_1());
			gra_inp.setString(21, gra_bus.getEmail_1());
			gra_inp.setString(22, gra_bus.getObs());

			
			gra_inp.execute();
			pos_cbd_con.commit();
		} else {

			String bc_sql = "UPDATE public.tb_clin\r\n"

					+ "SET reg_data=?, reg_alt=?, reg_data_alt=?, no_fan=?, cnpj_cpf=?, end_rua=?, end_com=?, end_bar=?, end_mun=?, end_uf=?, end_cep=?, ins_est=?, ins_mun=?, tel_1=?, email_1=?, obs=? \r\n"
					+ " WHERE cnpj_cpf = " + gra_bus.getCnpj_cpf() + ";";

			PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			gra_inp.setTimestamp(1, gra_bus.getReg_data());
			gra_inp.setLong(2, gra_bus.getReg_alt());

			gra_inp.setString(3, gra_bus.getNome_desc());
			gra_inp.setString(4, gra_bus.getNo_fan());
			gra_inp.setString(5, gra_bus.getCnpj_cpf());

			gra_inp.setString(6, gra_bus.getEnd_num());
			gra_inp.setString(7, gra_bus.getEnd_com());
			gra_inp.setString(8, gra_bus.getEnd_bar());
			gra_inp.setString(9, gra_bus.getEnd_mun());
			gra_inp.setString(10, gra_bus.getEnd_uf());
			gra_inp.setString(11, gra_bus.getEnd_cep());
			gra_inp.setString(12, gra_bus.getIns_est());
			gra_inp.setString(13, gra_bus.getIns_mun());
			gra_inp.setString(14, gra_bus.getTel_1());
			gra_inp.setString(15, gra_bus.getEmail_1());

			gra_inp.executeUpdate();
			pos_cbd_con.commit();
		}
		return this.cons_clin(gra_bus.getCnpj_cpf());
	}

	/*
	 * 	
	 */
	public boolean val_clin_adi(long nx1) throws Exception {

		String bc_sql = "SELECT  count (1) > 0 as existe " + "FROM tb_clin_adi " + "WHERE id_sis = '" + nx1 + "'";

		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet resul = gra_bus.executeQuery();

		resul.next();
		return resul.getBoolean("existe");

	}

	public cla_glo_ad cons_clin_adi(Long nx1) throws Exception {

		cla_glo_ad gra_inp = new cla_glo_ad();

		String bc_sql = "select * FROM tb_clin_adi where clin_id = '" + nx1 + "'";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cla_glo_ad = gra_bus.executeQuery();

		while (cla_glo_ad.next()) {

			gra_inp.setId_sis(cla_glo_ad.getLong("id_sis"));
			gra_inp.setReg_id(cla_glo_ad.getLong("reg_id"));
			gra_inp.setReg_data(cla_glo_ad.getTimestamp("reg_data"));
			gra_inp.setReg_data_alt(cla_glo_ad.getTimestamp("reg_data_alt"));
			gra_inp.setTruefalse(cla_glo_ad.getBoolean("truefalse"));
			gra_inp.setTel_2(cla_glo_ad.getString("tel_2"));
			gra_inp.setEmail_2(cla_glo_ad.getString("email_2"));
			gra_inp.setLogin_id(cla_glo_ad.getLong("Login_id"));
			gra_inp.setClin_id(cla_glo_ad.getLong("clin_id"));

		}

		return gra_inp;

	}

	public cla_glo_ad sav_sis_adi(cla_glo_ad gra_bus) throws Exception {

		String bc_sql1 = "SELECT nextval('seq_sis_log')";

		PreparedStatement stmt = pos_cbd_con.prepareStatement(bc_sql1);

		ResultSet rs = stmt.executeQuery();

		Long id_log = null;

		if (rs.next()) {
			id_log = rs.getLong(1);
		}

		rs.close();
		stmt.close();

		pos_cbd_con.commit();

		if (!val_clin_adi(gra_bus.getId_sis())) {

			String bc_sql = "INSERT INTO public.tb_clin_adi("
					+ "id_sis, reg_id, reg_data, reg_alt, reg_data_alt, truefalse, clin_id,"
					+ "tel_2, email_2, login_id) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			gra_inp.setLong(1, gra_bus.getId_sis());
			gra_inp.setLong(2, gra_bus.getReg_id());
			gra_inp.setTimestamp(3, gra_bus.getReg_data());
			gra_inp.setLong(4, gra_bus.getReg_alt());
			gra_inp.setTimestamp(5, gra_bus.getReg_data_alt());
			gra_inp.setBoolean(6, gra_bus.getTruefalse());
			gra_inp.setString(7, gra_bus.getTel_2());
			gra_inp.setString(8, gra_bus.getEmail_2());
			gra_inp.setLong(9, id_log);
			gra_inp.setLong(10, gra_bus.getClin_id());

			gra_inp.execute();
			pos_cbd_con.commit();
		} else {

			String bc_sql = "UPDATE public.tb_clin_adi\r\n"

					+ " SET reg_alt=?, reg_data_alt=?, tel_2=?, email_2=? WHERE id_sis = " + gra_bus.getClin_id() + ";";

			PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			gra_inp.setLong(1, gra_bus.getReg_alt());
			gra_inp.setTimestamp(2, gra_bus.getReg_data_alt());
			gra_inp.setString(3, gra_bus.getTel_2());
			gra_inp.setString(4, gra_bus.getEmail_2());
			gra_inp.executeUpdate();
			pos_cbd_con.commit();
		}
		return this.cons_clin_adi(gra_bus.getClin_id());
	}

}
