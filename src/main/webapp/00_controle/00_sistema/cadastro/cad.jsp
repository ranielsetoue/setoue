<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html lang="pt-br">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<!--  -->
<link rel="shortcut icon"
	href="<%=request.getContextPath()%>/desenho/logo.png"
	type="imagem/x-icon">
<!--  -->
<c:set scope="session" var="aces_cad_sis"
	value="${sessionScope.aces_cad_sis}" />
<c:set scope="session" var="aces_cad_clin"
	value="${sessionScope.aces_cad_clin}" />
<c:set scope="session" var="aces_cad_forn"
	value="${sessionScope.aces_cad_forn}" />
<c:set scope="session" var="aces_cad_prod"
	value="${sessionScope.aces_cad_prod}" />
<c:set scope="session" var="aces_cad_serv"
	value="${sessionScope.aces_cad_serv}" />
<c:set scope="session" var="cons_true" value="${sessionScope.cons_true}" />
<c:set scope="session" var="cons_false"
	value="${sessionScope.cons_false}" />
<c:set scope="session" var="aces_desv" value="${sessionScope.aces_desv}" />
<c:set scope="session" var="cons_list" value="${sessionScope.cons_list}" />
<c:set scope="session" var="cons_list_dado"
	value="${sessionScope.cons_list_dado}" />
<c:set scope="session" var="cons_list_not"
	value="${sessionScope.cons_list_not}" />


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

	function sis_busc() {
		var tx_bus = document.getElementById('bus_cnpj_cpf').value.trim();
		if (tx_bus === "") {
			alert("Preencher para pode Consultar");
			return false;
		} else {
			document.getElementById('fun').value = "buscar";
			document.getElementById('fon_cad').submit();

		}
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
								<td>
									<button type="button" class="btn btn-warning"
										onclick="window.location.href='<%=request.getContextPath()%>/lt_sis_log/?f_out_log=f_out_log';">
										logout</button>
								</td>
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
			<!--  -->
			<!-- final form -->
		</form>
		<!-- final form -->

		<form id="fon_cad" method="post"
			action="<%=request.getContextPath()%>/lt_sis_busc/"
			onsubmit="return validardados()? true : false">
			<input type="hidden" name="fun" id="fun" value="" />
			<!-- Inicio Container -->
			<c:if test="${cons_false}">
				<div class="container mt-md-3">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12 col-md-10 mb-2 mb-md-0 align-self-center text-center">
							<input class="form-control" list="list_cnpj_cpf"
								name="bus_cnpj_cpf" id="bus_cnpj_cpf" maxlength="18"
								oninput="handleBusca(this); valBusnome();"
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
							<button type="button" class="btn btn-info" onclick="sis_busc();">Buscar</button>
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
							<button type="button" class="btn btn-info"
								onclick="window.location.href='<%=request.getContextPath()%>/lt_sis_busc/?fun=novo';">
								NOVO</button>
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-4 col-md-4 mb-2 mb-md-0 align-self-center text-center">

							<button type="button" class="btn btn-success"
								onclick="window.location.href='<%=request.getContextPath()%>/lt_sis_busc/?fun=salvar';">
								SALVAR</button>

						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-4 col-md-4 mb-2 mb-md-0 align-self-center text-center">
							<button type="button" class="btn btn-danger"
								onclick="window.location.href='<%=request.getContextPath()%>/lt_sis_busc/?fun=excluir';">
								EXCLUIR</button>
						</div>
						<!-- coluna Direita -->
						<!-- FIM row -->
					</div>
					<!-- FIM row -->
					<!-- FIM Container -->
				</div>
			</c:if>
			<!-- FIM Container -->


			<!-- inicio lista  dado-->
			<c:if test="${cons_true}">

				<!-- lista -->
				<c:if test="${cons_list}">

					<!--  -->
					<!-- Inicio Container -->
					<c:if test="${not cons_list_dado}">

						<div class="container mt-3">

							<!-- Inicio Container -->
							<hr>
							<!-- Inicio row -->
							<div class="row align-items-center text-center text-md-left">
								<!-- Inicio row -->
								<!-- coluna Central -->
								<div
									class="col-12 col-md-12 mb-2 mb-0 align-self-center text-center">
									<!-- Inicio Resultado -->
									<!-- - -->


									<!-- ------ -->
									<!-- ====== RESULTADOS DA BUSCA ====== -->
									<hr />

									<div class="container mt-3" id="container_tabela">

										<c:if test="${not empty listaResultados}">
											<table id="tab1_result"
												class="table table-bordered table-striped text-center">
												<thead>
													<tr>
														<th>CPF/CNPJ</th>
														<th>Nome</th>
														<th>Nome Fantasia</th>
														<th>Selecionar</th>
													</tr>
												</thead>
												<tbody id="tab1-corpo">
													<c:forEach var="item" items="${listaResultados}">
														<tr>
															<td>${item.cnpj_cpf}</td>
															<td>${item.nome_desc}</td>
															<td>${item.no_fan}</td>
															<td>
																<button type="button" class="btn btn-warning"
																	onclick="sel_clin(this);"
																	data-cnpjcpf="${item.cnpj_cpf}"
																	data-nome="${item.nome_desc}"
																	data-fantasia="${item.no_fan}"
																	data-endereco="${item.end_rua}"
																	data-numero="${item.end_num}"
																	data-complemento="${item.end_com}"
																	data-bairro="${item.end_bar}"
																	data-municipio="${item.end_mun}"
																	data-estado="${item.end_uf}" data-cep="${item.end_cep}"
																	data-observacao="${item.obs}"
																	data-truefalse="${item.truefalse}"
																	data-permissao="${item.tipo_ace}">SEL</button>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
											<div class="container mt-3">
												<div class="row align-items-center text-center text-md-left">
													<div
														class="col-12 col-md-12 mb-2 mb-0 align-self-center text-center">
														<div id="paginacao"
															class="d-flex justify-content-center mt-2"></div>

													</div>
												</div>
											</div>
										</c:if>
									</div>

									<!-- Inicio Dado -->
									<!-- CAMPOS PRINCIPAIS -->

									<div class="container mt-3" id="cont1" style="display: none;">

										<div class="row g-2">
											<div class="col-md-4">
												<label id="l_cnpj_cpf" data-placeholder="CNPJ/CPF">CNPJ/CPF</label>
												<input id="cnpj_cpf" name="cnpj_cpf" class="form-control"
													placeholder="CNPJ ou CPF">
											</div>

											<div class="col-md-4">
												<label id="l_nome_desc" data-placeholder="Nome/Razão Social">Nome/Razão</label>
												<input id="nome_desc" name="nome_desc" class="form-control"
													placeholder="Nome ou Razão Social">
											</div>

											<div class="col-md-4">
												<label id="l_no_fan" data-placeholder="Nome Fantasia">Nome
													Fantasia</label> <input id="no_fan" name="no_fan"
													class="form-control" placeholder="Nome Fantasia">
											</div>
										</div>

										<div class="row g-2 mt-2">
											<div class="col-md-6">
												<label id="l_end_rua" data-placeholder="Endereço">Endereço</label>
												<input id="end_rua" name="end_rua" class="form-control"
													placeholder="Endereço">
											</div>
											<div class="col-md-2">
												<label id="l_end_num" data-placeholder="Número">Número</label>
												<input id="end_num" name="end_num" class="form-control"
													placeholder="Número">
											</div>
											<div class="col-md-4">
												<label id="l_end_com" data-placeholder="Complemento">Complemento</label>
												<input id="end_com" name="end_com" class="form-control"
													placeholder="Complemento">
											</div>
										</div>

										<div class="row g-2 mt-2">
											<div class="col-md-3">
												<label id="l_end_bar" data-placeholder="Bairro">Bairro</label>
												<input id="end_bar" name="end_bar" class="form-control"
													placeholder="Bairro">
											</div>
											<div class="col-md-3">
												<label id="l_end_mun" data-placeholder="Município">Município</label>
												<input id="end_mun" name="end_mun" class="form-control"
													placeholder="Município">
											</div>
											<div class="col-md-2">
												<label id="l_end_uf" data-placeholder="UF">UF</label> <input
													id="end_uf" name="end_uf" class="form-control"
													maxlength="2" placeholder="UF">
											</div>
											<div class="col-md-4">
												<label id="l_end_cep" data-placeholder="CEP">CEP</label> <input
													id="end_cep" name="end_cep" class="form-control"
													placeholder="CEP">
											</div>
										</div>

										<div class="row g-2 mt-2">
											<div class="col-md-6">
												<label id="l_obs" data-placeholder="Observações">Observações</label>
												<textarea id="obs" name="obs" class="form-control"
													placeholder="Observações"></textarea>
											</div>
											<div class="col-md-3">
												<label id="l_truefalse" data-placeholder="Ativo">Ativo</label>
												<input id="truefalse" name="truefalse" class="form-control"
													placeholder="Ativo ou Inativo">
											</div>
											<div class="col-md-3">
												<label id="l_tipo_ace" data-placeholder="Permissão">Permissão</label>
												<input id="tipo_ace" name="tipo_ace" class="form-control"
													placeholder="Permissão">
											</div>
										</div>
									</div>


									<!-- FIM Dado -->
									<!-- - -->
									<!--  Fim Resultado -->
								</div>
								<!-- coluna Central -->
								<!-- FIM row -->
							</div>
							<!-- FIM row -->
							<hr>
							<!-- FIM Container -->
						</div>
					</c:if>
					<!-- FIM Container -->

					<!-- fim lista dado -->
				</c:if>
				<!--  -->

				<!-- inicio unico -->

				<!--  -->
				<!-- Inicio Container -->
				<c:if test="${cons_list_dado}">


					<div class="container mt-3">
						<!-- Inicio Container -->
						<hr>
						<!-- Inicio row -->
						<div class="row align-items-center text-center text-md-left">
							<!-- Inicio row -->
							<!-- coluna esquerda -->
							<div
								class="col-12 col-md-4 mb-2 mb-0 align-self-center text-center">

							</div>
							<!-- coluna esquerda -->
							<!-- coluna Central -->
							<div
								class="col-12 col-md-4 mb-2 mb-0 align-self-center text-center">

								<c:if test="${cons_list_not}">
									<h2>Realiza Cadastro</h2>
								</c:if>
								<h2>unico</h2>
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
						<hr>
						<!-- FIM Container -->
					</div>
				</c:if>
			</c:if>

			<!-- FIM Container -->
			<!--  -->
			<!-- fim unico -->


			<!-- fim lista -->

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
	<!-- - -->
	<!-- ====== SCRIPT PRINCIPAL ====== -->
	<script type="text/javascript">
// Função principal: seleciona cliente
function sel_clin(botao) {
    if (!botao) return;

    const campos = {
        cnpjcpf: "cnpj_cpf",
        nome: "nome_desc",
        fantasia: "no_fan",
        endereco: "end_rua",
        numero: "end_num",
        complemento: "end_com",
        bairro: "end_bar",
        municipio: "end_mun",
        estado: "end_uf",
        cep: "end_cep",
        observacao: "obs",
        truefalse: "truefalse",
        permissao: "tipo_ace"
    };

    for (const key in campos) {
        const input = document.getElementById(campos[key]);
        if (input) input.value = botao.getAttribute("data-" + key) || "";
    }

    // Oculta apenas a tabela de resultados
    const tabelaContainer = document.getElementById("container_tabela");
    if (tabelaContainer) {
        tabelaContainer.style.transition = "opacity 0.4s ease";
        tabelaContainer.style.opacity = "0";

        setTimeout(() => {
            tabelaContainer.style.display = "none";
        }, 400);
    }

 // MOSTRA formulário cont1
    const formulario = document.getElementById("cont1");
    if (formulario) {
        formulario.style.display = "block";
        formulario.style.opacity = "0";
        formulario.style.transition = "opacity 0.4s ease";
        setTimeout(() => formulario.style.opacity = "1", 50);
    }
    highlightForm();
    initLabels();

    const form = document.getElementById("fon_cad");
    if (form) form.scrollIntoView({ behavior: "smooth" });
}

// Efeito visual de destaque ao preencher
function highlightForm() {
	const form = document.getElementById("fon_cad");
	form.style.transition = "box-shadow 0.6s ease";
	form.style.boxShadow = "0 0 15px 3px gold";
	setTimeout(() => form.style.boxShadow = "none", 1200);
}
	
// ====== LIMPAR CAMPOS AO ENTRAR NO CAMPO DE BUSCA ======
function limparFormularioCadastro() {
	const inputs = document.querySelectorAll('#fon_cad input, #fon_cad textarea');
	inputs.forEach(input => input.value = '');
	initLabels();

	
	// Se quiser que a tabela reapareça limpa:
	const tabela = document.querySelector("table.table");
	if (tabela) {
		tabela.style.display = "none";
		const tbody = tabela.querySelector("tbody");
		if (tbody) tbody.innerHTML = "";
	}

	// Oculta também a paginação
	const paginacao = document.getElementById('paginacao');
	if (paginacao) paginacao.style.display = 'none';

	
}

// Detecta quando o usuário clica ou digita no campo de busca
document.addEventListener('DOMContentLoaded', () => {
	const campoBusca = document.getElementById('termo');
	if (campoBusca) {
		campoBusca.addEventListener('focus', limparFormularioCadastro);
		campoBusca.addEventListener('input', limparFormularioCadastro);
	}
	initLabels();
});

// Labels dinâmicos
function toggleLabel(inputId, labelId) {
	const input = document.getElementById(inputId);
	const label = document.getElementById(labelId);
	if (!input || !label) return;
	if (!input.value.trim()) {
		label.style.display = 'none';
	} else {
		label.style.display = 'inline';
		label.textContent = label.dataset.placeholder;
	}
}
function initLabels() {
	document.querySelectorAll('input[placeholder], textarea[placeholder]').forEach(input => {
		const labelId = 'l_' + input.id;
		const label = document.getElementById(labelId);
		if (label) {
			toggleLabel(input.id, labelId);
			input.addEventListener('input', () => toggleLabel(input.id, labelId));
			input.addEventListener('blur', () => toggleLabel(input.id, labelId));
		}
	});
}

// Validação e envio do formulário de busca
function enviarForm(funcao) {
	if (!validardados()) return false;
	document.getElementById('fun').value = funcao;
	document.getElementById('formBusca').submit();
}
function validardados() {
	const termo = document.getElementById('termo').value.trim();
	if (termo === "") {
		alert("Digite algum valor para buscar.");
		return false;
	}
	return true;
}

function limparFormulario() {
    // Limpa campos do formulário de dados
    const campos = [
        'cnpj_cpf', 'nome_desc', 'no_fan',
        'end_rua', 'end_num', 'end_com',
        'end_bar', 'end_mun', 'end_uf', 'end_cep',
        'obs', 'truefalse', 'tipo_ace','termo'
    ];
    campos.forEach(id => {
        const input = document.getElementById(id);
        if(input) input.value = '';
    });

    // Oculta a tabela de resultados antiga
    const tabela = document.querySelector('table.table');
    if(tabela) tabela.style.display = 'none';
 // Oculta também a paginação
    const paginacao = document.getElementById('paginacao');
    if (paginacao) paginacao.style.display = 'none';

}

//Paginação avançada com contador, animação e teclas de atalho
function paginarTabela(tabelaId, linhasPorPagina = 20) {
    const tabela = document.getElementById(tabelaId);
    if (!tabela) return;

    const tbody = tabela.querySelector('tbody');
    const linhas = Array.from(tbody.querySelectorAll('tr'));
    const totalPaginas = Math.ceil(linhas.length / linhasPorPagina);
    let paginaAtual = 1;
    let animando = false;

    // Cria container de paginação se não existir
    let container = document.getElementById('paginacao');
    if (!container) {
        container = document.createElement('div');
        container.id = 'paginacao';
        container.className = 'd-flex justify-content-between align-items-center mt-3';
        tabela.parentNode.appendChild(container);
    }

    // Área de botões (esquerda)
    const divBotoes = document.createElement('div');
    divBotoes.className = 'd-flex align-items-center';
    container.appendChild(divBotoes);

    // Área de contador (direita)
    const contador = document.createElement('div');
    contador.className = 'text-muted small me-2';
    container.appendChild(contador);

    function mostrarPagina(pagina) {
        if (animando) return;
        paginaAtual = Math.max(1, Math.min(pagina, totalPaginas));

        const inicio = (paginaAtual - 1) * linhasPorPagina;
        const fim = inicio + linhasPorPagina;

        animando = true;
        tbody.style.transition = 'opacity 0.3s ease';
        tbody.style.opacity = '0';

        setTimeout(() => {
            linhas.forEach((linha, i) => {
                linha.style.display = i >= inicio && i < fim ? '' : 'none';
            });
            tbody.style.opacity = '1';
            setTimeout(() => (animando = false), 300);
        }, 300);

        renderPaginacao();
    }

    function renderPaginacao() {
        divBotoes.innerHTML = '';
        contador.textContent = ` `;

        if (totalPaginas <= 1) return;

        const grupoMaximo = 3;
        let inicioGrupo = Math.max(1, paginaAtual - Math.floor(grupoMaximo / 2));
        let fimGrupo = inicioGrupo + grupoMaximo - 1;

        if (fimGrupo > totalPaginas) {
            fimGrupo = totalPaginas;
            inicioGrupo = Math.max(1, fimGrupo - grupoMaximo + 1);
        }

        // Botão "Anterior"
        const btnAnterior = document.createElement('button');
        btnAnterior.textContent = 'Anterior';
        btnAnterior.className = 'btn btn-sm mx-1 btn-outline-primary';
        btnAnterior.disabled = paginaAtual === 1;
        btnAnterior.addEventListener('click', () => mostrarPagina(paginaAtual - 1));
        divBotoes.appendChild(btnAnterior);

        // Reticências no início
        if (inicioGrupo > 1) {
            const ellipsisInicio = document.createElement('span');
            ellipsisInicio.textContent = '...';
            ellipsisInicio.className = 'mx-1 align-self-center';
            divBotoes.appendChild(ellipsisInicio);
        }

        // Botões de páginas
        for (let i = inicioGrupo; i <= fimGrupo; i++) {
            const btn = document.createElement('button');
            btn.textContent = i;
            btn.className =
                'btn btn-sm mx-1 ' + (i === paginaAtual ? 'btn-primary' : 'btn-outline-primary');
            btn.addEventListener('click', () => mostrarPagina(i));
            divBotoes.appendChild(btn);
        }

        // Reticências no final
        if (fimGrupo < totalPaginas) {
            const ellipsisFim = document.createElement('span');
            ellipsisFim.textContent = '...';
            ellipsisFim.className = 'mx-1 align-self-center';
            divBotoes.appendChild(ellipsisFim);
        }

        // Botão "Próximo"
        const btnProximo = document.createElement('button');
        btnProximo.textContent = 'Próximo';
        btnProximo.className = 'btn btn-sm mx-1 btn-outline-primary';
        btnProximo.disabled = paginaAtual === totalPaginas;
        btnProximo.addEventListener('click', () => mostrarPagina(paginaAtual + 1));
        divBotoes.appendChild(btnProximo);
    }

    // Atalhos ← e →
    document.addEventListener('keydown', (event) => {
        const isInputActive =
            document.activeElement.tagName === 'INPUT' ||
            document.activeElement.tagName === 'TEXTAREA';
        if (isInputActive || animando) return;

        if (event.key === 'ArrowLeft' && paginaAtual > 1) {
            mostrarPagina(paginaAtual - 1);
        } else if (event.key === 'ArrowRight' && paginaAtual < totalPaginas) {
            mostrarPagina(paginaAtual + 1);
        }
    });

    mostrarPagina(1);
}

</script>

	<script>
window.onload = () => paginarTabela('tab1_result', 2);
</script>

</body>

</html>