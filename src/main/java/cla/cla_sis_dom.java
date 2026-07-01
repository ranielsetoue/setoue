
package cla;

import java.io.Serializable;
import java.sql.Timestamp;

public class cla_sis_dom implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id_sis;
	private Long reg_id;
	private Timestamp reg_data;
	private Long reg_alt;
	private Timestamp reg_data_alt;
	private Long id_sis_dom;
	private String no_dom;
	private String sis_url;
	private Long id_sis_log;
	private String l_usu;
	private String l_sen;
	private String tp_sit;
	private String ace_per_aut;
	private String titulo_web;
	private String nome_desc;
	private String email_1;
	
		public String getNome_desc() {
		return nome_desc;
	}

	public void setNome_desc(String nome_desc) {
		this.nome_desc = nome_desc;
	}

	public String getEmail_1() {
		return email_1;
	}

	public void setEmail_1(String email_1) {
		this.email_1 = email_1;
	}

	public String getTitulo_web() {
		return titulo_web;
	}

	public void setTitulo_web(String titulo_web) {
		this.titulo_web = titulo_web;
	}

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
