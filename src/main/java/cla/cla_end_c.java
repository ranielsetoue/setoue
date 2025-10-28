package cla;

import java.io.Serializable;

public class cla_end_c implements Serializable {

private static final long serialVersionUID = 1L;

private Long id_end_c;
private String pais;
private String estado;
private String uf;
private String municipio;
private String bairro;
private String enderenco;
private String numero;
private String complemento;
private String cep;
private String logradouro;
private String unidade;
private String localidade;
private String regiao;
private String ibge;
private String gia;
private String ddd;
private String siafi;

public boolean end_c_novo() {
if (this.id_end_c == null) {
return true;
 
}else if (this.id_end_c != null || this.id_end_c > 0) {
return false;
}
return id_end_c == null;
}
 
 
 
public Long getId_end_c() {
return id_end_c;
}
public void setId_end_c(Long id_end_c) {
this.id_end_c = id_end_c;
}
public String getPais() {
return pais;
}
public void setPais(String pais) {
this.pais = pais;
}
public String getEstado() {
return estado;
}
public void setEstado(String estado) {
this.estado = estado;
}
public String getUf() {
return uf;
}
public void setUf(String uf) {
this.uf = uf;
}
public String getMunicipio() {
return municipio;
}
public void setMunicipio(String municipio) {
this.municipio = municipio;
}
public String getBairro() {
return bairro;
}
public void setBairro(String bairro) {
this.bairro = bairro;
}
public String getEnderenco() {
return enderenco;
}
public void setEnderenco(String enderenco) {
this.enderenco = enderenco;
}
public String getNumero() {
return numero;
}
public void setNumero(String numero) {
this.numero = numero;
}
public String getComplemento() {
return complemento;
}
public void setComplemento(String complemento) {
this.complemento = complemento;
}
public String getCep() {
return cep;
}
public void setCep(String cep) {
this.cep = cep;
}
public String getLogradouro() {
return logradouro;
}
public void setLogradouro(String logradouro) {
this.logradouro = logradouro;
}
public String getUnidade() {
return unidade;
}
public void setUnidade(String unidade) {
this.unidade = unidade;
}
public String getLocalidade() {
return localidade;
}
public void setLocalidade(String localidade) {
this.localidade = localidade;
}
public String getRegiao() {
return regiao;
}
public void setRegiao(String regiao) {
this.regiao = regiao;
}
public String getIbge() {
return ibge;
}
public void setIbge(String ibge) {
this.ibge = ibge;
}
public String getGia() {
return gia;
}
public void setGia(String gia) {
this.gia = gia;
}
public String getDdd() {
return ddd;
}
public void setDdd(String ddd) {
this.ddd = ddd;
}
public String getSiafi() {
return siafi;
}
public void setSiafi(String siafi) {
this.siafi = siafi;
}

public void empty_end_c() {


id_end_c = 0L;
pais = "";
estado = "";
uf = "";
municipio = "";
bairro = "";
enderenco = "";
numero = "";
complemento = "";
cep = "";
logradouro = "";
unidade = "";
localidade = "";
regiao = "";
ibge = "";
gia = "";
ddd = "";
siafi = "";

}

}

