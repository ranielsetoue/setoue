package cla;

import java.io.Serializable;

public class cla_list_cnpj_nome implements Serializable {

	private static final long serialVersionUID = 1L;

	private String cnpjCpf;
	private String nomeDesc;

	public cla_list_cnpj_nome(String cnpjCpf, String nomeDesc) {
        this.cnpjCpf = cnpjCpf;
        this.nomeDesc = nomeDesc;
    }
	// TODO Auto-generated constructor stub
	public String getCnpjCpf() {
		return cnpjCpf;
	}

	public void setCnpjCpf(String cnpjCpf) {
		this.cnpjCpf = cnpjCpf;
	}

	public String getNomeDesc() {
		return nomeDesc;
	}

	public void setNomeDesc(String nomeDesc) {
		this.nomeDesc = nomeDesc;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
