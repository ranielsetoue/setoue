
package cla;

import java.io.Serializable;
import java.sql.Date;

public class cla_sis_log implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id_sis;
	private Long reg_id;
	private Date reg_data;
	private Long reg_alt;
	private Date reg_data_alt;
	private Long id_sis_log;
	private Long id_sis_dom;
	private String l_usu;
	private String l_sen;

	public boolean nv_id() {
		if (this.id_sis_log == null || this.id_sis_log == 0L) {
			return true;

		} else if (this.id_sis_log != null || this.id_sis_log != 0L || this.id_sis_log > 0l) {
			return false;
		}
		return id_sis_log == null || id_sis_log == 0L;
	}

	public Long getId_sis() {
		return id_sis;
	}

	public void setId_sis(Long id_sis) {
		this.id_sis = id_sis;
	}

	public Long getReg_id() {
		return reg_id;
	}

	public void setReg_id(Long reg_id) {
		this.reg_id = reg_id;
	}

	public Date getReg_data() {
		return reg_data;
	}

	public void setReg_data(Date reg_data) {
		this.reg_data = reg_data;
	}

	public Long getReg_alt() {
		return reg_alt;
	}

	public void setReg_alt(Long reg_alt) {
		this.reg_alt = reg_alt;
	}

	public Date getReg_data_alt() {
		return reg_data_alt;
	}

	public void setReg_data_alt(Date reg_data_alt) {
		this.reg_data_alt = reg_data_alt;
	}

	public Long getId_sis_log() {
		return id_sis_log;
	}

	public void setId_sis_log(Long id_sis_log) {
		this.id_sis_log = id_sis_log;
	}

	public Long getId_sis_dom() {
		return id_sis_dom;
	}

	public void setId_sis_dom(Long id_sis_dom) {
		this.id_sis_dom = id_sis_dom;
	}

	public String getL_usu() {
		return l_usu;
	}

	public void setL_usu(String l_usu) {
		this.l_usu = l_usu;
	}

	public String getL_sen() {
		return l_sen;
	}

	public void setL_sen(String l_sen) {
		this.l_sen = l_sen;
	}

	public void vz_id() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		id_sis_log = 0L;
		id_sis_dom = 0L;
		l_usu = "";
		l_sen = "";

	}

	public void vz_con() {

	}

	public void vz_gr() {

	}

}
