
package cla;

import java.io.Serializable;
import java.sql.Timestamp;

public class cla_clin_cont implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id_sis;
	private Long reg_id;
	private Timestamp reg_data;
	private Long reg_alt;
	private Timestamp reg_data_alt;
	private Boolean truefalse;
	private String ace_per_aut;
	private Long clin_id;
	private Long clin_cont_id;
	private String nome_desc;
	private String tel_1;
	private String tel_2;
	private String email_1;
	private String email_2;
	private String setor_1;
	private String obs;
	private Long login_id;
	private String l_usu;
	private String l_sen;

	public boolean nv_id() {
		if (this.clin_cont_id == null || this.clin_cont_id == 0L) {
			return true;

		} else if (this.clin_cont_id != null || this.clin_cont_id != 0L || this.clin_cont_id > 0l) {
			return false;
		}
		return clin_cont_id == null || clin_cont_id == 0L;
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

	public String getAce_per_aut() {
		return ace_per_aut;
	}

	public void setAce_per_aut(String ace_per_aut) {
		this.ace_per_aut = ace_per_aut;
	}

	public Long getClin_id() {
		return clin_id;
	}

	public void setClin_id(Long clin_id) {
		this.clin_id = clin_id;
	}

	public Long getClin_cont_id() {
		return clin_cont_id;
	}

	public void setClin_cont_id(Long clin_cont_id) {
		this.clin_cont_id = clin_cont_id;
	}

	public String getNome_desc() {
		return nome_desc;
	}

	public void setNome_desc(String nome_desc) {
		this.nome_desc = nome_desc;
	}

	public String getTel_1() {
		return tel_1;
	}

	public void setTel_1(String tel_1) {
		this.tel_1 = tel_1;
	}

	public String getTel_2() {
		return tel_2;
	}

	public void setTel_2(String tel_2) {
		this.tel_2 = tel_2;
	}

	public String getEmail_1() {
		return email_1;
	}

	public void setEmail_1(String email_1) {
		this.email_1 = email_1;
	}

	public String getEmail_2() {
		return email_2;
	}

	public void setEmail_2(String email_2) {
		this.email_2 = email_2;
	}

	public String getSetor_1() {
		return setor_1;
	}

	public void setSetor_1(String setor_1) {
		this.setor_1 = setor_1;
	}

	public String getObs() {
		return obs;
	}

	public void setObs(String obs) {
		this.obs = obs;
	}

	public Long getLogin_id() {
		return login_id;
	}

	public void setLogin_id(Long login_id) {
		this.login_id = login_id;
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
		truefalse = false;
		ace_per_aut = "";
		clin_id = 0L;
		clin_cont_id = 0L;
		nome_desc = "";
		tel_1 = "";
		tel_2 = "";
		email_1 = "";
		email_2 = "";
		setor_1 = "";
		obs = "";
		login_id = 0L;
		l_usu = "";
		l_sen = "";

	}

	public void vz_con() {

		clin_cont_id = 0L;
		nome_desc = "";
		tel_1 = "";
		tel_2 = "";
		email_1 = "";
		email_2 = "";
		setor_1 = "";
		obs = "";

	}

	public void vz_gr() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		clin_id = 0L;
		clin_cont_id = 0L;
		nome_desc = "";
		tel_1 = "";
		tel_2 = "";
		email_1 = "";
		email_2 = "";
		setor_1 = "";
		obs = "";

	}

}
