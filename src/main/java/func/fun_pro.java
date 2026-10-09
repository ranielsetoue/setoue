package func;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cbd.pos_cbd;

public class fun_pro {

	private static Connection pos_cbd_con;

	public fun_pro() {
		pos_cbd_con = pos_cbd.getPos_cbd();
		// TODO Auto-generated constructor stub

		// TODO Auto-generated constructor stub
	}

	public long pro_nun() throws Exception {

		// 1. Alterado para try-with-resources para fechar rs e stmt automaticamente
		// 2. Alterado para Statement, pois a query não tem parâmetros (?)
		String bc_sql = "SELECT nextval('seq_pro')";

		PreparedStatement stmt = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet rs = stmt.executeQuery();

		if (rs.next()) {
			return rs.getLong(1); // Retorna o valor diretamente
		} else {
			throw new Exception("Não foi possível obter o próximo valor da sequência.");
		}
		// 3. O pos_cbd_con.commit() foi removido. Veja a explicação abaixo.
	}
}
