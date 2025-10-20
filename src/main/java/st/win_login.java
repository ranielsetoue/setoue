
package st;

import java.io.Serializable;
import java.sql.Date;

public class win_login implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id_sis;
	private Long reg_id;
	private Date reg_data;
	private Long reg_alt;
	private Date reg_data_alt;
	private Long win_login_id;
	private String pag_inicial = "/index.jsp";
	private String Web_publ = "/index.jsp";
	private String Win1 = "tb_sis_log";
	private String Win2;
	private String C1l = "l_usu";
	private String C2l = "l_sen";
	private String C3l;
	private String C4l;
	private String C5l;
	private String Tx1;
	private String Tx2;
	private String Tx3;
	private String Tx4;
	private String Tx5;
	private String Col1;
	private String Col2;
	private String Col3;
	private String Col4;
	private String Col5;

	public boolean nv_id() {
		if (this.win_login_id == null || this.win_login_id == 0L) {
			return true;

		} else if (this.win_login_id != null || this.win_login_id != 0L || this.win_login_id > 0l) {
			return false;
		}
		return win_login_id == null || win_login_id == 0L;
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

	public Long getWin_login_id() {
		return win_login_id;
	}

	public void setWin_login_id(Long win_login_id) {
		this.win_login_id = win_login_id;
	}

	public String getPag_inicial() {
		return pag_inicial;
	}

	public void setPag_inicial(String pag_inicial) {
		this.pag_inicial = pag_inicial;
	}

	public String getWeb_publ() {
		return Web_publ;
	}

	public void setWeb_publ(String Web_publ) {
		this.Web_publ = Web_publ;
	}

	public String getWin1() {
		return Win1;
	}

	public void setWin1(String Win1) {
		this.Win1 = Win1;
	}

	public String getWin2() {
		return Win2;
	}

	public void setWin2(String Win2) {
		this.Win2 = Win2;
	}

	public String getC1l() {
		return C1l;
	}

	public void setC1l(String C1l) {
		this.C1l = C1l;
	}

	public String getC2l() {
		return C2l;
	}

	public void setC2l(String C2l) {
		this.C2l = C2l;
	}

	public String getC3l() {
		return C3l;
	}

	public void setC3l(String C3l) {
		this.C3l = C3l;
	}

	public String getC4l() {
		return C4l;
	}

	public void setC4l(String C4l) {
		this.C4l = C4l;
	}

	public String getC5l() {
		return C5l;
	}

	public void setC5l(String C5l) {
		this.C5l = C5l;
	}

	public String getTx1() {
		return Tx1;
	}

	public void setTx1(String Tx1) {
		this.Tx1 = Tx1;
	}

	public String getTx2() {
		return Tx2;
	}

	public void setTx2(String Tx2) {
		this.Tx2 = Tx2;
	}

	public String getTx3() {
		return Tx3;
	}

	public void setTx3(String Tx3) {
		this.Tx3 = Tx3;
	}

	public String getTx4() {
		return Tx4;
	}

	public void setTx4(String Tx4) {
		this.Tx4 = Tx4;
	}

	public String getTx5() {
		return Tx5;
	}

	public void setTx5(String Tx5) {
		this.Tx5 = Tx5;
	}

	public String getCol1() {
		return Col1;
	}

	public void setCol1(String Col1) {
		this.Col1 = Col1;
	}

	public String getCol2() {
		return Col2;
	}

	public void setCol2(String Col2) {
		this.Col2 = Col2;
	}

	public String getCol3() {
		return Col3;
	}

	public void setCol3(String Col3) {
		this.Col3 = Col3;
	}

	public String getCol4() {
		return Col4;
	}

	public void setCol4(String Col4) {
		this.Col4 = Col4;
	}

	public String getCol5() {
		return Col5;
	}

	public void setCol5(String Col5) {
		this.Col5 = Col5;
	}

	public void vz_id() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		win_login_id = 0L;
		pag_inicial = "";
		Web_publ = "";
		Win1 = "";
		Win2 = "";
		C1l = "";
		C2l = "";
		C3l = "";
		C4l = "";
		C5l = "";
		Tx1 = "";
		Tx2 = "";
		Tx3 = "";
		Tx4 = "";
		Tx5 = "";
		Col1 = "";
		Col2 = "";
		Col3 = "";
		Col4 = "";
		Col5 = "";

	}

	public void vz_con() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		win_login_id = 0L;
		pag_inicial = "";
		Web_publ = "";
		Win1 = "";
		Win2 = "";
		C1l = "";
		C2l = "";
		C3l = "";
		C4l = "";
		C5l = "";
		Tx1 = "";
		Tx2 = "";
		Tx3 = "";
		Tx4 = "";
		Tx5 = "";
		Col1 = "";
		Col2 = "";
		Col3 = "";
		Col4 = "";
		Col5 = "";

	}

	public void vz_gr() {

		id_sis = 0L;
		reg_id = 0L;
		reg_data = null;
		reg_alt = 0L;
		reg_data_alt = null;
		win_login_id = 0L;
		pag_inicial = "";
		Web_publ = "";
		Win1 = "";
		Win2 = "";
		C1l = "";
		C2l = "";
		C3l = "";
		C4l = "";
		C5l = "";
		Tx1 = "";
		Tx2 = "";
		Tx3 = "";
		Tx4 = "";
		Tx5 = "";
		Col1 = "";
		Col2 = "";
		Col3 = "";
		Col4 = "";
		Col5 = "";

	}

}
