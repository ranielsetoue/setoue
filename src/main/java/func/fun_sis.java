package func;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cbd.pos_cbd;
import cla.cla_list_cnpj_nome;
import cla.cla_list_tipo_ace;
import cla.cla_sis;

public class fun_sis {
	private static Connection pos_cbd_con;

	public fun_sis() {
		pos_cbd_con = pos_cbd.getPos_cbd();
		// TODO Auto-generated constructor stub
	}



	public List<cla_list_cnpj_nome> cons_list_sis_cnpj() throws Exception {

		List<cla_list_cnpj_nome> retorno = new ArrayList<cla_list_cnpj_nome>();

		String bc_sql = "SELECT cnpj_cpf, nome_desc FROM tb_sis ORDER BY nome_desc";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet gran_inp = gra_bus.executeQuery();

		while (gran_inp.next()) { /* percorrer as linhas de resultado do SQL */

			String cnpjCpf = gran_inp.getString("cnpj_cpf");
			String nomeDesc = gran_inp.getString("nome_desc");
			retorno.add(new cla_list_cnpj_nome(cnpjCpf, nomeDesc));
		}

		return retorno;
	}

	public List<cla_list_tipo_ace> cons_list_tipo_ace() throws Exception {

		List<cla_list_tipo_ace> retorno = new ArrayList<cla_list_tipo_ace>();

		String bc_sql = "SELECT nome_desc FROM tb_tipo_ace ORDER BY nome_desc";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet gran_inp = gra_bus.executeQuery();

		while (gran_inp.next()) { /* percorrer as linhas de resultado do SQL */

			String tpnomeDesc = gran_inp.getString("nome_desc");
			retorno.add(new cla_list_tipo_ace(tpnomeDesc));
		}

		return retorno;
	}

	public cla_sis cons_sis_cnpj_cpf(String cnpj_cpf) throws Exception {

		cla_sis gra_inp = new cla_sis();

		String bc_sql = "select * FROM tb_sis where cnpj_cpf = '" + cnpj_cpf + "'";
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

	

/////////////////////////
/////////////////////////
///	

	public boolean val_str1_sis_cnpj_cpf(String cnpj_cpf) throws Exception {

		String bc_sql = "select count (1) > 0 as existe from tb_sis where upper(cnpj_cpf) = upper('" + cnpj_cpf + "')";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);
		ResultSet resul = gra_bus.executeQuery();

		resul.next();
		return resul.getBoolean("existe");

	}

	public boolean val_str1_sis_nome_desc(String nome_desc) throws Exception {

		String bc_sql = "select count (1) > 0 as existe from tb_sis where upper(nome_desc) = upper('" + nome_desc
				+ "')";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet resul = gra_bus.executeQuery();

		resul.next();
		return resul.getBoolean("existe");

	}

	public void del_sis(String t_uni) throws Exception {

		String bc_sql = "DELETE FROM public.tb_sis WHERE id_sis = ?;";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);
		gra_bus.setLong(1, Long.parseLong(t_uni));
		gra_bus.executeUpdate();
		pos_cbd_con.commit();

	}

	public cla_sis sav_sis(cla_sis gra_bus) throws Exception {

		if (gra_bus.nv_id() && !val_str1_sis_cnpj_cpf(gra_bus.getCnpj_cpf())
				&& !val_str1_sis_nome_desc(gra_bus.getNome_desc())) {

			String bc_sql = "INSERT INTO public.tb_sis(\r\n"

					+ "reg_id, reg_data, reg_alt, reg_data_alt, truefalse,  nome_desc, no_fan, cnpj_cpf, end_rua, end_num, end_com, end_bar, end_mun, end_uf, end_cep, ins_est, ins_mun, tel_1, email_1, obs) \r\n"
					+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  ?, ?);";

			PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			gra_inp.setLong(1, gra_bus.getReg_id());
			gra_inp.setTimestamp(2, gra_bus.getReg_data());
			gra_inp.setLong(3, gra_bus.getReg_alt());
			gra_inp.setTimestamp(4, gra_bus.getReg_data_alt());
			gra_inp.setBoolean(5, gra_bus.getTruefalse());
			gra_inp.setString(6, gra_bus.getNome_desc());
			gra_inp.setString(7, gra_bus.getNo_fan());
			gra_inp.setString(8, gra_bus.getCnpj_cpf());
			gra_inp.setString(9, gra_bus.getEnd_rua());
			gra_inp.setString(10, gra_bus.getEnd_num());
			gra_inp.setString(11, gra_bus.getEnd_com());
			gra_inp.setString(12, gra_bus.getEnd_bar());
			gra_inp.setString(13, gra_bus.getEnd_mun());
			gra_inp.setString(14, gra_bus.getEnd_uf());
			gra_inp.setString(15, gra_bus.getEnd_cep());
			gra_inp.setString(16, gra_bus.getIns_est());
			gra_inp.setString(17, gra_bus.getIns_mun());
			gra_inp.setString(18, gra_bus.getTel_1());
			gra_inp.setString(19, gra_bus.getEmail_1());
			gra_inp.setString(20, gra_bus.getObs());
			gra_inp.execute();
			pos_cbd_con.commit();
		} else {

			String bc_sql = "UPDATE public.tb_sis\r\n"

					+ " SET reg_alt=?, reg_data_alt=?, truefalse=?, nome_desc=?, no_fan=?, cnpj_cpf=?, \r\n"
					+ "end_rua=?, end_num=?, end_com=?, end_bar=?, end_mun=?, end_uf=?, end_cep=?, \r\n"
					+ "ins_est=?, ins_mun=?, tel_1=?, email_1=?, obs=? \r\n"
					+ " WHERE id_sis = " + gra_bus.getId_sis() + ";";

			PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			gra_inp.setLong(1, gra_bus.getReg_alt());
			gra_inp.setTimestamp(2, gra_bus.getReg_data_alt());
			gra_inp.setBoolean(3, gra_bus.getTruefalse());
			gra_inp.setString(4, gra_bus.getNome_desc());
			gra_inp.setString(5, gra_bus.getNo_fan());
			gra_inp.setString(6, gra_bus.getCnpj_cpf());
			gra_inp.setString(7, gra_bus.getEnd_rua());
			gra_inp.setString(8, gra_bus.getEnd_num());
			gra_inp.setString(9, gra_bus.getEnd_com());
			gra_inp.setString(10, gra_bus.getEnd_bar());
			gra_inp.setString(11, gra_bus.getEnd_mun());
			gra_inp.setString(12, gra_bus.getEnd_uf());
			gra_inp.setString(13, gra_bus.getEnd_cep());
			gra_inp.setString(14, gra_bus.getIns_est());
			gra_inp.setString(15, gra_bus.getIns_mun());
			gra_inp.setString(16, gra_bus.getTel_1());
			gra_inp.setString(17, gra_bus.getEmail_1());
			gra_inp.setString(18, gra_bus.getObs());

			gra_inp.executeUpdate();
			pos_cbd_con.commit();
		}
		return this.cons_sis_cnpj_cpf(gra_bus.getCnpj_cpf());
	}

	public cla_sis sav_sis_consultar_refeita_federal(cla_sis gra_bus) throws Exception {

		if (gra_bus.nv_id() && !val_str1_sis_cnpj_cpf(gra_bus.getCnpj_cpf())
				&& !val_str1_sis_nome_desc(gra_bus.getNome_desc())) {

			String bc_sql = "INSERT INTO public.tb_sis(\r\n"
					+ " reg_id, reg_data, reg_alt, reg_data_alt, truefalse, \r\n"
					+ " nome_desc,cnpj_cpf) \r\n"
					+ " VALUES (?, ?, ?, ?, ?,\r\n"
					+ " ?,  ?);";

			PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			gra_inp.setLong(1, gra_bus.getReg_id());
			gra_inp.setTimestamp(2, gra_bus.getReg_data());
			gra_inp.setLong(3, gra_bus.getReg_alt());
			gra_inp.setTimestamp(4, gra_bus.getReg_data_alt());
			gra_inp.setBoolean(5,gra_bus.getTruefalse());
			gra_inp.setString(6,gra_bus.getNome_desc());
			gra_inp.setString(7,gra_bus.getCnpj_cpf());

			gra_inp.execute();
			pos_cbd_con.commit();
		} else {

			String bc_sql = "UPDATE public.tb_sis\r\n"

					+ " SET reg_alt=?, reg_data_alt=?, \r\n"
					+ " nome_desc=?, no_fan=?, cnpj_cpf=?, \r\n"
					+ " end_rua=?, end_num=?, end_com=?, end_bar=?, end_mun=?, end_uf=?, end_cep=?, \r\n"
					+ " tel_1=?, email_1=? \r\n"
					+ " WHERE id_sis = " + gra_bus.getId_sis() + ";";

			PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			gra_inp.setLong(1, gra_bus.getReg_alt());
			gra_inp.setTimestamp(2, gra_bus.getReg_data_alt());
			gra_inp.setString(3, gra_bus.getNome_desc());
			gra_inp.setString(4, gra_bus.getNo_fan());
			gra_inp.setString(5, gra_bus.getCnpj_cpf());
			gra_inp.setString(6, gra_bus.getEnd_rua());
			gra_inp.setString(7, gra_bus.getEnd_num());
			gra_inp.setString(8, gra_bus.getEnd_com());
			gra_inp.setString(9, gra_bus.getEnd_bar());
			gra_inp.setString(10, gra_bus.getEnd_mun());
			gra_inp.setString(11, gra_bus.getEnd_uf());
			gra_inp.setString(12, gra_bus.getEnd_cep());
			gra_inp.setString(13, gra_bus.getTel_1());
			gra_inp.setString(14, gra_bus.getEmail_1());
			gra_inp.executeUpdate();
			pos_cbd_con.commit();
		}
		return this.cons_sis_cnpj_cpf(gra_bus.getCnpj_cpf());
	}
	
}
