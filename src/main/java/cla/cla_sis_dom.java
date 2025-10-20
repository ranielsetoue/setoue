
package cla;

import java.io.Serializable;
import java.sql.Date;

public class cla_sis_dom implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id_sis;
	private Long reg_id;
	private Date reg_data;
	private Long reg_alt;
	private Date reg_data_alt;
	private Long id_sis_dom;
	private String no_dom;
	private String sis_url;
	private Long id_sis_log;
	private String l_usu;
	private String l_sen;
	private String tp_sit;
	private String ace_per_aut;

	public boolean nv_id() {
		if (this.id_sis_dom == null || this.id_sis_dom == 0L) {
			return true;

		} else if (this.id_sis_dom != null || this.id_sis_dom != 0L || this.id_sis_dom > 0l) {
			return false;
		}
		return id_sis_dom == null || id_sis_dom == 0L;
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

	public Long getId_sis_dom() {
		return id_sis_dom;
	}

	public void setId_sis_dom(Long id_sis_dom) {
		this.id_sis_dom = id_sis_dom;
	}

	public String getNo_dom() {
		return no_dom;
	}

	public void setNo_dom(String no_dom) {
		this.no_dom = no_dom;
	}

	public String getSis_url() {
		return sis_url;
	}

	public void setSis_url(String sis_url) {
		this.sis_url = sis_url;
	}

	public Long getId_sis_log() {
		return id_sis_log;
	}

	public void setId_sis_log(Long id_sis_log) {
		this.id_sis_log = id_sis_log;
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

	public String getTp_sit() {
		return tp_sit;
	}

	public void setTp_sit(String tp_sit) {
		this.tp_sit = tp_sit;
	}

	public String getAce_per_aut() {
		return ace_per_aut;
	}

	public void setAce_per_aut(String ace_per_aut) {
		this.ace_per_aut = ace_per_aut;
	}

	public void vz_id() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		id_sis_dom = 0L;
		no_dom = "";
		sis_url = "";
		id_sis_log = 0L;
		l_usu = "";
		l_sen = "";
		tp_sit = "";
		ace_per_aut = "";

	}

	public void vz_con() {

		no_dom = "";
		sis_url = "";
		id_sis_log = 0L;
		l_usu = "";
		l_sen = "";
		tp_sit = "";
		ace_per_aut = "";

	}

	public void vz_gr() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		id_sis_dom = 0L;

	}

}
