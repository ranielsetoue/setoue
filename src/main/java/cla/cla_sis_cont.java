
package cla;

import java.io.Serializable;
import java.sql.Timestamp;

public class cla_sis_cont implements Serializable {

private static final long serialVersionUID = 1L;

private Long id_sis;
private Long reg_id;
private Timestamp reg_data;
private Long reg_alt;
private Timestamp reg_data_alt;
private Long id_sis_cont;
private String nome_desc;
private String tel_1;
private String tel_2;
private String email_1;
private String email_2;
private String setor_1;
private String obs;
private Long id_sis_log;
private String l_usu;
private String l_sen;
private String tipo_ace;

public boolean nv_id() {
if (this.id_sis_cont == null || this.id_sis_cont == 0L) {
return true;

}else if (this.id_sis_cont != null || this.id_sis_cont != 0L || this.id_sis_cont > 0l) {
return false;
}
return id_sis_cont == null || id_sis_cont == 0L;
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
public Long getId_sis_cont() {
return id_sis_cont;
}
public void setId_sis_cont(Long id_sis_cont) {
this.id_sis_cont = id_sis_cont;
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
public String getTipo_ace() {
return tipo_ace;
}
public void setTipo_ace(String tipo_ace) {
this.tipo_ace = tipo_ace;
}

public void vz_id() {

id_sis = 0L;
reg_id = 0L;
reg_data = null;
reg_alt = 0L;
reg_data_alt = null;
id_sis_cont = 0L;
nome_desc = "";
tel_1 = "";
tel_2 = "";
email_1 = "";
email_2 = "";
setor_1 = "";
obs = "";
id_sis_log = 0L;
l_usu = "";
l_sen = "";
tipo_ace = "";

}

public void vz_con() {

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
reg_id = 0L;

}

}


