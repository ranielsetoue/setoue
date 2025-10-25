package cla;

import java.io.Serializable;

public class cla_list_tipo_ace implements Serializable {

	private static final long serialVersionUID = 1L;

	private String tpnomeDesc;

	public cla_list_tipo_ace(String tpnomeDesc) {
        this.tpnomeDesc = tpnomeDesc;
	}

	public String getTpnomeDesc() {
		return tpnomeDesc;
	}

	public void setTpnomeDesc(String tpnomeDesc) {
		this.tpnomeDesc = tpnomeDesc;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
