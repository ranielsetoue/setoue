
package cla;

import java.io.Serializable;
import java.sql.Timestamp;

public class cla_glo_ad implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id_sis;
	private Long reg_id;
	private Timestamp reg_data;
	private Long reg_alt;
	private Timestamp reg_data_alt;
	private Boolean truefalse;
	private Long sis_adi_id;
	private String tel_2;
	private String email_2;
	private Long login_id;
	private Long clin_id; 
	public boolean isTruefalse() {
		return truefalse;
	}



	public Long getClin_id() {
		return clin_id;
	}



	public void setClin_id(Long clin_id) {
		this.clin_id = clin_id;
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



	public Timestamp getReg_data() {
		return reg_data;
	}



	public void setReg_data(Timestamp reg_data) {
		this.reg_data = reg_data;
	}



	public Long getReg_alt() {
		return reg_alt;
	}



	public void setReg_alt(Long reg_alt) {
		this.reg_alt = reg_alt;
	}



	public Timestamp getReg_data_alt() {
		return reg_data_alt;
	}



	public void setReg_data_alt(Timestamp reg_data_alt) {
		this.reg_data_alt = reg_data_alt;
	}



	public Boolean getTruefalse() {
		return truefalse;
	}



	public void setTruefalse(Boolean truefalse) {
		this.truefalse = truefalse;
	}



	public Long getSis_adi_id() {
		return sis_adi_id;
	}



	public void setSis_adi_id(Long sis_adi_id) {
		this.sis_adi_id = sis_adi_id;
	}



	public String getTel_2() {
		return tel_2;
	}



	public void setTel_2(String tel_2) {
		this.tel_2 = tel_2;
	}



	public String getEmail_2() {
		return email_2;
	}



	public void setEmail_2(String email_2) {
		this.email_2 = email_2;
	}



	public Long getLogin_id() {
		return login_id;
	}



	public void setLogin_id(Long login_id) {
		this.login_id = login_id;
	}



	public static long getSerialversionuid() {
		return serialVersionUID;
	}



	public void vz_id() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		login_id = 0L;
		tel_2 = "";
		email_2 = "";

	}

	public void vz_con() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		login_id = 0L;
		tel_2 = "";
		email_2 = "";

	}

	public void vz_gr() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		login_id = 0L;
		tel_2 = "";
		email_2 = "";

	}

}
