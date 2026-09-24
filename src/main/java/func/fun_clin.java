package func;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cbd.pos_cbd;
import cla.cla_list_cnpj_nome;

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

}
