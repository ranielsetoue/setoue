
package cla;

import java.io.Serializable;
import java.sql.Date;

public class cla_sis_d_log implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id_sis;
	private Long reg_id;
	private Date reg_data;
	private Long reg_alt;
	private Date reg_data_alt;
	private Long id_sis_d_log;
	private Long id_sis_log;
	private String nome_desc;
	private String email_1;
	private String foto;
	private String caminho_foto;

	public boolean nv_id() {
		if (this.id_sis_d_log == null || this.id_sis_d_log == 0L) {
			return true;

		} else if (this.id_sis_d_log != null || this.id_sis_d_log != 0L || this.id_sis_d_log > 0l) {
			return false;
		}
		return id_sis_d_log == null || id_sis_d_log == 0L;
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

	public Long getId_sis_d_log() {
		return id_sis_d_log;
	}

	public void setId_sis_d_log(Long id_sis_d_log) {
		this.id_sis_d_log = id_sis_d_log;
	}

	public Long getId_sis_log() {
		return id_sis_log;
	}

	public void setId_sis_log(Long id_sis_log) {
		this.id_sis_log = id_sis_log;
	}

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

	public String getFoto() {
		return foto;
	}

	public void setFoto(String foto) {
		this.foto = foto;
	}

	public String getCaminho_foto() {
		return caminho_foto;
	}

	public void setCaminho_foto(String caminho_foto) {
		this.caminho_foto = caminho_foto;
	}

	public void vz_id() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		id_sis_d_log = 0L;
		id_sis_log = 0L;
		nome_desc = "";
		email_1 = "";
		foto = "";
		caminho_foto = "";

	}

	public void vz_con() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		id_sis_log = 0L;
		id_sis_log = 0L;
		nome_desc = "";
		email_1 = "";
		foto = "";
		caminho_foto = "";

	}

	public void vz_gr() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		id_sis_log = 0L;
		id_sis_log = 0L;
		nome_desc = "";
		email_1 = "";
		foto = "";
		caminho_foto = "";

	}

}
