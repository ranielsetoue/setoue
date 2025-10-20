package func;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cbd.pos_cbd;

public class fun_blio {

	private static Connection pos_cbd_con;

	public fun_blio() {
		pos_cbd_con = pos_cbd.getPos_cbd();

	}

	public boolean val_str1(String Win1, String C1l, String Tx1) throws Exception {

		String bc_sql = "select count (1) > 0 as existe from " + Win1 + " where upper(" + C1l + ") = upper('" + Tx1
				+ "')";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet resul = gra_bus.executeQuery();

		resul.next();
		return resul.getBoolean("existe");

	}

	public boolean val_str2(String Win1, String C1l, String Tx1, String C2l, String Tx2) throws Exception {

		String bc_sql = "select count (1) > 0 as existe from " + Win1 + " where upper(" + C1l + ") = upper('" + Tx1
				+ "') AND upper(" + C2l + ") = upper('" + Tx2 + "')";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet resul = gra_bus.executeQuery();

		resul.next();
		return resul.getBoolean("existe");

	}

}
