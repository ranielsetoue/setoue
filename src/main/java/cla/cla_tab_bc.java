package cla;

import java.io.Serializable;
import java.sql.Timestamp;

public class cla_tab_bc implements Serializable  {


		private static final long serialVersionUID = 1L;

		private Long id_sis;
		private Long reg_id;
		private Timestamp reg_data;
		private Long reg_alt;
		private Timestamp reg_data_alt;
		private Long id_tab_bc;
		private String sequencia;
		private String tabela;
		private String cont_sis;
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
		public Long getId_tab_bc() {
			return id_tab_bc;
		}
		public void setId_tab_bc(Long id_tab_bc) {
			this.id_tab_bc = id_tab_bc;
		}
		public String getSequencia() {
			return sequencia;
		}
		public void setSequencia(String sequencia) {
			this.sequencia = sequencia;
		}
		public String getTabela() {
			return tabela;
		}
		public void setTabela(String tabela) {
			this.tabela = tabela;
		}
		public String getCont_sis() {
			return cont_sis;
		}
		public void setCont_sis(String cont_sis) {
			this.cont_sis = cont_sis;
		}
		public static long getSerialversionuid() {
			return serialVersionUID;
		}

		
		
		
		// TODO Auto-generated constructor stub
	}


