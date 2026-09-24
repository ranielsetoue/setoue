
package cla;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Objects;

public class cla_clin implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id_sis;
	private Long clin_id;
	private Long reg_id;
	private Timestamp reg_data;
	private Long reg_alt;
	private Timestamp reg_data_alt;
	private Boolean truefalse;
	private String ace_per_aut;
	private String nome_desc;
	private String no_fan;
	private String cnpj_cpf;
	private String end_rua;
	private String end_num;
	private String end_com;
	private String end_bar;
	private String end_mun;
	private String end_uf;
	private String end_cep;
	private String ins_est;
	private String ins_mun;
	private String tel_1;
	private String email_1;
	private String site_dom;
	private String obs;
	private Long login_id;
	private String l_usu;
	private String l_sen;
	private String tel_2;
	private String email_nf;

	public boolean nv_id() {
		if (this.clin_id == null || this.clin_id == 0L) {
			return true;

		} else if (this.clin_id != null || this.clin_id != 0L || this.clin_id > 0l) {
			return false;
		}
		return clin_id == null || clin_id == 0L;
	}

	public Long getId_sis() {
		return id_sis;
	}

	public void setId_sis(Long id_sis) {
		this.id_sis = id_sis;
	}

	public Long getClin_id() {
		return clin_id;
	}

	public void setClin_id(Long clin_id) {
		this.clin_id = clin_id;
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

	public String getNome_desc() {
		return nome_desc;
	}

	public void setNome_desc(String nome_desc) {
		this.nome_desc = nome_desc;
	}

	public String getNo_fan() {
		return no_fan;
	}

	public void setNo_fan(String no_fan) {
		this.no_fan = no_fan;
	}

	public String getCnpj_cpf() {
		return cnpj_cpf;
	}

	public void setCnpj_cpf(String cnpj_cpf) {
		this.cnpj_cpf = cnpj_cpf;
	}

	public String getEnd_rua() {
		return end_rua;
	}

	public void setEnd_rua(String end_rua) {
		this.end_rua = end_rua;
	}

	public String getEnd_num() {
		return end_num;
	}

	public void setEnd_num(String end_num) {
		this.end_num = end_num;
	}

	public String getEnd_com() {
		return end_com;
	}

	public void setEnd_com(String end_com) {
		this.end_com = end_com;
	}

	public String getEnd_bar() {
		return end_bar;
	}

	public void setEnd_bar(String end_bar) {
		this.end_bar = end_bar;
	}

	public String getEnd_mun() {
		return end_mun;
	}

	public void setEnd_mun(String end_mun) {
		this.end_mun = end_mun;
	}

	public String getEnd_uf() {
		return end_uf;
	}

	public void setEnd_uf(String end_uf) {
		this.end_uf = end_uf;
	}

	public String getEnd_cep() {
		return end_cep;
	}

	public void setEnd_cep(String end_cep) {
		this.end_cep = end_cep;
	}

	public String getIns_est() {
		return ins_est;
	}

	public void setIns_est(String ins_est) {
		this.ins_est = ins_est;
	}

	public String getIns_mun() {
		return ins_mun;
	}

	public void setIns_mun(String ins_mun) {
		this.ins_mun = ins_mun;
	}

	public String getTel_1() {
		return tel_1;
	}

	public void setTel_1(String tel_1) {
		this.tel_1 = tel_1;
	}

	public String getEmail_1() {
		return email_1;
	}

	public void setEmail_1(String email_1) {
		this.email_1 = email_1;
	}

	public String getSite_dom() {
		return site_dom;
	}

	public void setSite_dom(String site_dom) {
		this.site_dom = site_dom;
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

	public String getTel_2() {
		return tel_2;
	}

	public void setTel_2(String tel_2) {
		this.tel_2 = tel_2;
	}

	public String getEmail_nf() {
		return email_nf;
	}

	public void setEmail_nf(String email_nf) {
		this.email_nf = email_nf;
	}

	public void vz_id() {

		id_sis = 0L;
		clin_id = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		truefalse = false;
		ace_per_aut = "";
		nome_desc = "";
		no_fan = "";
		cnpj_cpf = "";
		end_rua = "";
		end_num = "";
		end_com = "";
		end_bar = "";
		end_mun = "";
		end_uf = "";
		end_cep = "";
		ins_est = "";
		ins_mun = "";
		tel_1 = "";
		email_1 = "";
		site_dom = "";
		obs = "";
		login_id = 0L;
		l_usu = "";
		l_sen = "";
		tel_2 = "";
		email_nf = "";

	}

	public void vz_con() {

		no_fan = "";
		end_rua = "";
		end_num = "";
		end_com = "";
		end_bar = "";
		end_mun = "";
		end_uf = "";
		end_cep = "";
		ins_est = "";
		ins_mun = "";
		obs = "";

	}

	public void vz_gr() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;

	}

	@Override
	public String toString() {
		return "cla_clin [id_sis=" + id_sis + ", clin_id=" + clin_id + ", reg_id=" + reg_id + ", reg_data=" + reg_data
				+ ", reg_alt=" + reg_alt + ", reg_data_alt=" + reg_data_alt + ", truefalse=" + truefalse
				+ ", ace_per_aut=" + ace_per_aut + ", nome_desc=" + nome_desc + ", no_fan=" + no_fan + ", cnpj_cpf="
				+ cnpj_cpf + ", end_rua=" + end_rua + ", end_num=" + end_num + ", end_com=" + end_com + ", end_bar="
				+ end_bar + ", end_mun=" + end_mun + ", end_uf=" + end_uf + ", end_cep=" + end_cep + ", ins_est="
				+ ins_est + ", ins_mun=" + ins_mun + ", tel_1=" + tel_1 + ", email_1=" + email_1 + ", site_dom="
				+ site_dom + ", obs=" + obs + ", login_id=" + login_id + ", l_usu=" + l_usu + ", l_sen=" + l_sen
				+ ", tel_2=" + tel_2 + ", email_nf=" + email_nf + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(ace_per_aut, clin_id, cnpj_cpf, email_1, email_nf, end_bar, end_cep, end_com, end_mun,
				end_num, end_rua, end_uf, id_sis, ins_est, ins_mun, l_sen, l_usu, login_id, no_fan, nome_desc, obs,
				reg_alt, reg_data, reg_data_alt, reg_id, site_dom, tel_1, tel_2, truefalse);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		cla_clin other = (cla_clin) obj;
		return Objects.equals(ace_per_aut, other.ace_per_aut) && Objects.equals(clin_id, other.clin_id)
				&& Objects.equals(cnpj_cpf, other.cnpj_cpf) && Objects.equals(email_1, other.email_1)
				&& Objects.equals(email_nf, other.email_nf) && Objects.equals(end_bar, other.end_bar)
				&& Objects.equals(end_cep, other.end_cep) && Objects.equals(end_com, other.end_com)
				&& Objects.equals(end_mun, other.end_mun) && Objects.equals(end_num, other.end_num)
				&& Objects.equals(end_rua, other.end_rua) && Objects.equals(end_uf, other.end_uf)
				&& Objects.equals(id_sis, other.id_sis) && Objects.equals(ins_est, other.ins_est)
				&& Objects.equals(ins_mun, other.ins_mun) && Objects.equals(l_sen, other.l_sen)
				&& Objects.equals(l_usu, other.l_usu) && Objects.equals(login_id, other.login_id)
				&& Objects.equals(no_fan, other.no_fan) && Objects.equals(nome_desc, other.nome_desc)
				&& Objects.equals(obs, other.obs) && Objects.equals(reg_alt, other.reg_alt)
				&& Objects.equals(reg_data, other.reg_data) && Objects.equals(reg_data_alt, other.reg_data_alt)
				&& Objects.equals(reg_id, other.reg_id) && Objects.equals(site_dom, other.site_dom)
				&& Objects.equals(tel_1, other.tel_1) && Objects.equals(tel_2, other.tel_2)
				&& Objects.equals(truefalse, other.truefalse);
	}

}
