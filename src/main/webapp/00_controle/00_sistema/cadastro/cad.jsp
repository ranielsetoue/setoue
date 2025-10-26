<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="pt-br">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<!--  -->
<link rel="shortcut icon"
	href="<%=request.getContextPath()%>/desenho/logo.png"
	type="imagem/x-icon">
<!--  -->
<c:set scope="session" var="aces_cad_sis"
	value='<%=request.getSession().getAttribute("aces_cad_sis").toString()%>'></c:set>

<c:set scope="session" var="aces_cad_clin"
	value='<%=request.getSession().getAttribute("aces_cad_clin").toString()%>'></c:set>

<c:set scope="session" var="aces_cad_forn"
	value='<%=request.getSession().getAttribute("aces_cad_forn").toString()%>'></c:set>

<c:set scope="session" var="aces_cad_prod"
	value='<%=request.getSession().getAttribute("aces_cad_prod").toString()%>'></c:set>
<c:set scope="session" var="aces_cad_serv"
	value='<%=request.getSession().getAttribute("aces_cad_serv").toString()%>'></c:set>

<c:set scope="session" var="cons_true"
	value='<%=request.getSession().getAttribute("cons_true").toString()%>'></c:set>

<c:set scope="session" var="cons_false"
	value='<%=request.getSession().getAttribute("cons_false").toString()%>'></c:set>

<!--  -->
<title>${h_titulo_web}</title>


<script type="text/javascript">
// Formata CPF ou CNPJ automaticamente
function formatCpfCnpj(valor) {
    let numeros = valor.replace(/\D/g, '');
    if (numeros.length <= 11) { // CPF
        numeros = numeros.replace(/(\d{3})(\d)/, '$1.$2')
                         .replace(/(\d{3})(\d)/, '$1.$2')
                         .replace(/(\d{3})(\d{1,2})$/, '$1-$2');
    } else { // CNPJ
        numeros = numeros.replace(/^(\d{2})(\d)/, '$1.$2')
                         .replace(/^(\d{2}\.\d{3})(\d)/, '$1.$2')
                         .replace(/\.(\d{3})(\d)/, '.$1/$2')
                         .replace(/(\d{4})(\d{1,2})$/, '$1-$2');
    }
    return numeros;
}

// Valida CPF (simplificado)
function isValidCPF(cpf) {
    cpf = cpf.replace(/\D/g, '');
    if (cpf.length !== 11 || /^(\d)\1+$/.test(cpf)) return false;
    let sum = 0, rest;
    for (let i = 1; i <= 9; i++) sum += parseInt(cpf.substring(i-1, i)) * (11-i);
    rest = (sum * 10) % 11;
    if (rest === 10 || rest === 11) rest = 0;
    if (rest !== parseInt(cpf.substring(9, 10))) return false;
    sum = 0;
    for (let i = 1; i <= 10; i++) sum += parseInt(cpf.substring(i-1, i)) * (12-i);
    rest = (sum * 10) % 11;
    if (rest === 10 || rest === 11) rest = 0;
    if (rest !== parseInt(cpf.substring(10, 11))) return false;
    return true;
}

// Valida CNPJ (simplificado)
function isValidCNPJ(cnpj) {
    cnpj = cnpj.replace(/\D/g, '');
    if (cnpj.length !== 14) return false;
    if (/^(\d)\1+$/.test(cnpj)) return false;
    let tamanho = cnpj.length - 2;
    let numeros = cnpj.substring(0, tamanho);
    let digitos = cnpj.substring(tamanho);
    let soma = 0, pos = tamanho - 7;
    for (let i = tamanho; i >= 1; i--) {
        soma += numeros.charAt(tamanho - i) * pos--;
        if (pos < 2) pos = 9;
    }
    let resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    if (resultado != digitos.charAt(0)) return false;
    tamanho = tamanho + 1;
    numeros = cnpj.substring(0, tamanho);
    soma = 0;
    pos = tamanho - 7;
    for (let i = tamanho; i >= 1; i--) {
        soma += numeros.charAt(tamanho - i) * pos--;
        if (pos < 2) pos = 9;
    }
    resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    if (resultado != digitos.charAt(1)) return false;
    return true;
}

// Valida e formata input
function handleBusca(input) {
    let valor = input.value.trim();

    // Se inicia com letra, não mostra erro
    if (/^[a-zA-Z]/.test(valor)) {
        document.getElementById('erro_busca').classList.add('d-none');
        input.classList.remove('border-danger');
        return;
    }

    // Formata CPF/CNPJ automaticamente
    if (/^\d/.test(valor)) {
        input.value = formatCpfCnpj(valor);
    }

    // Valida CPF/CNPJ
    let valido = true;
    let numeros = valor.replace(/\D/g, '');
    if (numeros.length === 11) {
        valido = isValidCPF(valor);
    } else if (numeros.length === 14) {
        valido = isValidCNPJ(valor);
    } else if (/^\d/.test(valor)) {
        valido = false;
    }

    let erro = document.getElementById('erro_busca');
    if (!valido) {
        erro.classList.remove('d-none');
        input.classList.add('border-danger');
    } else {
        erro.classList.add('d-none');
        input.classList.remove('border-danger');
    }
}

// Função placeholder para nome (se tiver alguma função extra)
function valBusnome() {
    // Pode colocar aqui validações adicionais de nome se precisar
}
</script>


<!--  -->
</head>
<body>

	<!-- ----- inicio body -->
	<!--  -->
	<!-- Borda -->
	<div class="container-fluid	 mt-3 px-4">
		<!-- Borda -->
		<!-- inicio form -->
		<form method="post" action="<%=request.getContextPath()%>/lt_sis_log/"
			style="" onsubmit="return validardados()? true : false">
			<!-- inicio form -->
			<!--  -->
			<!-- Inicio Container -->
			<div class="container">
				<!-- Inicio Container -->
				<!-- Inicio row -->
				<div class="row align-items-center text-center text-md-left">
					<!-- Inicio row -->
					<!-- coluna esquerda -->
					<div class="col-12  col-md-2 align-self-center align-items-center">
						<img height="200" width="400"
							src="<%=request.getContextPath()%>/desenho/logo.png"
							alt="product" class="img-fluid">
					</div>
					<!-- coluna esquerda -->
					<!-- coluna Central -->
					<div
						class="col-12 col-md-7 mb-2 mb-md-0 align-self-center text-center">
						<c:choose>
							<c:when test="${empty h_titulo_pagina}">
								<h3>SET DEV</h3>
							</c:when>
							<c:otherwise>
								<h3>${h_titulo_pagina}</h3>
							</c:otherwise>
						</c:choose>
					</div>
					<!-- coluna Central -->
					<!-- coluna Direita -->
					<div
						class="col-12 col-md-3 d-flex justify-content-center justify-content-md-end align-items-center">
						<!-- 						<table style="display: none;"> -->
						<table>

							<tr>
								<td class="pl-2"><a>Usuario: </a> <c:if
										test="${not empty sessionScope.usu_html}">
                            ${sessionScope.usu_html}
                        </c:if></td>
								<td><a
									href="<%=request.getContextPath()%>/lt_sis_log/?f_out_log=f_out_log">
										<button type="button" class="btn btn-warning">logout</button>
								</a></td>
							</tr>
						</table>
					</div>
					<!-- coluna Direita -->
					<!-- FIM row -->
				</div>
				<!-- FIM row -->
				<!-- FIM Container -->
			</div>
			<!-- FIM Container -->
			<!--  -->


			<!--  -->
			<!-- Inicio Container -->
			<div class="container mt-3">
				<!-- Inicio Container -->
				<!-- Inicio row -->
				<div class="row align-items-center text-center text-md-left">
					<!-- Inicio row -->
					<!-- coluna esquerda -->
					<div
						class="col-12 col-md-5 mb-2 mb-md-0 align-self-start align-items-start text-start text-md-start text-center">
						<table class="mx-auto mx-md-0">
							<tr>
								<td><a
									href="<%=request.getContextPath()%>/lt_sis/?fun=ini_cont">
										<button type="button" class="btn btn-primary">Pagina
											Inicial</button>
								</a></td>
								<td>
									<div class="btn-group" role="group">
										<button id="btnGroupDrop1" type="button"
											class="btn btn-primary dropdown-toggle"
											data-toggle="dropdown" aria-haspopup="true"
											aria-expanded="false">Cadastro</button>
										<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
											<c:if test="${aces_cad_sis}">
												<a class="dropdown-item"
													href="<%=request.getContextPath()%>/lt_sis/?fun=cad_sis">SISTEMA</a>
											</c:if>
											<c:if test="${aces_cad_clin}">
												<a class="dropdown-item"
													href="<%=request.getContextPath()%>/lt_sis/?fun=cad_cli">CLIENTE</a>
											</c:if>
											<c:if test="${aces_cad_forn}">
												<a class="dropdown-item"
													href="<%=request.getContextPath()%>/lt_sis/?fun=cad_for">FORNECEDOR</a>
											</c:if>
											<c:if test="${aces_cad_prod}">
												<a class="dropdown-item"
													href="<%=request.getContextPath()%>/lt_sis/?fun=cad_pro">PRODUTO</a>
											</c:if>
											<c:if test="${aces_cad_serv}">
												<a class="dropdown-item"
													href="<%=request.getContextPath()%>/lt_sis/?fun=cad_serv">SERVICO</a>
											</c:if>
										</div>
									</div>
								</td>
							</tr>
						</table>
					</div>
					<!-- coluna esquerda -->
					<!-- coluna Central -->
					<div
						class="col-12 col-md-7 mb-2 mb-md-0 align-self-center text-center">
					</div>
					<!-- coluna Central -->
					<!-- coluna Direita -->
					<div
						class="col-12 col-md-3 d-flex justify-content-center justify-content-md-end align-items-center">
					</div>
					<!-- coluna Direita -->
					<!-- FIM row -->
				</div>
				<!-- FIM row -->
				<!-- FIM Container -->
			</div>
			<!-- FIM Container -->
			<!--  -->
			<!-- final form -->
		</form>
		<!-- final form -->

		<form method="post"
			action="<%=request.getContextPath()%>/lt_sis_busc/"
			onsubmit="return validardados()? true : false">

			<!-- Inicio Container -->
			<c:if test="${cons_false}">
				<div class="container mt-md-3">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div class="col-12 col-md-10 mb-2 mb-md-0 align-self-center text-center">
							<input class="form-control" list="list_cnpj_cpf" name="cnpj_cpf"
								id="cnpj_cpf" maxlength="18"
								oninput="handleBusca(this); valBusnome()"
								value="${pre_glo.cnpj_cpf != null ? pre_glo.cnpj_cpf : pre_glo.nome_desc}"
								placeholder="CNPJ, CPF ou Nome">

							<datalist id="list_cnpj_cpf">
								<c:forEach items="${sis_cons}" var="l_cnpj_cpf">
									<option value="${l_cnpj_cpf.cnpjCpf}">${l_cnpj_cpf.nomeDesc}</option>
								</c:forEach>
							</datalist>

							<!-- Mensagem de erro -->
							<small id="erro_busca" class="text-danger d-none">Dado
								inválido</small>


						</div>
						<!-- coluna esquerda -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-2 mb-2 mb-md-0 align-self-center text-center">

									<a href="<%=request.getContextPath()%>/lt_sis_busc/?fun=Buscar">
										<button type="button" class="btn btn-info">Buscar</button>
									</a>
						</div>
						<!-- coluna Direita -->
						<!-- FIM row -->
					</div>
					<!-- FIM row -->
					<!-- FIM Container -->
				</div>
			</c:if>
			<!-- FIM Container -->
			<!--  -->




			<!--  -->
			<!-- Inicio Container -->
			<c:if test="${cons_true}">
				<div class="container mt-3" id="html_true">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-4 col-md-4 mb-2 mb-md-0 align-self-center text-center">
							<a href="<%=request.getContextPath()%>/lt_sis_busc/?fun=novo">
								<button type="button" class="btn btn-info">NOVO</button>
							</a>
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-4 col-md-4 mb-2 mb-md-0 align-self-center text-center">
							<a href="<%=request.getContextPath()%>/lt_sis_busc/?fun=Buscar">
								<button type="button" class="btn btn-success">SALVAR</button>
							</a>
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-4 col-md-4 mb-2 mb-md-0 align-self-center text-center">
							<a href="<%=request.getContextPath()%>/lt_sis_busc/?fun=Buscar">
								<button type="button" class="btn btn-danger">EXCLUIR</button>
							</a>
						</div>
						<!-- coluna Direita -->
						<!-- FIM row -->
					</div>
					<!-- FIM row -->
					<!-- FIM Container -->
				</div>
			</c:if>
			<!-- FIM Container -->
			<!--  -->
			<!--  -->
			<!-- Inicio Container -->
			<c:if test="${cons_true}">
				<div class="container mt-3">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12 col-md-3 mb-2 mb-0 align-self-center align-items-center">
							<label id="l_cnpj_cpf" data-placeholder="CNPJ ou CPF"
								class="me-2"></label> <input class="form-control"
								list="listcnpj_cpf" name="cnpj_cpf" id="cnpj_cpf" maxlength="18"
								oninput="forCnpjCpf(this); valCnpjCpf(this)"
								value="${pre_glo.cnpj_cpf}" placeholder="CNPJ ou CPF">
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div id="div_nome_desc"
							class="col-12  col-md-9 mb-2 mb-0 align-self-center align-items-center">
							<label id="l_nome_desc" data-placeholder="Nome" class="me-2"></label>

							<textarea class="form-control" autocomplete="off"
								name="nome_desc" id="nome_desc" placeholder="Nome" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_glo.nome_desc}</textarea>

						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-12 mb-2 mb-0 align-self-center text-center">
							<label id="l_nome_fantasia" data-placeholder="Nome Fantasia"
								class="me-2"></label> <input class="form-control" type="text"
								name="nome_fantasia" id="nome_fantasia" autocomplete="off"
								value="${pre_glo.nome_fantasia}" placeholder="Nome Fantasia">
						</div>
						<!-- coluna Direita -->
						<!-- FIM row -->
					</div>
					<!-- FIM row -->
					<!-- FIM Container -->
				</div>
			</c:if>
			<!-- FIM Container -->
			<!--  -->

			<!--  -->
			<!-- Inicio Container -->
			<c:if test="${cons_true}">
				<div class="container">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12 col-md-6 mb-2 mb-0 align-self-center text-center">

							<label id="l_inscricao_estatual"
								data-placeholder="Inscricao Estatual" class="me-2"></label> <input
								type="text" name="inscricao_estatual" id="inscricao_estatual"
								autocomplete="off" value="${sis_tel.inscricao_estatual}"
								class="form-control" placeholder="Inscricao Estatual">
						</div>
						<!-- coluna esquerda -->

						<!-- coluna Direita -->
						<div class="col-12 col-md-6 mb-2 mb-0 align-self-end text-end ">
							<label id="l_inscricao_municipal"
								data-placeholder="Inscricao Municipal" class="me-2"></label> <input
								type="text" name="inscricao_municipal" id="inscricao_municipal"
								autocomplete="off" value="${sis_tel.inscricao_municipal}"
								class="form-control" placeholder="Inscricao Municipal">
						</div>
						<!-- coluna Direita -->
						<!-- FIM row -->
					</div>
					<!-- FIM row -->
					<!-- FIM Container -->
				</div>
			</c:if>
			<!-- FIM Container -->
			<!--  -->
			<!--  -->
			<!-- Inicio Container -->
			<c:if test="${cons_true}">
				<div class="container">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12 col-md-12 mb-2 mb-0 align-self-center text-center">
							<label id="l_endereco" data-placeholder="Enderenco" class="me-2"></label>

							<input type="text" name="endereco" id="endereco"
								autocomplete="off" value="${sis_tel.endereco}"
								class="form-control" placeholder="Enderenco">
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12 col-md-3 mb-2 mb-0 align-self-center text-center">
							<label id="l_numero" data-placeholder="Numero" class="me-2"></label>

							<input type="text" name="numero" id="numero" autocomplete="off"
								value="${sis_tel.numero}" class="form-control"
								placeholder="Numero">
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-9 mb-2 mb-0 align-self-center text-center">
							<label id="l_complemento" data-placeholder="Complemento"
								class="me-2"></label> <input type="text" name="complemento"
								id="complemento" autocomplete="off"
								value="${sis_tel.complemento}" class="form-control"
								placeholder="Complemento">
						</div>
						<!-- coluna Direita -->
						<!-- FIM row -->
					</div>
					<!-- FIM row -->
					<!-- FIM Container -->
				</div>
			</c:if>
			<!-- FIM Container -->
			<!--  -->
			<!--  -->
			<!-- Inicio Container -->
			<c:if test="${cons_true}">
				<div class="container">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12 col-md-6 mb-2 mb-0 align-self-center text-center">
							<label id="l_bairro" data-placeholder="Bairro" class="me-2"></label>

							<input type="text" name="bairro" id="bairro" autocomplete="off"
								value="${sis_tel.bairro}" class="form-control"
								placeholder="Bairro">
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12 col-md-6 mb-2 mb-0 align-self-center text-center">
							<label id="l_municipio" data-placeholder="Municipio" class="me-2"></label>

							<input type="text" name="municipio" id="municipio"
								autocomplete="off" value="${sis_tel.municipio}"
								class="form-control" placeholder="Municipio">
						</div>
						<!-- coluna Central -->
						<!-- FIM row -->
					</div>
					<!-- FIM row -->
					<!-- FIM Container -->
				</div>
			</c:if>
			<!-- FIM Container -->
			<!--  -->

			<!--  -->
			<!-- Inicio Container -->
			<c:if test="${cons_true}">
				<div class="container">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12 col-md-1 mb-2 mb-0 align-self-center text-center">
							<label id="l_estado" data-placeholder="UF" class="me-2"></label>
							<input type="text" maxlength="2" name="estado" id="estado"
								autocomplete="off" value="${sis_tel.estado}"
								class="form-control" placeholder="UF">
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12 col-md-2 mb-2 mb-0 align-self-center text-center">
							<label id="l_cep" data-placeholder="CEP" class="me-2"></label> <input
								onblur="CEPPESQ();" type="text" maxlength="10" name="cep"
								id="cep" autocomplete="off" value="${sis_tel.cep}"
								class="form-control" placeholder="CEP">
							<script>
function toggleLabel(inputId, labelId) {
    const input = document.getElementById(inputId);
    const label = document.getElementById(labelId);

    if (!input.value.trim()) {
        label.style.display = 'none';
    } else {
        label.style.display = 'inline';
        label.textContent = label.dataset.placeholder;
    }
}

function initLabels() {
    const inputs = document.querySelectorAll('input[placeholder], textarea[placeholder]');
    inputs.forEach(input => {
        const labelId = 'l_' + input.id; // label deve ter id = l_ + input id
        const label = document.getElementById(labelId);
        if (label) {
            toggleLabel(input.id, labelId);
            input.addEventListener('input', () => toggleLabel(input.id, labelId));
            input.addEventListener('blur', () => toggleLabel(input.id, labelId));
        }
    });
}

document.addEventListener('DOMContentLoaded', initLabels);

</script>

						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div id="col-obs"
							class="col-12 col-md-9 mb-2 mb-0 align-self-center text-center">
							<label id="l_observacao" data-placeholder="Observação"
								class="me-2"></label>

							<textarea name="observacao" id="observacao" class="form-control"
								placeholder="Observação" autocomplete="off" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${sis_tel.observacao}</textarea>
						</div>
						<!-- coluna Direita -->
						<!-- FIM row -->
					</div>
					<!-- FIM row -->
					<!-- FIM Container -->
				</div>
			</c:if>
			<!-- FIM Container -->
			<!--  -->

			<!--  -->
			<!-- Inicio Container -->
			<c:if test="${cons_true}">
				<div class="container">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12 col-md-4 mb-2 mb-0 align-self-center text-center">
							<!--  -->
							<label id="l_truefalse" data-placeholder="ACESSO ADMINISTRATOR"
								class="me-2"></label> <input list="listADMTRUEFALSE"
								name="truefalse" id="truefalse" onfocus="this.value=''"
								type="text" autocomplete="off" value="${sis_tel.truefalse}"
								class="form-control" placeholder="ACESSO ADMINISTRATOR">
							<datalist id="listADMTRUEFALSE">
								<option value="TRUE">
								<option value="FALSE">
							</datalist>

							<script>
								document
										.getElementById("truefalse")
										.addEventListener(
												"change",
												function() {
													const valor = this.value
															.toUpperCase();
													if (valor !== "TRUE"
															&& valor !== "FALSE"
															&& valor !== " ") {
														alert("Por favor, selecione apenas TRUE ou FALSE.");
														this.value = ""; // limpa o campo
													}
												});
							</script>

							<!--  -->
						</div>

						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12 col-md-4 mb-2 mb-0 align-self-center text-center">
							<label id="l_permissao" data-placeholder="Tipo de Permissao"
								class="me-2"></label> <input class="form-control"
								list="list_tipo_ace" type="text" name="permissao" id="permissao"
								onfocus="this.value=''" autocomplete="off"
								value="${sis_tel.permissao}" placeholder="Tipo de Permissao">
							<datalist id="list_tipo_ace">
								<c:forEach items="${sis_list_tipo_ace}" var="l_tipo_ace">
									<option><c:out value="${l_tipo_ace.tpnomeDesc}"></c:out></option>
								</c:forEach>
							</datalist>

						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-4 mb-2 mb-0 align-self-center text-center">
						</div>
						<!-- coluna Direita -->
						<!-- FIM row -->
					</div>
					<!-- FIM row -->
					<!-- FIM Container -->
				</div>
			</c:if>
			<!-- FIM Container -->
			<!--  -->

			<!-- final form -->
		</form>
		<!-- final form -->
		<!-- Campo de entrada -->
		<!--  -->
		<!-- Borda -->
	</div>
	<!-- Borda -->

	<script type="text/javascript">
								function adjustHeight(el) {
									el.style.height = 'auto'; // reset height
									const lineHeight = 24; // ajuste conforme seu CSS do textarea
									const maxLines = 3;
									const maxHeight = lineHeight * maxLines;

									if (el.scrollHeight > maxHeight) {
										el.style.height = maxHeight + 'px';
										el.style.overflowY = 'auto'; // aparece scroll após 3 linhas
									} else {
										el.style.height = el.scrollHeight
												+ 'px';
										el.style.overflowY = 'hidden';
									}
								}
							</script>


	<!--  -->
	<!-- ---- fim body-->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
		integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
		integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
		integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

</body>
</html>