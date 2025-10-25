
package cla;

import java.io.Serializable;
import java.sql.Date;

public class cla_perm_ace implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id_sis;
	private Long reg_id;
	private Date reg_data;
	private Long reg_alt;
	private Date reg_data_alt;
	private Long per_ace_id;
	private Long id_sis_log;
	private Boolean aces_cad_sis;
	private Boolean aces_cad_clin;
	private Boolean aces_cad_forn;
	private Boolean aces_cad_prod;
	private Boolean aces_cad_serv;
    private Boolean aces_desv;	
	
	public boolean nv_id() {
		if (this.per_ace_id == null || this.per_ace_id == 0L) {
			return true;

		} else if (this.per_ace_id != null || this.per_ace_id != 0L || this.per_ace_id > 0l) {
			return false;
		}
		return per_ace_id == null || per_ace_id == 0L;
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

	public Long getPer_ace_id() {
		return per_ace_id;
	}

	public void setPer_ace_id(Long per_ace_id) {
		this.per_ace_id = per_ace_id;
	}

	public Long getId_sis_log() {
		return id_sis_log;
	}

	public void setId_sis_log(Long id_sis_log) {
		this.id_sis_log = id_sis_log;
	}

	public Boolean getAces_cad_sis() {
		return aces_cad_sis;
	}

	public void setAces_cad_sis(Boolean aces_cad_sis) {
		this.aces_cad_sis = aces_cad_sis;
	}

	public Boolean getAces_cad_clin() {
		return aces_cad_clin;
	}

	public void setAces_cad_clin(Boolean aces_cad_clin) {
		this.aces_cad_clin = aces_cad_clin;
	}

	public Boolean getAces_cad_forn() {
		return aces_cad_forn;
	}

	public void setAces_cad_forn(Boolean aces_cad_forn) {
		this.aces_cad_forn = aces_cad_forn;
	}

	public Boolean getAces_cad_prod() {
		return aces_cad_prod;
	}

	public void setAces_cad_prod(Boolean aces_cad_prod) {
		this.aces_cad_prod = aces_cad_prod;
	}

	public Boolean getAces_cad_serv() {
		return aces_cad_serv;
	}

	public void setAces_cad_serv(Boolean aces_cad_serv) {
		this.aces_cad_serv = aces_cad_serv;
	}
	
	public Boolean getAces_desv() {
		return aces_desv;
	}

	public void setAces_desv(Boolean aces_desv) {
		this.aces_desv = aces_desv;
	}

	

	public void vz_id() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		per_ace_id = 0L;
		id_sis_log = 0L;
		aces_cad_sis = false;
		aces_cad_clin = false;
		aces_cad_forn = false;
		aces_cad_prod = false;
		aces_cad_serv = false;

	}

	public void vz_con() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		per_ace_id = 0L;
		id_sis_log = 0L;

	}

	public void vz_gr() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		per_ace_id = 0L;
		id_sis_log = 0L;

	}

}
