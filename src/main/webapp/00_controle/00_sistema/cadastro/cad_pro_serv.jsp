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
	// Limpa o outro campo quando o atual for preenchido

	function cnpjlimparnome(campoAtual, campoOutro) {
		const atual = document.getElementById(campoAtual);
		const outro = document.getElementById(campoOutro);

		// Se o usuário digitar algo no campo atual, limpa o outro
		if (atual.value.trim() !== "") {
			outro.value = "";
		}

	}

	//Atualiza estado do botão Buscar
	function atualizarBotaoBuscar() {
		const cnpjCpfInput = document.getElementById('cnpj_cpf');
		const nomeDescInput = document.getElementById('nome_desc');
		const valor = cnpjCpfInput.value.replace(/\D/g, '');
		let valido = false;

		if (valor.length === 11)
			valido = validarCPF(valor);
		else if (valor.length === 14)
			valido = validarCNPJ(valor);
		else if (nomeDescInput.value.trim() !== "")
			valido = true;

	}
	// Função que formata CPF ou CNPJ automaticamente
	function forCnpjCpf(input) {
		let valor = input.value.replace(/\D/g, ''); // remove tudo que não for número

		if (valor.length <= 11) {
			// CPF -> 000.000.000-00
			valor = valor.replace(/(\d{3})(\d)/, "$1.$2");
			valor = valor.replace(/(\d{3})(\d)/, "$1.$2");
			valor = valor.replace(/(\d{3})(\d{1,2})$/, "$1-$2");
		} else {
			// CNPJ -> 00.000.000/0000-00
			valor = valor.replace(/^(\d{2})(\d)/, "$1.$2");
			valor = valor.replace(/^(\d{2})\.(\d{3})(\d)/, "$1.$2.$3");
			valor = valor.replace(/\.(\d{3})(\d)/, ".$1/$2");
			valor = valor.replace(/(\d{4})(\d)/, "$1-$2");
		}

		input.value = valor;
	}
	// Valida CPF ou CNPJ em tempo real
	function valCnpjCpf(input) {
		const valor = input.value.replace(/\D/g, '');
		const msgErro = document.getElementById('erro_cnpj_cpf');
		let valido = false;

		if (valor.length === 11) {
			valido = validarCPF(valor);
		} else if (valor.length === 14) {
			valido = validarCNPJ(valor);
		}

		if (valor.length > 0 && !valido) {
			input.style.borderColor = "red";
			msgErro.classList.remove("d-none");
			msgErro.textContent = valor.length <= 11 ? "dado inválido"
					: "dado inválido";
		} else {
			input.style.borderColor = "";
			msgErro.classList.add("d-none");
		}

	}

	// Validação real de CPF
	function validarCPF(cpf) {
		if (/^(\d)\1{10}$/.test(cpf))
			return false;
		let soma = 0;
		for (let i = 0; i < 9; i++)
			soma += parseInt(cpf.charAt(i)) * (10 - i);
		let resto = 11 - (soma % 11);
		if (resto >= 10)
			resto = 0;
		if (resto !== parseInt(cpf.charAt(9)))
			return false;
		soma = 0;
		for (let i = 0; i < 10; i++)
			soma += parseInt(cpf.charAt(i)) * (11 - i);
		resto = 11 - (soma % 11);
		if (resto >= 10)
			resto = 0;
		return resto === parseInt(cpf.charAt(10));
	}

	// Validação real de CNPJ
	function validarCNPJ(cnpj) {
		if (/^(\d)\1{13}$/.test(cnpj))
			return false;
		let tamanho = cnpj.length - 2;
		let numeros = cnpj.substring(0, tamanho);
		let digitos = cnpj.substring(tamanho);
		let soma = 0;
		let pos = tamanho - 7;
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
		return resultado == digitos.charAt(1);
	}
</script>
<!--  -->
</head>
<body>
	<!-- ----- inicio body -->
	<!-- inicio form -->
	<form method="post" action="<%=request.getContextPath()%>/lt_sis_log/"
		style="" onsubmit="return validardados()? true : false">
		<!-- Borda -->
		<div class="container-fluid	 mt-3 px-4">
			<!-- Borda -->
			<!-- coloca conteudo abaixo -->
			<!-- Inicio Container -->
			<div class="container">
				<!-- Inicio Container -->
				<div class="row align-items-center text-center text-md-left">
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
				</div>
				<!-- FIM Container -->
			</div>
			<!-- FIM Container -->
			<!--  -->
			<!-- Inicio Container -->
			<div class="container mt-3">
				<div class="row align-items-center text-center text-md-left">
					<!-- coluna esquerda -->
					<div
						class="col-12  col-md-5 mb-2 mb-md-0 align-self-start align-items-start text-start">
						<!-- coluna esquerda -->
						<table>
							<tr>
								<td><a
									href="<%=request.getContextPath()%>/lt_sis/?fun=ini_cont">
										<button type="button" class="btn btn-primary">Pagina
											Inicial</button>
								</a></td>
								<td><div class="btn-group" role="group">
										<button id="btnGroupDrop1" type="button"
											class="btn btn-primary" data-toggle="dropdown"
											aria-haspopup="true" aria-expanded="false">Cadastro</button>
										<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">

											<c:if test="${aces_cad_sis}">
												<a class="dropdown-item"
													href="<%=request.getContextPath()%>/lt_sis/?fun=cad_sis">
													SISTEMA</a>
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
													href="<%=request.getContextPath()%>/lt_sis/?fun=cad_PRO">PRODUTO</a>
											</c:if>
											<c:if test="${aces_cad_serv}">
												<a class="dropdown-item"
													href="<%=request.getContextPath()%>/lt_sis/?fun=cad_serv">SERVICO</a>
											</c:if>
										</div>
									</div></td>
							</tr>
						</table>
						<!-- coluna esquerda -->
					</div>
					<!-- coluna esquerda -->

					<!-- coluna Central -->

					<div
						class="col-12 col-md-5 mb-2 mb-md-0 align-self-center text-center">


					</div>
					<!-- coluna Central -->

					<!-- coluna Direita -->
					<div
						class="col-12 col-md-2 mb-2 mb-md-0 align-items-center align-self-center ">
					</div>
					<!-- coluna Direita -->
				</div>
			</div>
			<!-- Fim Container -->
			<!--  -->


			<!--  -->
			<!-- Inicio Container -->
			<c:if test="${cons_false}">
				<div class="container mt-3">
					<hr>
					<div class="row align-items-center text-center text-md-left">
						<!-- coluna esquerda -->
						<div
							class="col-12  col-md-5 mb-2 mb-md-0 align-self-start align-items-start text-start">
							<!-- coluna esquerda -->

							<!-- coluna esquerda -->
						</div>
						<!-- coluna esquerda -->

						<!-- coluna Central -->

						<div
							class="col-12 col-md-5 mb-2 mb-md-0 align-self-center text-center">


						</div>
						<!-- coluna Central -->

						<!-- coluna Direita -->
						<div
							class="col-12 col-md-2 mb-2 mb-md-0 align-items-center align-self-center ">
						</div>
						<!-- coluna Direita -->
					</div>
				</div>
			</c:if>
			<!-- Fim Container -->
			<!--  -->
			<!--  -->
			<!-- Inicio Container -->
			<c:if test="${cons_true}">
				<div class="container mt-3">
					<hr>
					<div class="row align-items-center text-center text-md-left">
						<!-- coluna esquerda -->
						<div
							class="col-12  col-md-5 mb-2 mb-md-0 align-self-start align-items-start text-start">
							<!-- coluna esquerda -->

							<!-- coluna esquerda -->
						</div>
						<!-- coluna esquerda -->

						<!-- coluna Central -->

						<div
							class="col-12 col-md-5 mb-2 mb-md-0 align-self-center text-center">


						</div>
						<!-- coluna Central -->

						<!-- coluna Direita -->
						<div
							class="col-12 col-md-2 mb-2 mb-md-0 align-items-center align-self-center ">
						</div>
						<!-- coluna Direita -->
					</div>
				</div>
			</c:if>
			<!-- Fim Container -->
			<!--  -->

			<!-- Borda -->
		</div>
		<!-- Borda -->
	</form>
	<!-- fim form -->


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