package cla;

import java.io.Serializable;

public class cla_bc_cam implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String win_sis = "tb_sis";
	private String col_sis_id = "id_sis";
	public String getWin_sis() {
		return win_sis;
	}
	public void setWin_sis(String win_sis) {
		this.win_sis = win_sis;
	}
	public String getCol_sis_id() {
		return col_sis_id;
	}
	public void setCol_sis_id(String col_sis_id) {
		this.col_sis_id = col_sis_id;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}


}
