package cla;

import java.io.Serializable;
import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class cla_cnpj implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id_cnpj;
	private String status;
	private String ultima_atualizacao;
	private String cnpj;
	private String tipo;
	private String porte;
	private String nome;
	private String fantasia;
	private String abertura;
	ArrayList<cl_atividade> atividade_principal = new ArrayList<cl_atividade>();
	ArrayList<cl_atividade> atividades_secundarias = new ArrayList<cl_atividade>();
	private String natureza_juridica;
	private String logradouro;
	private String numero;
	private String complemento;
	private String cep;
	private String bairro;
	private String municipio;
	private String uf;
	private String email;
	private String telefone;
	private String efr;
	private String situacao;
	private String data_situacao;
	private String motivo_situacao;
	private String situacao_especial;
	private String data_situacao_especial;
	private String capital_social;
	ArrayList<cl_qsa> qsa = new ArrayList<cl_qsa>();
	Simples SimplesObject;
	Simei SimeiObject;
	Billing BillingObject;

	// Getter Methods

	public String getStatus() {
		return status;
	}

	public String getUltima_atualizacao() {
		return ultima_atualizacao;
	}

	public String getCnpj() {
		return cnpj;
	}

	public String getTipo() {
		return tipo;
	}

	public String getPorte() {
		return porte;
	}

	public String getNome() {
		return nome;
	}

	public String getFantasia() {
		return fantasia;
	}

	public String getAbertura() {
		return abertura;
	}

	public String getNatureza_juridica() {
		return natureza_juridica;
	}

	public String getLogradouro() {
		return logradouro;
	}

	public String getNumero() {
		return numero;
	}

	public String getComplemento() {
		return complemento;
	}

	public String getCep() {
		return cep;
	}

	public String getBairro() {
		return bairro;
	}

	public String getMunicipio() {
		return municipio;
	}

	public String getUf() {
		return uf;
	}

	public String getEmail() {
		return email;
	}

	public String getTelefone() {
		return telefone;
	}

	public String getEfr() {
		return efr;
	}

	public String getSituacao() {
		return situacao;
	}

	public String getData_situacao() {
		return data_situacao;
	}

	public String getMotivo_situacao() {
		return motivo_situacao;
	}

	public String getSituacao_especial() {
		return situacao_especial;
	}

	public String getData_situacao_especial() {
		return data_situacao_especial;
	}

	public String getCapital_social() {
		return capital_social;
	}

	public Simples getSimples() {
		return SimplesObject;
	}

	public Simei getSimei() {
		return SimeiObject;
	}

	public Billing getBilling() {
		return BillingObject;
	}

	// Setter Methods

	public void setStatus(String status) {
		this.status = status;
	}

	public void setUltima_atualizacao(String ultima_atualizacao) {
		this.ultima_atualizacao = ultima_atualizacao;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public void setPorte(String porte) {
		this.porte = porte;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public void setFantasia(String fantasia) {
		this.fantasia = fantasia;
	}

	public void setAbertura(String abertura) {
		this.abertura = abertura;
	}

	public void setNatureza_juridica(String natureza_juridica) {
		this.natureza_juridica = natureza_juridica;
	}

	public void setLogradouro(String logradouro) {
		this.logradouro = logradouro;
	}

	public void setNumero(String numero) {
		this.numero = numero;
	}

	public void setComplemento(String complemento) {
		this.complemento = complemento;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}

	public void setBairro(String bairro) {
		this.bairro = bairro;
	}

	public void setMunicipio(String municipio) {
		this.municipio = municipio;
	}

	public void setUf(String uf) {
		this.uf = uf;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public void setEfr(String efr) {
		this.efr = efr;
	}

	public void setSituacao(String situacao) {
		this.situacao = situacao;
	}

	public void setData_situacao(String data_situacao) {
		this.data_situacao = data_situacao;
	}

	public void setMotivo_situacao(String motivo_situacao) {
		this.motivo_situacao = motivo_situacao;
	}

	public void setSituacao_especial(String situacao_especial) {
		this.situacao_especial = situacao_especial;
	}

	public void setData_situacao_especial(String data_situacao_especial) {
		this.data_situacao_especial = data_situacao_especial;
	}

	public void setCapital_social(String capital_social) {
		this.capital_social = capital_social;
	}

	public void setSimples(Simples simplesObject) {
		this.SimplesObject = simplesObject;
	}

	public void setSimei(Simei simeiObject) {
		this.SimeiObject = simeiObject;
	}

	public void setBilling(Billing billingObject) {
		this.BillingObject = billingObject;
	}

	/**
	 * @return the id_cnpj
	 */
	public Long getId_cnpj() {
		return id_cnpj;
	}

	/**
	 * @param id_cnpj the id_cnpj to set
	 */
	public void setId_cnpj(Long id_cnpj) {
		this.id_cnpj = id_cnpj;
	}

	public class cl_qsa {

		private String nome;
		private String qual;
		private String pais_origem;
		private String nome_rep_legal;
		private String qual_rep_legal;

		public String getNome() {
			return nome;
		}

		public void setNome(String nome) {
			this.nome = nome;
		}

		public String getQual() {
			return qual;
		}

		public void setQual(String qual) {
			this.qual = qual;
		}

		public String getPais_origem() {
			return pais_origem;
		}

		public void setPais_origem(String pais_origem) {
			this.pais_origem = pais_origem;
		}

		public String getNome_rep_legal() {
			return nome_rep_legal;
		}

		public void setNome_rep_legal(String nome_rep_legal) {
			this.nome_rep_legal = nome_rep_legal;
		}

		public String getQual_rep_legal() {
			return qual_rep_legal;
		}

		public void setQual_rep_legal(String qual_rep_legal) {
			this.qual_rep_legal = qual_rep_legal;
		}

	}

	public class cl_atividade {
		private String code;
		private String text;

		public String getCode() {
			return code;
		}

		public void setCode(String code) {
			this.code = code;
		}

		public String getText() {
			return text;
		}

		public void setText(String text) {
			this.text = text;
		}

	}

	public class Billing {
		private boolean free;
		private boolean database;

		// Getter Methods

		public boolean getFree() {
			return free;
		}

		public boolean getDatabase() {
			return database;
		}

		// Setter Methods

		public void setFree(boolean free) {
			this.free = free;
		}

		public void setDatabase(boolean database) {
			this.database = database;
		}
	}

	public class Simei {
		private boolean optante;
		private String data_opcao;
		private String data_exclusao;
		private String ultima_atualizacao;

		// Getter Methods

		public boolean getOptante() {
			return optante;
		}

		public String getData_opcao() {
			return data_opcao;
		}

		public String getData_exclusao() {
			return data_exclusao;
		}

		public String getUltima_atualizacao() {
			return ultima_atualizacao;
		}

		// Setter Methods

		public void setOptante(boolean optante) {
			this.optante = optante;
		}

		public void setData_opcao(String data_opcao) {
			this.data_opcao = data_opcao;
		}

		public void setData_exclusao(String data_exclusao) {
			this.data_exclusao = data_exclusao;
		}

		public void setUltima_atualizacao(String ultima_atualizacao) {
			this.ultima_atualizacao = ultima_atualizacao;
		}
	}

	public class Simples {
		private boolean optante;
		private String data_opcao;
		private String data_exclusao;
		private String ultima_atualizacao;

		// Getter Methods

		public boolean getOptante() {
			return optante;
		}

		public String getData_opcao() {
			return data_opcao;
		}

		public String getData_exclusao() {
			return data_exclusao;
		}

		public String getUltima_atualizacao() {
			return ultima_atualizacao;
		}

		// Setter Methods

		public void setOptante(boolean optante) {
			this.optante = optante;
		}

		public void setData_opcao(String data_opcao) {
			this.data_opcao = data_opcao;
		}

		public void setData_exclusao(String data_exclusao) {
			this.data_exclusao = data_exclusao;
		}

		public void setUltima_atualizacao(String ultima_atualizacao) {
			this.ultima_atualizacao = ultima_atualizacao;
		}
	}

}
