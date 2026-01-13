package cla;

import java.io.Serializable;

public class cla_list_tipo_ace implements Serializable {

	private static final long serialVersionUID = 1L;

	private String nomeDesc;

	public cla_list_tipo_ace(String nomeDesc) {
        this.nomeDesc = nomeDesc;
    }
	// TODO Auto-generated constructor stub


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
