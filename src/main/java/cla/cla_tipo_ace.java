
package cla;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Objects;

public class cla_tipo_ace implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id_sis;
	private Long reg_id;
	private Timestamp reg_data;
	private Long reg_alt;
	private Timestamp reg_data_alt;
	private Long tipo_ace_id;
	private String nome_desc;
	private Boolean aces_cad_sis;
	private Boolean aces_cad_clin;
	private Boolean aces_cad_forn;
	private Boolean aces_cad_prod;
	private Boolean aces_cad_serv;
	private Boolean aces_desv;

	public boolean nv_id() {
		if (this.tipo_ace_id == null || this.tipo_ace_id == 0L) {
			return true;

		} else if (this.tipo_ace_id != null || this.tipo_ace_id != 0L || this.tipo_ace_id > 0l) {
			return false;
		}
		return tipo_ace_id == null || tipo_ace_id == 0L;
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

	public Long getTipo_ace_id() {
		return tipo_ace_id;
	}

	public void setTipo_ace_id(Long tipo_ace_id) {
		this.tipo_ace_id = tipo_ace_id;
	}

	public String getNome_desc() {
		return nome_desc;
	}

	public void setNome_desc(String nome_desc) {
		this.nome_desc = nome_desc;
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

	public void vz_id() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		tipo_ace_id = 0L;
		nome_desc = "";
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
		tipo_ace_id = 0L;
		nome_desc = "";

	}

	public void vz_gr() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		tipo_ace_id = 0L;
		nome_desc = "";

	}

	@Override
	public String toString() {
		return "cla_tipo_ace [id_sis=" + id_sis + ", reg_id=" + reg_id + ", reg_data=" + reg_data + ", reg_alt="
				+ reg_alt + ", reg_data_alt=" + reg_data_alt + ", tipo_ace_id=" + tipo_ace_id + ", nome_desc="
				+ nome_desc + ", aces_cad_sis=" + aces_cad_sis + ", aces_cad_clin=" + aces_cad_clin + ", aces_cad_forn="
				+ aces_cad_forn + ", aces_cad_prod=" + aces_cad_prod + ", aces_cad_serv=" + aces_cad_serv
				+ ", aces_desv=" + aces_desv + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(aces_cad_clin, aces_cad_forn, aces_cad_prod, aces_cad_serv, aces_cad_sis, aces_desv, id_sis,
				nome_desc, reg_alt, reg_data, reg_data_alt, reg_id, tipo_ace_id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		cla_tipo_ace other = (cla_tipo_ace) obj;
		return Objects.equals(aces_cad_clin, other.aces_cad_clin) && Objects.equals(aces_cad_forn, other.aces_cad_forn)
				&& Objects.equals(aces_cad_prod, other.aces_cad_prod)
				&& Objects.equals(aces_cad_serv, other.aces_cad_serv)
				&& Objects.equals(aces_cad_sis, other.aces_cad_sis) && Objects.equals(aces_desv, other.aces_desv)
				&& Objects.equals(id_sis, other.id_sis) && Objects.equals(nome_desc, other.nome_desc)
				&& Objects.equals(reg_alt, other.reg_alt) && Objects.equals(reg_data, other.reg_data)
				&& Objects.equals(reg_data_alt, other.reg_data_alt) && Objects.equals(reg_id, other.reg_id)
				&& Objects.equals(tipo_ace_id, other.tipo_ace_id);
	}

	public Boolean getAces_desv() {
		return aces_desv;
	}

	public void setAces_desv(Boolean aces_desv) {
		this.aces_desv = aces_desv;
	}

	
	
	
}
