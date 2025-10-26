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

<!--  -->
<title>${h_titulo_web}</title>


<script type="text/javascript">
	// Formata CPF ou CNPJ automaticamente
	function formatCpfCnpj(valor) {
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
													href="<%=request.getContextPath()%>/lt_sis/?fun=cad_PRO">PRODUTO</a>
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
						class="col-12 col-md-5 mb-2 mb-md-0 align-self-center text-center">
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-2 mb-2 mb-md-0 align-items-center align-self-center ">
							<!-- coluna Direita -->
							<!-- FIM row -->
						</div>
						<!-- FIM row -->
						<!-- FIM Container -->
					</div>
					<!-- FIM Container -->
					<!-- final form -->
		</form>
		<!-- final form -->

		<form method="post"
			action="<%=request.getContextPath()%>/lt_sis_busc/" style=""
			onsubmit="return validardados()? true : false">
			<!--  -->
			<!-- Inicio Container -->
			<c:if test="${cons_false}">
				<div class="container mt-md-3">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div class="col-12  col-md-3 align-self-center align-items-center">
							<input class="form-control" list="listcnpj_cpf" name="cnpj_cpf"
								id="cnpj_cpf" maxlength="18"
								oninput="forCnpjCpf(this); cnpjlimparnome('cnpj_cpf', 'nome_desc'); valCnpjCpf(this)"
								value="${pre_glo.cnpj_cpf}" placeholder="CNPJ ou CPF">
							<datalist id="listcnpj_cpf">
								<c:forEach items="${sis_cons}" var="l_cnpj_cpf">
									<option><c:out value="${l_cnpj_cpf.cnpjCpf}"></c:out></option>
								</c:forEach>
							</datalist>
							<!-- Mensagem de erro -->
							<small id="erro_cnpj_cpf" class="text-danger d-none">dado
								inválido</small>
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12 col-md-1 mb-2 mb-md-0 align-self-center text-center">
							<h5>
								<a>ou</a>
							</h5>
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-8 mb-2 mb-md-0 align-self-center text-center">

							<div class="row align-items-center text-center text-md-left">
								<div
									class="col-12 col-md-10 mb-2 mb-md-0 align-self-center text-center">
									<input class="form-control" list="list_nome_desc"
										name="nome_desc" id="nome_desc"
										oninput="cnpjlimparnome('nome_desc', 'cnpj_cpf')"
										value="${pre_glo.nome_desc}" placeholder="Nome">
									<datalist id="list_nome_desc">
										<c:forEach items="${sis_cons}" var="l_cnpj_cpf">
											<option><c:out value="${l_cnpj_cpf.nomeDesc}"></c:out></option>
										</c:forEach>
									</datalist>
								</div>
								<div
									class="col-12 col-md-2 mb-2 mb-md-0 align-self-center text-center">
									<a href="<%=request.getContextPath()%>/lt_sis_busc/?fun=Buscar">
										<button type="button" class="btn btn-info">Buscar</button>
									</a>
								</div>
							</div>
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
							class="col-4 col-md-4 mb-2 mb-md-0 align-self-center text-center"">
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


			<hr>


			<!--  -->
			<!-- Inicio Container -->
			<c:if test="${cons_false}">
				<div class="container mt-md-3">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div class="col-12  col-md-3 align-self-center align-items-center">
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
						<!-- coluna Central -->
						<div
							class="col-12 col-md-1 mb-2 mb-md-0 align-self-center text-center">
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-8 mb-2 mb-md-0 align-self-center text-center">

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
				el.style.height = el.scrollHeight + 'px';
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