package cbd;

import java.sql.Connection;
import java.sql.DriverManager;

public class pos_cbd {

	private static String cam_da = "jdbc:postgresql://localhost:5432/ranie4329_setoue_sis?autoeconnect=true";
	private static String p_des = "ranie4329_set";
	private static String p_ics = "S@t753146#";
	private static Connection pos_cbd = null;
 
	public static Connection getPos_cbd() {
		return pos_cbd;

	}

	static {
		conectar();
	}

	public pos_cbd() {
		conectar();
	}

	private static void conectar() {

		try {

			if (pos_cbd == null) {
				Class.forName("org.postgresql.Driver");
				pos_cbd = DriverManager.getConnection(cam_da, p_des, p_ics);
				pos_cbd.setAutoCommit(false);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
