package func;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cbd.pos_cbd;
import cla.cla_sis_d_log;
import cla.cla_sis_dom;
import cla.cla_sis_log;

public class fun_sis_dom {

	private static Connection pos_cbd_con;

	public fun_sis_dom() {
		pos_cbd_con = pos_cbd.getPos_cbd();

	}

	public boolean val_str1_sis_dom_no_dom(String tx1) throws Exception {

	    tx1 = tx1.replaceAll("\\s+", ""); // remove TODOS os espaços
	    tx1 = tx1.toUpperCase();

	    String bc_sql =
	        "SELECT  count (1) > 0 as existe " +
	        "FROM tb_sis_dom " +
	        "WHERE REPLACE(UPPER(no_dom),' ','') = UPPER('" + tx1 + "')";

	    PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

	    ResultSet resul = gra_bus.executeQuery();

		resul.next();
		return resul.getBoolean("existe");

	    
		}	
	
	
	public cla_sis_dom cons_sis_dom_id_sis_dom(Long id_sis_log) throws Exception {

		cla_sis_dom gra_inp = new cla_sis_dom();

		String bc_sql = "select * FROM tb_sis_dom where id_sis_log = '" + id_sis_log + "'";
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_sis_dom = gra_bus.executeQuery();

		while (cl_sis_dom.next()) {

			gra_inp.setId_sis(cl_sis_dom.getLong("id_sis"));
			gra_inp.setReg_id(cl_sis_dom.getLong("reg_id"));
			gra_inp.setReg_data(cl_sis_dom.getTimestamp("reg_data"));
			gra_inp.setReg_alt(cl_sis_dom.getLong("reg_alt"));
			gra_inp.setReg_data_alt(cl_sis_dom.getTimestamp("reg_data_alt"));
			gra_inp.setId_sis_dom(cl_sis_dom.getLong("id_sis_dom"));
			gra_inp.setNo_dom(cl_sis_dom.getString("no_dom"));
			gra_inp.setSis_url(cl_sis_dom.getString("sis_url"));
			gra_inp.setId_sis_log(cl_sis_dom.getLong("id_sis_log"));
			gra_inp.setL_usu(cl_sis_dom.getString("l_usu"));
			gra_inp.setL_sen(cl_sis_dom.getString("l_sen"));
			gra_inp.setTp_sit(cl_sis_dom.getString("tp_sit"));
			gra_inp.setAce_per_aut(cl_sis_dom.getString("ace_per_aut"));
			gra_inp.setTitulo_web(cl_sis_dom.getString("titulo_web"));

		}

		return gra_inp;

	}

	public cla_sis_dom cons_sis_dom_no_dom(String tx1) throws Exception {

		cla_sis_dom gra_inp = new cla_sis_dom();

	    tx1 = tx1.replaceAll("\\s+", ""); // remove TODOS os espaços
	    tx1 = tx1.toUpperCase();
		
		String bc_sql = "select * FROM tb_sis_dom where REPLACE(UPPER(no_dom),' ','') = upper('" + tx1 + "')";

		
		
		PreparedStatement gra_bus = pos_cbd_con.prepareStatement(bc_sql);

		ResultSet cl_sis_dom = gra_bus.executeQuery();

		while (cl_sis_dom.next()) {

			gra_inp.setId_sis(cl_sis_dom.getLong("id_sis"));
			gra_inp.setReg_id(cl_sis_dom.getLong("reg_id"));
			gra_inp.setReg_data(cl_sis_dom.getTimestamp("reg_data"));
			gra_inp.setReg_alt(cl_sis_dom.getLong("reg_alt"));
			gra_inp.setReg_data_alt(cl_sis_dom.getTimestamp("reg_data_alt"));
			gra_inp.setId_sis_dom(cl_sis_dom.getLong("id_sis_dom"));
			gra_inp.setNo_dom(cl_sis_dom.getString("no_dom"));
			gra_inp.setSis_url(cl_sis_dom.getString("sis_url"));
			gra_inp.setId_sis_log(cl_sis_dom.getLong("id_sis_log"));
			gra_inp.setL_usu(cl_sis_dom.getString("l_usu"));
			gra_inp.setL_sen(cl_sis_dom.getString("l_sen"));
			gra_inp.setTp_sit(cl_sis_dom.getString("tp_sit"));
			gra_inp.setAce_per_aut(cl_sis_dom.getString("ace_per_aut"));
			gra_inp.setTitulo_web(cl_sis_dom.getString("titulo_web"));

		}

		return gra_inp;

	}

	
	public cla_sis_log id_ger(cla_sis_log gra_bus) throws Exception {

	    String bc_sql = "SELECT nextval('seq_sis_log')";

	    PreparedStatement stmt = pos_cbd_con.prepareStatement(bc_sql);

	    ResultSet rs = stmt.executeQuery();

	    Long idGerado = null;

	    if (rs.next()) {
	        idGerado = rs.getLong(1);
	    }

	    rs.close();
	    stmt.close();

	    pos_cbd_con.commit();

	    System.out.println("Próximo ID: " + idGerado);


	    return gra_bus;
	}

		
	public cla_sis_d_log id_d_ger(cla_sis_d_log gra_bus) throws Exception {

	    String bc_sql = "SELECT nextval('seq_sis_d_log')";

	    PreparedStatement stmt = pos_cbd_con.prepareStatement(bc_sql);

	    ResultSet rs = stmt.executeQuery();

	    Long iddGerado = null;

	    if (rs.next()) {
	        iddGerado = rs.getLong(1);
	    }

	    rs.close();
	    stmt.close();

	    pos_cbd_con.commit();
	    
	    gra_bus.setId_sis_d_log(iddGerado);

	    return gra_bus;
	}

		
	public cla_sis_dom sav_dom(cla_sis_dom gra_bus,cla_sis_log gra_bus1) throws Exception {

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

	    
	  
	
		if (gra_bus.nv_id() && !val_str1_sis_dom_no_dom(gra_bus.getNo_dom())
				) {

			String bc_sql = "INSERT INTO public.tb_sis_dom(\r\n"

					+ "id_sis, reg_id, reg_data, reg_alt, reg_data_alt, \r\n"
					+ "            no_dom, sis_url, id_sis_log, l_usu, l_sen, tp_sit, ace_per_aut, \r\n"
					+ "            titulo_web) \r\n"
					+ " VALUES (?,  ?, ?, ?, ?, \r\n"
					+ "            ?, ?, ?, ?, ?, ?, ?, \r\n"
					+ "            ?);";

			PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			gra_inp.setLong(1, gra_bus.getId_sis());
			gra_inp.setLong(2, gra_bus.getReg_id());
			gra_inp.setTimestamp(3, gra_bus.getReg_data());
			gra_inp.setLong(4, gra_bus.getReg_alt());
			gra_inp.setTimestamp(5, gra_bus.getReg_data_alt());
			gra_inp.setString(6, gra_bus.getNo_dom());
			gra_inp.setString(7, gra_bus.getSis_url());
			//gra_inp.setLong(8, gra_bus.getId_sis_log());
			gra_inp.setLong(8, id_log);		
			gra_inp.setString(9, gra_bus.getL_usu());
			gra_inp.setString(10, gra_bus.getL_sen());
			gra_inp.setString(11, gra_bus.getTp_sit());
			gra_inp.setString(12, gra_bus.getAce_per_aut());
			gra_inp.setString(13, gra_bus.getTitulo_web());
			gra_inp.execute();
			pos_cbd_con.commit();

		
		} else {

			String bc_sql = "UPDATE public.tb_sis_dom\r\n"

					+ " SET reg_alt=? \r\n"
					+ " WHERE id_sis = " + gra_bus.getId_sis() + ";";

			PreparedStatement gra_inp = pos_cbd_con.prepareStatement(bc_sql);

			gra_inp.setLong(1, gra_bus.getReg_alt());
		

			gra_inp.executeUpdate();
			pos_cbd_con.commit();
		}
		return this.cons_sis_dom_no_dom(gra_bus.getNo_dom());
	}
	
	
	public List<cla_sis_dom> cons_dom_id_p1(long nx1, long offset) throws Exception {

		/* 
		 * limite de paginação
		 * select * FROM tb_sistema_dominio where id_sistema = 1 order by id_sistema offset 0 limit 3		
		 */
				
				List<cla_sis_dom> retorno = new ArrayList<>();

				String bc_sql = "select * FROM tb_sis_dom where id_sis = " + nx1 + " order by no_dom offset " + offset + " limit 5 " ;
				PreparedStatement gra_dom = pos_cbd_con.prepareStatement(bc_sql);
				ResultSet gra_bus = gra_dom.executeQuery();

				while(gra_bus.next()){

					cla_sis_dom gra_inp = new cla_sis_dom();

					gra_inp.setId_sis(gra_bus.getLong("id_sis"));
					gra_inp.setId_sis_dom(gra_bus.getLong("id_sis_dom"));
					gra_inp.setNo_dom(gra_bus.getString("no_dom"));
					gra_inp.setSis_url(gra_bus.getString("sis_url"));
					gra_inp.setId_sis_log(gra_bus.getLong("id_sis_log"));
					gra_inp.setL_usu(gra_bus.getString("l_usu"));
					gra_inp.setL_sen(gra_bus.getString("l_sen"));
					gra_inp.setTp_sit(gra_bus.getString("tp_sit"));
					gra_inp.setAce_per_aut(gra_bus.getString("ace_per_aut"));
					gra_inp.setTitulo_web(gra_bus.getString("titulo_web"));
					
					retorno.add(gra_inp);

				}

				return retorno;
			}
	
}
