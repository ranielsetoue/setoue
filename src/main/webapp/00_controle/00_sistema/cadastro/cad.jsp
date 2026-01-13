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
<c:set scope="session" var="insc_ocult"
	value="${sessionScope.insc_ocult}" />

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
    let valor = input.value.replace(/\D/g, '');
    const botaoBusca = document.getElementById('buc_dado');
    const erro = document.getElementById('erro_busca');

    // Se começa com letra (nome), libera busca
    if (/^[a-zA-Z]/.test(input.value)) {
        erro.classList.add('d-none');
        input.classList.remove('border-danger');
        botaoBusca.disabled = false;
        return;
    }

    // Formatação
    if (valor.length <= 11) {
        input.value = formatCpf(valor);
    } else if (valor.length <= 14) {
        input.value = formatCnpj(valor);
    } else {
        valor = valor.slice(0, 14);
        input.value = formatCnpj(valor);
    }

    // Validação
    let valido = false;
    if (valor.length === 11) {
        valido = isValidCPF(valor);
    } else if (valor.length === 14) {
        valido = isValidCNPJ(valor);
    }

    if (!valido && valor.length > 0) {
        erro.classList.remove('d-none');
        input.classList.add('border-danger');
        botaoBusca.disabled = true;
    } else {
        erro.classList.add('d-none');
        input.classList.remove('border-danger');
        botaoBusca.disabled = false;
    }
}

// Funções de formatação
function formatCpf(valor) {
    valor = valor.replace(/\D/g, '');
    return valor.replace(/(\d{3})(\d{3})(\d{3})(\d{0,2})/, function(_, p1, p2, p3, p4) {
        return p1 + '.' + p2 + '.' + p3 + (p4 ? '-' + p4 : '');
    });
}

function formatCnpj(valor) {
    valor = valor.replace(/\D/g, '');
    return valor.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{0,2})/, function(_, p1, p2, p3, p4, p5) {
        return p1 + '.' + p2 + '.' + p3 + '/' + p4 + (p5 ? '-' + p5 : '');
    });
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


	
	function excluir_dado() {

		if (document.getElementById("cnpj_cpf").value == null
				|| document.getElementById("cnpj_cpf").value == '') {

		} else {

			if (confirm('Deseja realmente excluir os dados?')) {

				var urlAction = '<%=request.getContextPath()%>/lt_sis_excluir/?fun=excluir';
				var busc_cnpj_cpf = document.getElementById('cnpj_cpf').value;

				
				$.ajax({

					method : "get",
					url : urlAction,
					data : "busc_cnpj_cpf=" + busc_cnpj_cpf + '&fun=excluir',
					success : function(response) {

						alert('deletado');
						window.location.href='<%=request.getContextPath()%>/lt_sis_busc/?fun=novo';

					
					}

				}).fail(
						function(xhr, status, errorThrown) {
							alert('Erro ao deletar usuário por id: '
									+ xhr.responseText);
						});
			}
		}
	}
	
	
	function salvar_dado() {
		
		var urlAction = '<%=request.getContextPath()%>/lt_sis_salvar/?fun=salvar';

		$.ajax({

			type : "POST",
			url : urlAction,
			data : $("#fon_cad").serialize(),

			success : function(response) {

				alert('Dado Atualizado');

			}

		}).fail(function(xhr, status, errorThrown) {
			alert('Erro ao deletar usuário por id: ' + xhr.responseText);
		});

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
								name="bus_cnpj_cpf" id="bus_cnpj_cpf"
								oninput="handleBusca(this); valBusnome();"
								placeholder="CNPJ, CPF ou Nome">

							<datalist id="list_cnpj_cpf">
								<c:forEach items="${sis_cons}" var="l_cnpj_cpf">
									<option value="${l_cnpj_cpf.cnpjCpf}">${l_cnpj_cpf.nomeDesc}</option>
								</c:forEach>
							</datalist>
							<script>
								function controlarDatalist(input) {
									const datalist = document
											.getElementById('list_cnpj_cpf');

									// Se não tiver nada digitado, remove a associação com o datalist
									if (input.value.length === 0) {
										input.removeAttribute('list');
									} else {
										// Ao digitar a primeira letra, volta a associar

										input.setAttribute('list',
												'list_cnpj_cpf');
									}
								}
							</script>
							<!-- Mensagem de erro -->
							<small id="erro_busca" class="text-danger d-none">Dado
								inválido</small>


						</div>
						<!-- coluna esquerda -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-2 mb-2 mb-md-0 align-self-center text-center">
							<button id="buc_dado" type="button" class="btn btn-info"
								onclick="sis_busc();">Buscar</button>
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
								onclick="salvar_dado();">SALVAR</button>
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-4 col-md-4 mb-2 mb-md-0 align-self-center text-center">
							<button type="button" class="btn btn-danger"
								onclick="excluir_dado();">EXCLUIR</button>
						</div>
						<!-- coluna Direita -->
						<!-- FIM row -->
					</div>
					<!-- FIM row -->
					<!-- FIM Container -->
					<hr>
				</div>
			</c:if>
			<!-- FIM Container -->

			<!-- INICIO DADO -->
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
							<label id="l_cnpj_cpf" data-placeholder="CNPJ ou CPF"></label> <input
								class="form-control" list="listcnpj_cpf" name="cnpj_cpf"
								id="cnpj_cpf" maxlength="18" oninput="handleBusca(this);"
								placeholder="CNPJ ou CPF" value="${pre_glo.cnpj_cpf}">
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div id="div_nome_desc"
							class="col-12  col-md-9 mb-2 mb-0 align-self-center align-items-center">
							<label id="l_nome_desc" data-placeholder="Nome ou Razao Social"></label>
							<textarea class="form-control" autocomplete="off"
								name="nome_desc" id="nome_desc"
								placeholder="Nome ou Razao Social" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_glo.nome_desc}</textarea>
							<script>
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
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-12 mb-2 mb-0 align-self-center text-center">
							<label id="l_no_fan" data-placeholder="Nome Fantasia"></label>
							<textarea class="form-control" name="no_fan" id="no_fan"
								autocomplete="off" placeholder="Nome Fantasia" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_glo.no_fan}</textarea>

						</div>
						<!-- coluna Direita -->
						<!-- FIM row -->
					</div>
					<!-- FIM row -->
					<!-- FIM Container -->
				</div>
				<!-- FIM Container -->

				<!--  -->
				<!-- Inicio Container -->

				<div class="container mt-3 ${!insc_ocult ? 'd-none' : ''}">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12 col-md-6 mb-2 mb-0 align-self-center text-center">

							<label id="l_ins_est" data-placeholder="Inscricao Estatual"></label>
							<input type="text" name="ins_est" id="ins_est" autocomplete="off"
								class="form-control" placeholder="Inscricao Estatual"
								value="${pre_glo.ins_est}">

						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div class="col-12 col-md-6 mb-2 mb-0 align-self-end text-end ">

							<label id="l_ins_mun" data-placeholder="Inscricao Municipal"></label>
							<input type="text" name="ins_mun" id="ins_mun" autocomplete="off"
								class="form-control" placeholder="Inscricao Municipal"
								value="${pre_glo.ins_mun}">

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
				<div class="container mt-1">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12 col-md-12 mb-2 mb-0 align-self-center text-center">
							<label id="l_end_rua" data-placeholder="Enderenco"></label>
							<textarea name="end_rua" id="end_rua" autocomplete="off"
								class="form-control" placeholder="Enderenco" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_glo.end_rua}</textarea>
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12 col-md-3 mb-2 mb-0 align-self-center text-center">
							<label id="l_end_num" data-placeholder="Número"></label> <input
								id="end_num" name="end_num" class="form-control"
								placeholder="Número" value="${pre_glo.end_num}">
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-9 mb-2 mb-0 align-self-center text-center">
							<label id="l_end_com" data-placeholder="Complemento"></label>
							<textarea name="end_com" id="end_com" autocomplete="off"
								class="form-control" placeholder="Complemento" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_glo.end_com}</textarea>
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
				<div class="container mt-1">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12 col-md-1 mb-2 mb-0 align-self-center text-center">
							<label id="l_end_uf" data-placeholder="UF"></label> <input
								type="text" maxlength="2" name="end_uf" id="end_uf"
								autocomplete="off" class="form-control" placeholder="UF"
								value="${pre_glo.end_uf}">
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12 col-md-2 mb-2 mb-0 align-self-center text-center">

							<label id="l_end_cep" data-placeholder="CEP"></label> <input
								onblur="CEPPESQ();" type="text" maxlength="10" name="end_cep"
								id="end_cep" autocomplete="off" class="form-control"
								placeholder="CEP" value="${pre_glo.end_cep}">
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div id="col-obs"
							class="col-12 col-md-9 mb-2 mb-0 align-self-center text-center">
							<label id="l_obs" data-placeholder="Observações"></label>
							<textarea name="obs" id="obs" class="form-control"
								placeholder="Observação" autocomplete="off" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_glo.obs}</textarea>
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
				<div class="container mt-1">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12 col-md-2 mb-2 mb-0 align-self-center text-center">
							<label id="l_tel_1" data-placeholder="Telefone"></label> <input
								type="text" maxlength="20" name="tel_1" id="tel_1"
								autocomplete="off" class="form-control" placeholder="Telefone"
								value="${pre_glo.tel_1}">
							<script>
								const telInput = document
										.getElementById('tel_1');

								telInput
										.addEventListener(
												'input',
												function(e) {
													let cursorPosition = this.selectionStart; // salva posição do cursor
													let value = this.value
															.replace(/\D/g, ''); // remove tudo que não é número

													// Limita a 11 dígitos
													if (value.length > 11)
														value = value.slice(0,
																11);

													// Formatação condicional
													if (value.length > 6) {
														value = value
																.replace(
																		/^(\d{2})(\d{5})(\d{0,4})$/,
																		'($1) $2-$3');
													} else if (value.length > 2) {
														value = value
																.replace(
																		/^(\d{2})(\d{0,4})$/,
																		'($1) $2');
													} else if (value.length > 0) {
														value = value.replace(
																/^(\d*)$/,
																'($1');
													}

													this.value = value;

													// Ajusta cursor para permitir apagar normalmente
													if (e.inputType === "deleteContentBackward") {
														this.selectionStart = this.selectionEnd = cursorPosition;
													}
												});
							</script>

						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12 col-md-6 mb-2 mb-0 align-self-center text-center">
							<label id="l_email_1" data-placeholder="E-mail"></label>
							<textarea name="email_1" id="email_1" class="form-control"
								placeholder="E-mail" autocomplete="off" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_glo.email_1}</textarea>
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-2 mb-2 mb-0 align-self-center text-center">

						</div>
						<!-- coluna Direita -->
						<!-- FIM row -->
					</div>
					<!-- FIM row -->
					<hr>
					<!-- FIM Container -->
				</div>
				<!-- FIM Container -->
				<!--  -->

			<!--  -->
			<!-- Inicio Container -->
				<div class="container mt-1">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left g-1">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12 col-md-9 mb-2 mb-0 align-self-center text-center">
							<label id="l_cont_no_dom" data-placeholder="Busca Contato"></label> <input
								type="text"  name="cont_no_dom" id="cont_no_dom"
								autocomplete="off" class="form-control" placeholder="Busca Contato"
								value="">

						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12 col-md-1 mb-2 align-self-center text-center text-md-start">
				<button onclick="bus_p1();" class="btn btn-success"
						type="button" id="button-addon2">Buscar</button>
							
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-2 mb-2 text-center text-md-start">
<!--  -->
	<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#adi_dom">
 Adiciona Dominio
</button>

<!-- Modal -->
<div class="modal fade" id="adi_dom" tabindex="-1" aria-labelledby="m_adi_dom" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="m_adi_dom">Adiciona Dominio</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        


			<!--  -->
			<!-- Inicio Container -->
				<div class="container mt-1">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12  mb-2 align-self-center text-center">
											<label id="l_no_dom" data-placeholder="Nome do Dominio"></label>
							<textarea class="form-control" autocomplete="off"
								name="no_dom" id="no_dom"
								placeholder="Nome do Dominio" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_dom.no_dom}</textarea>
								
							
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12  mb-2 align-self-center text-center">
									<label id="l_sis_url" data-placeholder="URL - Caminho do Sistema"></label>
							<textarea class="form-control" autocomplete="off"
								name="sis_url" id="sis_url"
								placeholder="URL - Caminho do Sistema" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_dom.sis_url}</textarea>
							
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12  mb-2  align-self-center text-center">
										<label id="l_sis_tp_site" data-placeholder="Tipo de Site"></label>						
				<input class="form-control" list="list_tp_site" value="${pre_dom.sis_tp_site}"
								name="sis_tp_site" id="sis_tp_site" placeholder="Tipo de Site"
								onblur="validarTipoSite()">

							<datalist id="list_tp_site">
								<c:forEach items="${sis_cons_tp_site}" var="t_tp_site">
									<option value="${t_tp_site.nomeDesc}"></option>
								</c:forEach>
							</datalist>
		<script>
function validarTipoSite() {
    const input = document.getElementById("sis_tp_site");
    const datalist = document.getElementById("list_tp_site");
    const opcoes = Array.from(datalist.options).map(o => o.value);

    if (!opcoes.includes(input.value)) {
        input.value = "";
        alert("Selecione um valor válido da lista");
    }
}
</script>


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
				<div class="container mt-1">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12  mb-2 align-self-center text-center">
			<label id="l_titulo_web" data-placeholder="Titulo Web"></label>
			<textarea name="titulo_web" id="titulo_web"
			class="form-control" placeholder="Titulo Web"
			autocomplete="off" rows="1"
		style="overflow: hidden; resize: none;"
		oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_dom.titulo_web}</textarea>
							
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
								<div
							class="col-12  mb-2  align-self-center text-center">
										<label id="l_tipo_ace" data-placeholder="Autorização de Acesso"></label>						
				<input class="form-control" list="list_tipo_ace" value="${pre_dom.ace_per_aut}"
								name="sis_tipo_ace" id="sis_tipo_ace" placeholder="Autorização de Acesso"
								onblur="validartipo_ace()">

							<datalist id="list_tipo_ace">
								<c:forEach items="${sis_cons_tip_ace}" var="t_tipo_ace">
									<option value="${t_tipo_ace.nomeDesc}"></option>
								</c:forEach>
							</datalist>
		<script>
function validartipo_ace() {
    const input = document.getElementById("sis_tipo_ace");
    const datalist = document.getElementById("list_tipo_ace");
    const opcoes = Array.from(datalist.options).map(o => o.value);

    if (!opcoes.includes(input.value)) {
        input.value = "";
        alert("Selecione um valor válido da lista");
    }
}
</script>


												</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12  mb-2  align-self-center text-center">

													<label id="l_nome_desc_usu" data-placeholder="Nome do Usuario"></label>
													<textarea name="nome_desc_usu" id="nome_desc_usu"
														class="form-control" placeholder="Nome do Usuario"
														autocomplete="off" rows="1"
														style="overflow: hidden; resize: none;"
														oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_dom.nome_desc}</textarea>

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
				<div class="container mt-1">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12  mb-2 align-self-center text-center">
																				<label id="l_email_1_usu" data-placeholder="E-mail"></label>
													<textarea name="email_1_usu" id="email_1_usu"
														class="form-control" placeholder="E-mail"
														autocomplete="off" rows="1"
														style="overflow: hidden; resize: none;"
														oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_dom.email}</textarea>
				
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12  mb-2 align-self-center text-center">
																		<label id="l_l_usu" data-placeholder="Usuario para Login"></label>
													<textarea name="l_usu" id="l_usu"
														class="form-control" placeholder="Usuario para Login"
														autocomplete="off" rows="1"
														style="overflow: hidden; resize: none;"
														oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_dom.l_usu}</textarea>
									
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12  mb-2 align-self-center text-center">
																<label id="l_l_sen" data-placeholder="Senha para Login"></label>
													<textarea name="l_sen" id="l_sen"
														class="form-control" placeholder="Senha para Login"
														autocomplete="off" rows="1"
														style="overflow: hidden; resize: none;"
														oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_dom.l_sen}</textarea>
	
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
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Salva</button>
      </div>
    </div>
  </div>
</div>
<!--  -->
												</div>
						<!-- coluna Direita -->
						<!-- FIM row -->
					</div>
					<!-- FIM row -->
	<hr>
					<!-- FIM Container -->
				</div>
			<!-- FIM Container -->
			<!--  -->



				<!-- FIM Ocultar-->
			</c:if>
			<!-- FIM Ocultar -->
			<!-- FIM DADO -->


			<!--  -->
			<!-- final form -->
		</form>
		<!-- final form -->
		<!-- Campo de entrada -->
		<!--  -->
		<!-- Borda -->
	</div>
	<!-- Borda -->


	<!-- ====== SCRIPT PRINCIPAL ====== -->
	<script type="text/javascript">
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

</script>


	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
		integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13"
		crossorigin="anonymous"></script>


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


</body>

</html>