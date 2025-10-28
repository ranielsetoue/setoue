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

	public cla_sis cons_titulo_web(long id_sis) throws Exception {

		cla_sis gra_inp = new cla_sis();

		String bc_sql = "select titulo_web FROM tb_sis where id_sis = '" + id_sis + "'";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_sis = gra_bus.executeQuery();

		while (cl_sis.next()) {

			gra_inp.setTitulo_web(cl_sis.getString("tituto_web"));

		}

		return gra_inp;

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

}
