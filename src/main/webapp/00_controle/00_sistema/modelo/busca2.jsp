<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<title>Busca de Sistemas</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<script type="text/javascript">

	function forCpfCnpj(valor) {
		let numeros = valor.replace(/\D/g, '');
		if (numeros.length <= 11) { // CPF
			numeros = numeros.replace(/(\d{3})(\d)/, '$1.$2').replace(
					/(\d{3})(\d)/, '$1.$2').replace(/(\d{3})(\d{1,2})$/,
					'$1-$2');
		} else { // CNPJ
			numeros = numeros.replace(/^(\d{2})(\d)/, '$1.$2').replace(
					/^(\d{2}\.\d{3})(\d)/, '$1.$2').replace(/\.(\d{3})(\d)/,
					'.$1/$2').replace(/(\d{4})(\d{1,2})$/, '$1-$2');
		}
		return numeros;
	}

	// Valida CPF (simplificado)
	function isValidCPF(cpf) {
		cpf = cpf.replace(/\D/g, '');
		if (cpf.length !== 11 || /^(\d)\1+$/.test(cpf))
			return false;
		let sum = 0, rest;
		for (let i = 1; i <= 9; i++)
			sum += parseInt(cpf.substring(i - 1, i)) * (11 - i);
		rest = (sum * 10) % 11;
		if (rest === 10 || rest === 11)
			rest = 0;
		if (rest !== parseInt(cpf.substring(9, 10)))
			return false;
		sum = 0;
		for (let i = 1; i <= 10; i++)
			sum += parseInt(cpf.substring(i - 1, i)) * (12 - i);
		rest = (sum * 10) % 11;
		if (rest === 10 || rest === 11)
			rest = 0;
		if (rest !== parseInt(cpf.substring(10, 11)))
			return false;
		return true;
	}

	// Valida CNPJ (simplificado)
	function isValidCNPJ(cnpj) {
		cnpj = cnpj.replace(/\D/g, '');
		if (cnpj.length !== 14)
			return false;
		if (/^(\d)\1+$/.test(cnpj))
			return false;
		let tamanho = cnpj.length - 2;
		let numeros = cnpj.substring(0, tamanho);
		let digitos = cnpj.substring(tamanho);
		let soma = 0, pos = tamanho - 7;
		for (let i = tamanho; i >= 1; i--) {
			soma += numeros.charAt(tamanho - i) * pos--;
			if (pos < 2)
				pos = 9;
		}
		let resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
		if (resultado != digitos.charAt(0))
			return false;
		tamanho = tamanho + 1;
		numeros = cnpj.substring(0, tamanho);
		soma = 0;
		pos = tamanho - 7;
		for (let i = tamanho; i >= 1; i--) {
			soma += numeros.charAt(tamanho - i) * pos--;
			if (pos < 2)
				pos = 9;
		}
		resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
		if (resultado != digitos.charAt(1))
			return false;
		return true;
	}
	</script>

</head>
<body>

	<!-- Formulário de login -->
	<form id="formLogin" method="post"
		action="<%=request.getContextPath()%>/lt_sis_log/"
		onsubmit="return validardadosLogin()">
		<div class="container-fluid mt-3 px-4">
			<div class="container">
				<div class="row align-items-center text-center text-md-left">

					<!-- Coluna esquerda: logo -->
					<div class="col-12 col-md-2 align-self-center">
						<img height="200" width="400"
							src="<%=request.getContextPath()%>/desenho/logo.png" alt="Logo"
							class="img-fluid">
					</div>

					<!-- Coluna central: título -->
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

					<!-- Coluna direita: usuário e logout -->
					<div
						class="col-12 col-md-3 d-flex justify-content-center justify-content-md-end align-items-center">
						<table>
							<tr>
								<td class="pl-2"><a>Usuario: </a> <c:if
										test="${not empty sessionScope.usu_html}">
                                    ${sessionScope.usu_html}
                                </c:if></td>
								<td><a
									href="<%=request.getContextPath()%>/lt_sis_log/?f_out_log=f_out_log">
										<button type="button" class="btn btn-warning">Logout</button>
								</a></td>
							</tr>
						</table>
					</div>
				</div>
			</div>

		</div>
	</form>

	<!-- Formulário de busca -->
	<div class="container mt-4">
		<h2>Busca de Sistemas</h2>

		<form id="formBusca" method="post"
			action="<%=request.getContextPath()%>/lt_dev/" class="mb-3">
			<input type="hidden" name="fun" id="fun" value="" /> <label
				for="termo" class="form-label">Digite o nome, CPF/CNPJ ou
				ID:</label> <input type="text" name="termo" id="termo" class="form-control"
				value="${param.termo}" placeholder="Ex: Raniel Assis Setoue">

			<button type="button" class="btn btn-primary mt-2"
				onclick="enviarForm('buscar_dado')">Buscar</button>
		</form>

		<hr />

		<!-- Resultados -->
		<c:if test="${not empty listaResultados}">
			<h4>Resultados encontrados: ${fn:length(listaResultados)}</h4>
			<table class="table table-bordered table-striped">
				<thead>
					<tr>
						<th>Nome</th>
						<th>CPF/CNPJ</th>
						<th>Nome Fantasia</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${listaResultados}">
						<tr>
							<td>${item.nome_desc}</td>
							<td>${item.cnpj_cpf}</td>
							<td>${item.no_fan}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>

		<c:if test="${empty listaResultados}">
			<div class="alert alert-warning">Nenhum registro encontrado.</div>
		</c:if>
	</div>


	<!--  Inico Dado Selecionado -->
	<form id="fon_cad" method="post"
		action="<%=request.getContextPath()%>/lt_sis_busc/"
		onsubmit="return validardados()? true : false">
		<input type="hidden" name="fun" id="fun" value="" />
		<!-- Inicio Container -->
		<div class="container mt-md-3">
			<!--  -->
			<!-- Inicio Container -->
			<div class="container mt-3">
				<!-- Inicio Container -->
				<!-- Inicio row -->
				<div class="row align-items-center text-center text-md-left">
					<!-- Inicio row -->
					<!-- coluna esquerda -->
					<div
						class="col-12 col-md-3 mb-2 mb-0 align-self-center align-items-center">
						<label id="l_cnpj_cpf" data-placeholder="CNPJ ou CPF" class="me-2"></label>
						<input class="form-control" name="cnpj_cpf" id="cnpj_cpf"
							maxlength="18" oninput="forCpfCnpj(this);"
							value="${pre_glo.cnpj_cpf}" placeholder="CNPJ ou CPF">
					</div>
					<!-- coluna esquerda -->
					<!-- coluna Central -->
					<div id="div_nome_desc"
						class="col-12  col-md-9 mb-2 mb-0 align-self-center align-items-center">
						<label id="l_nome_desc" data-placeholder="Nome" class="me-2"></label>

						<textarea class="form-control" autocomplete="off" name="nome_desc"
							id="nome_desc" placeholder="Nome" rows="1"
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
			<!-- FIM Container -->
			<!--  -->

			<!--  -->
			<!-- Inicio Container -->
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
			<!-- FIM Container -->
			<!--  -->
			<!--  -->
			<!-- Inicio Container -->
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
			<!-- FIM Container -->
			<!--  -->
			<!--  -->
			<!-- Inicio Container -->
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
			<!-- FIM Container -->
			<!--  -->

			<!--  -->
			<!-- Inicio Container -->
			<div class="container">
				<!-- Inicio Container -->
				<!-- Inicio row -->
				<div class="row align-items-center text-center text-md-left">
					<!-- Inicio row -->
					<!-- coluna esquerda -->
					<div
						class="col-12 col-md-1 mb-2 mb-0 align-self-center text-center">
						<label id="l_estado" data-placeholder="UF" class="me-2"></label> <input
							type="text" maxlength="2" name="estado" id="estado"
							autocomplete="off" value="${sis_tel.estado}" class="form-control"
							placeholder="UF">
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
			<!-- FIM Container -->
			<!--  -->

			<!--  -->
			<!-- Inicio Container -->
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
			<!-- FIM Container -->
			<!--  -->
		</div>


		<!-- final form -->
	</form>
	<!-- final form -->
	<!-- Fim Dado Selecionado -->




	<script type="text/javascript">
    function enviarForm(funcao) {
        if (!validardados()) return false; // chama sua validação
        document.getElementById('fun').value = funcao; // define o parâmetro fun
        document.getElementById('formBusca').submit(); // envia o formulário
    }

    function validardados() {
        // exemplo de validação simples
        var termo = document.getElementById('termo').value.trim();
        if (termo === "") {
            alert("Digite algum valor para buscar.");
            return false;
        }
        return true;
    }

    function validardadosLogin() {
        var login = document.getElementById('l_usu').value.trim();
        var senha = document.getElementById('l_sen').value.trim();
        if (login === "" || senha === "") {
            alert("Preencha usuário e senha.");
            return false;
        }
        return true;
    }
</script>
</body>
</html>
