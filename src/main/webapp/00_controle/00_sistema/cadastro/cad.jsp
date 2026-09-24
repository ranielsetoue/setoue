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
		
		<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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

<c:set scope="session" var="tab_dom_ocult"
	value="${sessionScope.tab_dom_ocult}" />

<c:set scope="session" var="tab_cont_ocult"
	value="${sessionScope.tab_cont_ocult}" />

<c:set scope="session" var="ocul_excluir"
	value="${sessionScope.ocul_excluir}" />


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
			alert("Preencher Dado");
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
			alert('Erro ao deletar Cadastro: ' + xhr.responseText);
		});

	}

	
	
	function carregarDominios() {

	
		    var urlAction = '<%=request.getContextPath()%>/lt_sis_salvar/?fun=atual_list_sis_dom';
		    var dom_cnpj_cpf = document.getElementById('cnpj_cpf').value;

		    $.ajax({
		        type: "POST",
		        url: urlAction,
		        data: {
		            dom_cnpj_cpf: dom_cnpj_cpf
		        },

		        success: function(response) {

		            $("#t_list_dom tbody").html(response);
		        },

		        error: function(xhr, status, error) {
		            console.log(xhr.responseText);
		            alert("Erro ao carregar domínios: " + error);
		        }
		    });
		
	}	
	
	function sav_dom() {

if (document.getElementById("no_dom").value == ''
				|| document.getElementById("sis_url").value == ''
					|| document.getElementById("sis_tipo_ace").value == ''
						|| document.getElementById("sis_tp_site").value == ''

		) {
			alert('Preencher Dado');
		} else {


			
			var btn = document.getElementById("sal_dom");

		    // 🔒 BLOQUEIA O BOTÃO
		    btn.disabled = true;
			
			var urlAction = '<%=request.getContextPath()%>/lt_sis_salvar/?fun=salvar_dom';

			$.ajax({

				type : "POST",
				url : urlAction,
				data : $("#fon_cad").serialize(),

				success : function(response) {


			        // ✅ FECHA O MODAL SOMENTE SE SALVAR
					
					if (response.status === 'ok') {

						   document.getElementById('cont_no_dom').value = document.getElementById('no_dom').value;

						
						totalRegistrosdom++;

						// Volta para a primeira página
						    carregarPaginadom(1);
					                
		                const modalEl = document.getElementById('adi_dom');
		                bootstrap.Modal.getInstance(modalEl).hide();                	                
		                alert(response.msg);
		                

		                btn.disabled = false;		                
		            } else {

		                // ❌ NÃO FECHA
		                alert(response.msg);
		                btn.disabled = false;		                

		            }

				}

			}).fail(function(xhr, status, errorThrown) {
                btn.disabled = false;		                
				alert('Erro ao deletar usuário por id: ' + xhr.responseText);

			});

		}

	}

	function exc_dom(id, elemento) {


		 if (!confirm("Deseja excluir este registro?")) {
		        return;
		    }
		 
		 
		    var urlAction = '<%=request.getContextPath()%>/lt_sis_excluir/?fun=excluir_sis_dom';

		    $.ajax({
		        type: "POST",
		        url: urlAction,
		        data: {
		        	id_sis_dom: id
		        },

		        success: function(response) {
		    	    // Após excluir no banco...
		    	    elemento.closest("tr").remove();	    
		            // Diminui o total
		            totalRegistrosdom--;
		         // Volta para a primeira página
				    carregarPaginadom(1);

		    	    
		        },

		        error: function(xhr, status, error) {
		            console.log(xhr.responseText);
		            alert("Erro ao deletar contato: " + error);
		        }
		    });
		 
	    
	}	

	function detalhe_dom(textx) {

		let no_dom = textx.dataset.no_dom;
		let sis_url = textx.dataset.sis_url;
		let tp_sit = textx.dataset.tp_sit;
		let titulo_web = textx.dataset.titulo_web;
		let ace_per_aut = textx.dataset.ace_per_aut;
		let nome_desc = textx.dataset.nome_desc;
		let email_1 = textx.dataset.email_1;
		let l_usu = textx.dataset.l_usu;
		let l_sen = textx.dataset.l_sen;

		document.getElementById("no_dom").value = no_dom;
		document.getElementById("sis_url").value = sis_url;
		document.getElementById("sis_tp_site").value = tp_sit;
		document.getElementById("titulo_web").value = titulo_web;
		document.getElementById("sis_tipo_ace").value = ace_per_aut;
		document.getElementById("nome_desc_usu").value = nome_desc;
		document.getElementById("email_1_usu").value = email_1;
		document.getElementById("l_usu").value = l_usu;
		document.getElementById("l_sen").value = l_sen;

		    let modal = new bootstrap.Modal(document.getElementById('adi_dom'));
		    modal.show();
		 
	}

	
	
	function limpar_modal_dominio() {

		
	var cnpjCpf = document.getElementById("cnpj_cpf").value.trim();
		
		if (cnpjCpf === "") {
 		alert("Informe o CNPJ ou CPF antes de adicionar um Dominio."); 
 		document.getElementById("cnpj_cpf").focus();
 		return;
        }
		
	
		document.getElementById("no_dom").value = '';
		document.getElementById("sis_url").value = '';
		document.getElementById("sis_tp_site").value = '';
		document.getElementById("titulo_web").value = '';
		document.getElementById("sis_tipo_ace").value = '';
		document.getElementById("nome_desc_usu").value = '';
		document.getElementById("email_1_usu").value = '';
		document.getElementById("l_usu").value = '';
		document.getElementById("l_sen").value = '';
		

		var modal = new bootstrap.Modal(document.getElementById("adi_dom")); modal.show();

		
		}

	
	function carregarcontato() {

		
	    var urlAction = '<%=request.getContextPath()%>/lt_sis_salvar/?fun=atual_list_sis_cont';
	    var cont_cnpj_cpf = document.getElementById('cnpj_cpf').value;

	    $.ajax({
	        type: "POST",
	        url: urlAction,
	        data: {
	        	cont_cnpj_cpf: cont_cnpj_cpf
	        },

	        success: function(response) {

	            $("#t_list_cont tbody").html(response);
	        },

	        error: function(xhr, status, error) {
	            console.log(xhr.responseText);
	            alert("Erro ao carregar Contato: " + error);
	        }
	    });
	
}	

	
	
	function sav_cont() {


		
		
		if (document.getElementById("cont_nome_desc").value == ''
				|| document.getElementById("cont_tel_1").value == ''
		
		) {
			alert('Preencher Dado');
		} else {

			var btn = document.getElementById("sal_sis_cont");

		    // 🔒 BLOQUEIA O BOTÃO
		    btn.disabled = true;
			
			var urlAction = '<%=request.getContextPath()%>/lt_sis_salvar/?fun=salvar_sis_cont';

			$.ajax({

				type : "POST",
				url : urlAction,
				data : $("#fon_cad").serialize(),

				success : function(response) {


			        // ✅ FECHA O MODAL SOMENTE SE SALVAR

					
					if (response.status === 'ok') {
		
		
						   document.getElementById('cont_bus_cont').value = document.getElementById('cont_nome_desc').value;
						
						
						totalRegistrosCont++;

						// Volta para a primeira página
						    carregarPaginacont(1);
						
						//<--! carregarcontato(); -->
		                // ✅ FECHA O MODAL
		                const modalEl = document.getElementById('adi_cont');
		                bootstrap.Modal.getInstance(modalEl).hide();
						 
		                									
			                // LIBERA O BOTÃO NOVAMENTE
		                    btn.disabled = false;

		                    document.getElementById('cont_bus_cont').value ="";
		                alert(response.msg);
		                

		            } else {

		                // ❌ NÃO FECHA
		                alert(response.msg);
		                btn.disabled = false;		                

		            }

				}

			}).fail(function(xhr, status, errorThrown) {
                btn.disabled = false;		                
				alert('Erro ao deletar usuário por id: ' + xhr.responseText);

				
			});

		}
	
	}

	function exc_cont(id, elemento) {

		 if (!confirm("Deseja excluir este registro?")) {
		        return;
		    }
		 
		 
		    var urlAction = '<%=request.getContextPath()%>/lt_sis_excluir/?fun=excluir_sis_cont';

		    $.ajax({
		        type: "POST",
		        url: urlAction,
		        data: {
		        	id_sis_cont: id
		        },

		        success: function(response) {
		    	    // Após excluir no banco...
		    	

		            elemento.closest("tr").remove();

		            // Diminui o total
		            totalRegistrosCont--;
		         // Volta para a primeira página
				    carregarPaginacont(1);
					        },

		        error: function(xhr, status, error) {
		            console.log(xhr.responseText);
		            alert("Erro ao deletar contato: " + error);
		        }
		    });
		 
	    
	}	

	function detalhe_cont(textx) {

		let nome_desc = textx.dataset.nome_desc;
		let tel_1 = textx.dataset.tel_1;
		let tel_2 = textx.dataset.tel_2;
		let email_1 = textx.dataset.email_1;
		let email_2 = textx.dataset.email_2;
		let setor_1 = textx.dataset.setor_1;
		let obs = textx.dataset.obs;


		document.getElementById("cont_nome_desc").value = nome_desc;
		document.getElementById("cont_tel_1").value = tel_1;
		document.getElementById("cont_tel_2").value = tel_2;
		document.getElementById("cont_email_1").value = email_1;
		document.getElementById("cont_email_2").value = email_2;
		document.getElementById("cont_setor_1").value = setor_1;
		document.getElementById("cont_obs").value = obs;

		    let modal = new bootstrap.Modal(document.getElementById('adi_cont'));
		    modal.show();
		 
	}

	function limpar_modal_contato() {
		
		var cnpjCpf = document.getElementById("cnpj_cpf").value.trim();
		
		if (cnpjCpf === "") {
 		alert("Informe o CNPJ ou CPF antes de adicionar um contato."); 
 		document.getElementById("cnpj_cpf").focus();
 		return;
        }
		
		document.getElementById("cont_nome_desc").value = '';
		document.getElementById("cont_tel_1").value = '';
		document.getElementById("cont_tel_2").value = '';
		document.getElementById("cont_email_1").value = '';
		document.getElementById("cont_email_2").value = '';
		document.getElementById("cont_setor_1").value = '';
		document.getElementById("cont_obs").value = '';

		var modal = new bootstrap.Modal(document.getElementById("adi_cont")); modal.show();
			
			
		}
	
function bus_p1(){

	if (document.getElementById("cont_bus_cont").value == ''
) {
	    carregarPaginacont(1);
		alert('Preencher Dado');

	} else {

    carregarPaginacont(1);
    document.getElementById('cont_bus_cont').value = "";
	
}	

    
}	
	


function bus_p2(){

	if (document.getElementById("cont_no_dom").value == ''
	) {
	    carregarPaginadom(1);
		alert('Preencher Dado');

	} else {
	
    carregarPaginadom(1);
    document.getElementById('cont_no_dom').value = "";

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
<div class="col-12 col-md-5 mb-2 mb-md-0 align-self-start 
            text-start text-md-start text-center">

    <div class="d-flex justify-content-center justify-content-md-start 
                align-items-start gap-2">

        <!-- Página Inicial -->
        <a href="<%=request.getContextPath()%>/lt_sis/?fun=ini_cont">
            <button type="button" class="btn btn-primary">
                Pagina Inicial
            </button>
        </a>

        <!-- Cadastro -->
        <div class="dropdown">
            <button class="btn btn-primary dropdown-toggle"
                    type="button"
                    data-bs-toggle="dropdown"
                    aria-expanded="false">
                Cadastro
            </button>

            <ul class="dropdown-menu">

                <c:if test="${aces_cad_sis}">
                    <a class="dropdown-item"
                       href="<%=request.getContextPath()%>/lt_sis/?fun=cad_sis">
                        SISTEMA
                    </a>
                </c:if>

                <c:if test="${aces_cad_clin}">
                    <a class="dropdown-item"
                       href="<%=request.getContextPath()%>/lt_sis/?fun=cad_cli">
                        CLIENTE
                    </a>
                </c:if>

                <c:if test="${aces_cad_forn}">
                    <a class="dropdown-item"
                       href="<%=request.getContextPath()%>/lt_sis/?fun=cad_for">
                        FORNECEDOR
                    </a>
                </c:if>

                <c:if test="${aces_cad_prod}">
                    <a class="dropdown-item"
                       href="<%=request.getContextPath()%>/lt_sis/?fun=cad_pro">
                        PRODUTO
                    </a>
                </c:if>

                <c:if test="${aces_cad_serv}">
                    <a class="dropdown-item"
                       href="<%=request.getContextPath()%>/lt_sis/?fun=cad_serv">
                        SERVICO
                    </a>
                </c:if>

            </ul>
        </div>

    </div>

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
	
<c:if test="${not empty cons_false and cons_false eq 'true'}">
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

<c:if test="${not empty cons_true and cons_true eq 'true'}">
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
						
						
						<c:if test="${not empty ocul_excluir and ocul_excluir eq 'true'}">
						<div
							class="col-4 col-md-4 mb-2 mb-md-0 align-self-center text-center">
							<button type="button" class="btn btn-danger"
								onclick="excluir_dado();">EXCLUIR</button>
						</div>
						</c:if>
						
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
<c:if test="${not empty cons_true and cons_true eq 'true'}">
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
							class="col-12 col-md-3 mb-2 mb-0 align-self-center text-center">
							<label id="l_tel_1" data-placeholder="Telefone"></label> 
							<input
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
								placeholder="E-mail envio Nota Fiscal" autocomplete="off" rows="1"
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
<!-- Inico Contado-->
<c:if test="${not empty tab_cont_ocult and tab_cont_ocult eq 'true'}">
<!-- Ocultar Inico Contado-->
		<!-- Inicio Container -->
				<div class="container mt-1">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left g-1">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12 col-md-8 mb-2 mb-0 align-self-center text-center">
										<c:if test="${not empty cont_list}">
							
							
							
							<textarea name="cont_bus_cont" id="cont_bus_cont" class="form-control"
								placeholder="Busca Contado" autocomplete="off" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';"></textarea>
						</c:if>
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12 col-md-2 mb-2 align-self-center text-center text-md-start">
								<c:if test="${not empty cont_list}">
							
				<button onclick="bus_p1();" class="btn btn-success"
						type="button" id="busc_cont">Buscar Contado</button>
						</c:if>
						</div>

						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-2 mb-2 text-center text-md-start">
<!--  -->
	<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" onclick="limpar_modal_contato()" data-bs-target="#adi_cont">
 Adiciona Contado
</button>

<!-- Modal -->
<div class="modal fade" id="adi_cont" tabindex="-1" aria-labelledby="m_adi_cont" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="m_adi_dom">Adiciona Contado</h1>
        <button type="button" class="btn-close"  data-bs-dismiss="modal" aria-label="Close"></button>
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
											<label id="l_cont_nome_desc" data-placeholder="Nome"></label>
							<textarea class="form-control" autocomplete="off"
								name="cont_nome_desc" id="cont_nome_desc"
								placeholder="Nome" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_cont.nome_desc}</textarea>
								
							
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12  mb-2 align-self-center text-center">
									<label id="l_cont_tel_1" data-placeholder="Telefone 1"></label>
							<textarea class="form-control" autocomplete="off"
								name="cont_tel_1" id="cont_tel_1"
								placeholder="Telefone 1" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_cot.tel_1}</textarea>
							
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12  mb-2  align-self-center text-center">
									<label id="l_cont_tel_2" data-placeholder="Telefone 2"></label>
							<textarea class="form-control" autocomplete="off"
								name="cont_tel_2" id="cont_tel_2"
								placeholder="Telefone 2" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_cot.tel_2}</textarea>
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
									<label id="l_cont_email_1" data-placeholder="Email 1"></label>
							<textarea class="form-control" autocomplete="off"
								name="cont_email_1" id="cont_email_1"
								placeholder="Email 1" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_cot.email_1}</textarea>
							
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
								<div
							class="col-12  mb-2  align-self-center text-center">
									<label id="l_cont_email_2" data-placeholder="Email 2"></label>
							<textarea class="form-control" autocomplete="off"
								name="cont_email_2" id="cont_email_2"
								placeholder="Email 2" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_cot.email_2}</textarea>
												</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12  mb-2  align-self-center text-center">
									<label id="l_cont_setor_1" data-placeholder="setor_1"></label>
							<textarea class="form-control" autocomplete="off"
								name="cont_setor_1" id="cont_setor_1"
								placeholder="Setor" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_cot.setor_1}</textarea>

	
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
									<label id="l_cont_obs" data-placeholder="obs"></label>
							<textarea class="form-control" autocomplete="off"
								name="cont_obs" id="cont_obs"
								placeholder="Observação" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_cot.obs}</textarea>
				
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12  mb-2 align-self-center text-center">
									
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12  mb-2 align-self-center text-center">
														
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
					
						</div>
						<!-- coluna esquerda -->

						<!-- FIM row -->
					</div>
					<!-- FIM row -->
					<!-- FIM Container -->
				</div>
			<!-- FIM Container -->
			<!--  -->
			
      </div>

      <div class="modal-footer">
  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
    Cancelar
</button>
        <button id="sal_sis_cont" type="button" class="btn btn-primary" onclick="sav_cont();" >Salva</button>
        
  
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
					<!-- FIM Container -->
				</div>
			<!-- FIM Container -->
			<!--  -->

<!--Inico Tabela Contado  -->

				<!-- Inicio Container -->
				<div class="container mt-1">
			<c:if test="${not empty cont_list}">
<hr>

					<!-- Inicio Container -->

		<div style="height: 350px; overflow: scroll;">
					<table class="table" id="t_list_cont">
				<thead>
					<tr>
						<th scope="col">Nome</th>
						<th scope="col">Telefone</th>
						<th scope="col">E-mail</th>
						<th scope="col">Deletar</th>
						<th scope="col">Editar</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${cont_list}" var="ml">
						<tr>
							<td><c:out value="${ml.nome_desc}"></c:out></td>
							<td><c:out value="${ml.tel_1}"></c:out></td>
							<td><c:out value="${ml.email_1}"></c:out></td>
							<td><a onclick="exc_cont(${ml.id_sis_cont}, this); return false;"
								class="btn btn-danger">Excluir</a></td>
							<td><button type="button" id="adicionar_cont"
										 onclick="detalhe_cont(this)"
										 data-nome_desc="${ml.nome_desc}"
data-tel_1="${ml.tel_1}"
data-tel_2="${ml.tel_2}"
data-email_1="${ml.email_1}"
data-email_2="${ml.email_2}"
data-setor_1="${ml.setor_1}"
data-obs="${ml.obs}"
									
									
									class="btn btn-warning" data-bs-toggle="modal">Detalhes</button></td>

						</tr>

					</c:forEach>
				</tbody>
			</table>

		</div>
</c:if>

				<c:if test="${not empty cont_list}">
		
<hr>

<div id="paginacao_cont"
     class="d-flex align-items-center justify-content-center flex-wrap mt-2">     
    <!-- PAGINAÇÃO -->
    <span id="pag_cont"
          class="d-flex align-items-center">
    </span>

    <!-- SEPARADOR -->
    <span class="text-secondary mx-2">|</span>

    <!-- INFORMAÇÃO -->
    <span id="info_cont"
          class="text-secondary">
    </span>

</div>
</c:if>
<script type="text/javascript">

    /* =====================================================
       CONFIGURAÇÃO
       ===================================================== */

    var totalRegistrosCont = ${cont_list_qt.size()};
    var paginaAtualCont = 1;
    var registrosPorPaginaCont = 5;


    /* =====================================================
       ATUALIZA INFORMAÇÃO
       Exemplo: 1 - 5 de 21
       ===================================================== */

    function atualizarInfocont(pagina) {

        var registrosPorPagina = registrosPorPaginaCont;
        var totalRegistros = totalRegistrosCont || 0;

        var infoCont = document.getElementById("info_cont");

        /* Nenhum registro */
        if (totalRegistros === 0) {

            infoCont.innerHTML = "0 - 0 de 0";

            return;
        }


        /* Primeiro registro */
        var inicio =
            ((pagina - 1) * registrosPorPagina) + 1;


        /* Último registro */
        var fim =
            pagina * registrosPorPagina;


        /* Não ultrapassar total */
        if (fim > totalRegistros) {

            fim = totalRegistros;
        }


        infoCont.innerHTML =
            inicio + " - " + fim + " de " + totalRegistros;
    }


    /* =====================================================
       MONTA A PAGINAÇÃO
       ===================================================== */

    function montarPaginascont(paginaAtual) {

        var registrosPorPagina = registrosPorPaginaCont;

        var totalRegistros =
            totalRegistrosCont || 0;

        var totalPaginas =
            Math.ceil(
                totalRegistros / registrosPorPagina
            );

        var html = "";


        /* =================================================
           SEM REGISTROS
           ================================================= */

        if (totalPaginas === 0) {

            document.getElementById("pag_cont").innerHTML = "";

            return;
        }


        /* =================================================
           BOTÃO PRIMEIRA
           ================================================= */

        if (paginaAtual === 1) {

            html +=
                '<button type="button" ' +
                'class="btn btn-light border rounded-3 px-3 py-2" ' +
                'disabled>' +
                'Primeira' +
                '</button>';

        } else {

            html +=
                '<button type="button" ' +
                'class="btn btn-light border rounded-3 px-3 py-2" ' +
                'onclick="carregarPaginacont(1)">' +
                'Primeira' +
                '</button>';
        }


        /* =================================================
           SEPARADOR
           ================================================= */

        html +=
            '<span class="text-secondary mx-2">|</span>';


        /* =================================================
           DEFINE AS PÁGINAS VISÍVEIS

           Até 3 páginas:
           1 2 3

           Página 3:
           2 3 4

           Última:
           4 5 6
           ================================================= */

        var inicio;
        var fim;


        if (totalPaginas <= 3) {

            inicio = 1;
            fim = totalPaginas;

        } else {

            inicio = paginaAtual - 1;
            fim = paginaAtual + 1;


            /* Primeira ou segunda página */

            if (paginaAtual <= 2) {

                inicio = 1;
                fim = 3;
            }


            /* Penúltima ou última página */

            if (paginaAtual >= totalPaginas - 1) {

                inicio = totalPaginas - 2;
                fim = totalPaginas;
            }
        }


        /* =================================================
           NÚMEROS DAS PÁGINAS
           ================================================= */

        for (
            var pagina = inicio;
            pagina <= fim;
            pagina++
        ) {


            /* ---------------------------------------------
               PÁGINA ATUAL
               --------------------------------------------- */

            if (pagina === paginaAtual) {

                html +=
                    '<button type="button" ' +
                    'class="btn btn-primary rounded-3 px-3 py-2 mx-1" ' +
                    'disabled>' +
                    pagina +
                    '</button>';

            }


            /* ---------------------------------------------
               OUTRAS PÁGINAS
               --------------------------------------------- */

            else {

                html +=
                    '<button type="button" ' +
                    'class="btn btn-light border rounded-3 px-3 py-2 mx-1" ' +
                    'onclick="carregarPaginacont(' +
                    pagina +
                    ')">' +
                    pagina +
                    '</button>';
            }
        }


        /* =================================================
           COLOCA PAGINAÇÃO NA TELA
           ================================================= */

        document.getElementById("pag_cont").innerHTML =
            html;
    }


    /* =====================================================
       CARREGA A PÁGINA
       ===================================================== */

    function carregarPaginacont(pagina) {

        /* Guarda página atual */
        paginaAtualCont = pagina;


        /* Atualiza informação */
        atualizarInfocont(pagina);


        /* Atualiza botões */
        montarPaginascont(pagina);


        /* =================================================
           OFFSET
           ================================================= */

        var registrosPorPagina =
            registrosPorPaginaCont;

        var offset =
            (pagina - 1) * registrosPorPagina;


        /* =================================================
           URL
           ================================================= */

        var urlAction =
            '<%=request.getContextPath()%>/lt_sis_busc/?fun=pag_cont';


        /* =================================================
           CNPJ / CPF
           ================================================= */
   	    var cont_bus_cont = document.getElementById('cont_bus_cont').value;

        var campoCnpjCpf =
            document.getElementById('cnpj_cpf');

        var cont_cnpj_cpf = "";

        if (campoCnpjCpf) {

            cont_cnpj_cpf =
                campoCnpjCpf.value;
        }


        /* =================================================
           AJAX
           ================================================= */

        $.ajax({

            type: "POST",

            url: urlAction,

            data: {

                offset: offset,
                cont_bus_cont:cont_bus_cont,	
                cont_cnpj_cpf: cont_cnpj_cpf
            },


            /* ---------------------------------------------
               SUCESSO
               --------------------------------------------- */

            success: function(response) {

                $("#t_list_cont tbody").html(response);
            },


            /* ---------------------------------------------
               ERRO
               --------------------------------------------- */

            error: function(xhr, status, error) {

                console.log(xhr.responseText);

                alert(
                    "Erro ao carregar página Contato: " +
                    error
                );
            }

        });
    }


    /* =====================================================
       INICIALIZA PAGINAÇÃO
       ===================================================== */

    atualizarInfocont(1);

    montarPaginascont(1);

</script>


							<!-- FIM Container -->
				</div>
			<!-- FIM Container -->
<!-- Fim Tabela Contado -->

<!-- Ocultar Fim Contado-->
</c:if>
<!-- FIM Contado-->


<!-- Inico Dominio-->
<c:if test="${not empty tab_dom_ocult and tab_dom_ocult eq 'true'}">
<!-- Ocultar Inico Dominio-->


			<!--  -->
			<!-- Inicio Container -->
				<div class="container mt-1">
<hr>

					<!-- Inicio Container -->

					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left g-1">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12 col-md-8 mb-2 mb-0 align-self-center text-center">
															<c:if test="${not empty dom_list}">
							
							<textarea name="cont_no_dom" id="cont_no_dom" class="form-control"
								placeholder="Busca Dominio" autocomplete="off" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';"></textarea>
							</c:if>
				
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12 col-md-2 mb-2 align-self-center text-center text-md-start">
																		<c:if test="${not empty dom_list}">
				
				<button onclick="bus_p2();" class="btn btn-success"
						type="button" id="busc_dom">Buscar Dominio</button>
				</c:if>			
						</div>

						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-2 mb-2 text-center text-md-start">
							
<!--  -->

	<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" onclick="limpar_modal_dominio()" data-bs-target="#adi_dom">
 Adiciona Dominio
</button>

<!-- Modal -->
<div class="modal fade" id="adi_dom" tabindex="-1" aria-labelledby="m_adi_dom" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="m_adi_dom">Adiciona Dominio</h1>
        <button type="button" class="btn-close"  data-bs-dismiss="modal" aria-label="Close"></button>
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
    const inputSite = document.getElementById("sis_tp_site");
    const datalist = document.getElementById("list_tp_site");
    const opcoes = Array.from(datalist.options).map(o => o.value);

    if (inputSite.value.trim() !== '' && !opcoes.includes(inputSite.value)) {
        inputSite.value = '';
        document.getElementById("sis_tp_site") == '';
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
				<input class="form-control" list="list_tipo_ace" value="${pre_dom.tipo_ace}"
								name="sis_tipo_ace" id="sis_tipo_ace" placeholder="Autorização de Acesso"
								onblur="validartipo_ace()">

							<datalist id="list_tipo_ace">
								<c:forEach items="${sis_cons_tip_ace}" var="t_tipo_ace">
									<option value="${t_tipo_ace.nomeDesc}"></option>
								</c:forEach>
							</datalist>
		<script>
function validartipo_ace() {
    const inputace = document.getElementById("sis_tipo_ace");
    const datalist = document.getElementById("list_tipo_ace");
    const opcoesace = Array.from(datalist.options).map(o => o.value);

    if (inputace.value.trim() !== '' && !opcoesace.includes(inputace.value)) {
        inputace.value = '';
        document.getElementById("sis_tipo_ace").value == '';
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
       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
    Cancelar
</button>
      
        <button id="sal_dom" type="button" class="btn btn-primary" onclick="sav_dom();" >Salva</button>
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



<!-- Inicio Tabela Dominio  -->
				<!-- Inicio Container -->
				<div class="container mt-1">
					<c:if test="${not empty dom_list}">
						<!-- Inicio Container -->
		<div style="height: 350px; overflow: scroll;">
			<table class="table" id="t_list_dom">
				<thead>
					<tr>
						<th scope="col">Nome do Dominio</th>
						<th scope="col">Deletar</th>
						<th scope="col">Editar</th>

					</tr>
				</thead>
				<tbody>
					<c:forEach items="${dom_list}" var="ml">
						<tr>
							<td><c:out value="${ml.no_dom}"></c:out></td>
							<td><a onclick="exc_dom(${ml.id_sis_dom}, this); return false;"
								class="btn btn-danger">Excluir</a></td>
							<td><button type="button" id="adicionar_dom"
									 onclick="detalhe_dom(this)"
										 data-no_dom="${ml.no_dom}"
											 data-sis_url="${ml.sis_url}"
											 data-tp_sit="${ml.tp_sit}"
											 data-titulo_web="${ml.titulo_web}"
											 data-ace_per_aut="${ml.ace_per_aut}"
											 data-nome_desc="${ml.nome_desc}"
											 data-email_1="${ml.email_1}"
											 data-l_usu="${ml.l_usu}"
											 data-l_sen="${ml.l_sen}"    
								class="btn btn-warning" data-bs-toggle="modal">Detalhes</button></td>

						</tr>

					</c:forEach>
				</tbody>
			</table>
		</div>
				</c:if>
		
	<c:if test="${not empty dom_list}">
				
							<!-- FIM Container -->
							<hr>
<div id="paginacao_dom"
     class="d-flex align-items-center justify-content-center flex-wrap mt-2">

    <!-- PAGINAÇÃO -->
    <span id="pag_dom"
          class="d-flex align-items-center">
    </span>

    <!-- SEPARADOR -->
    <span class="text-secondary mx-2">|</span>

    <!-- INFORMAÇÃO -->
    <span id="info_dom"
          class="text-secondary">
    </span>

</div>
</c:if>

<script type="text/javascript">

    /* =====================================================
       CONFIGURAÇÃO
       ===================================================== */

    var totalRegistrosdom = ${dom_list_qt.size()};
    var paginaAtualDom = 1;
    var registrosPorPaginaDom = 5;


    /* =====================================================
       ATUALIZA INFORMAÇÃO
       Exemplo: 1 - 5 de 21
       ===================================================== */

    function atualizarInfodom(pagina) {

        var registrosPorPagina =
            registrosPorPaginaDom;

        var totalRegistros =
            totalRegistrosdom || 0;

        var infoDom =
            document.getElementById("info_dom");


        /* Nenhum registro */

        if (totalRegistros === 0) {

            infoDom.innerHTML =
                "0 - 0 de 0";

            return;
        }


        /* Primeiro registro */

        var inicio =
            ((pagina - 1) * registrosPorPagina) + 1;


        /* Último registro */

        var fim =
            pagina * registrosPorPagina;


        /* Não ultrapassar total */

        if (fim > totalRegistros) {

            fim = totalRegistros;
        }


        infoDom.innerHTML =
            inicio + " - " + fim +
            " de " + totalRegistros;
    }


    /* =====================================================
       MONTA PAGINAÇÃO
       ===================================================== */

    function montarPaginasdom(paginaAtual) {

        var registrosPorPagina =
            registrosPorPaginaDom;

        var totalRegistros =
            totalRegistrosdom || 0;

        var totalPaginas =
            Math.ceil(
                totalRegistros / registrosPorPagina
            );

        var html = "";


        /* =================================================
           SEM REGISTROS
           ================================================= */

        if (totalPaginas === 0) {

            document.getElementById(
                "pag_dom"
            ).innerHTML = "";

            return;
        }


        /* =================================================
           BOTÃO PRIMEIRA
           ================================================= */

        if (paginaAtual === 1) {

            html +=
                '<button type="button" ' +
                'class="btn btn-light border rounded-3 px-3 py-2" ' +
                'disabled>' +
                'Primeira' +
                '</button>';

        } else {

            html +=
                '<button type="button" ' +
                'class="btn btn-light border rounded-3 px-3 py-2" ' +
                'onclick="carregarPaginadom(1)">' +
                'Primeira' +
                '</button>';
        }


        /* =================================================
           SEPARADOR
           ================================================= */

        html +=
            '<span class="text-secondary mx-2">|</span>';


        /* =================================================
           DEFINE AS PÁGINAS VISÍVEIS
           
           Página 1:
           1 2 3

           Página 2:
           1 2 3

           Página 3:
           2 3 4

           Página 4:
           3 4 5

           Última:
           4 5 6
           ================================================= */

        var inicio;
        var fim;


        if (totalPaginas <= 3) {

            inicio = 1;
            fim = totalPaginas;

        } else {

            inicio = paginaAtual - 1;
            fim = paginaAtual + 1;


            /* Primeira ou segunda */

            if (paginaAtual <= 2) {

                inicio = 1;
                fim = 3;
            }


            /* Penúltima ou última */

            if (paginaAtual >= totalPaginas - 1) {

                inicio = totalPaginas - 2;
                fim = totalPaginas;
            }
        }


        /* =================================================
           NÚMEROS DAS PÁGINAS
           ================================================= */

        for (
            var pagina = inicio;
            pagina <= fim;
            pagina++
        ) {


            /* ---------------------------------------------
               PÁGINA ATUAL
               --------------------------------------------- */

            if (pagina === paginaAtual) {

                html +=
                    '<button type="button" ' +
                    'class="btn btn-primary rounded-3 px-3 py-2 mx-1" ' +
                    'disabled>' +
                    pagina +
                    '</button>';

            }


            /* ---------------------------------------------
               OUTRAS PÁGINAS
               --------------------------------------------- */

            else {

                html +=
                    '<button type="button" ' +
                    'class="btn btn-light border rounded-3 px-3 py-2 mx-1" ' +
                    'onclick="carregarPaginadom(' +
                    pagina +
                    ')">' +
                    pagina +
                    '</button>';
            }
        }


        /* =================================================
           COLOCA NA TELA
           ================================================= */

        document.getElementById(
            "pag_dom"
        ).innerHTML = html;
    }


    /* =====================================================
       CARREGA A PÁGINA
       ===================================================== */

    function carregarPaginadom(pagina) {

        /* Guarda página atual */

        paginaAtualDom = pagina;


        /* Atualiza informação */

        atualizarInfodom(pagina);


        /* Atualiza paginação */

        montarPaginasdom(pagina);


        /* =================================================
           OFFSET
           ================================================= */

        var registrosPorPagina =
            registrosPorPaginaDom;

        var offset =
            (pagina - 1) *
            registrosPorPagina;


        /* =================================================
           URL
           ================================================= */

        var urlAction =
            '<%=request.getContextPath()%>/lt_sis_busc/?fun=pag_dom';


        /* =================================================
           CNPJ / CPF
           ================================================= */
           
      	    var cont_no_dom = document.getElementById('cont_no_dom').value;
      
        var campoCnpjCpf =
            document.getElementById(
                'cnpj_cpf'
            );

        var dom_cnpj_cpf = "";

        if (campoCnpjCpf) {

        	dom_cnpj_cpf =
                campoCnpjCpf.value;
        }


        /* =================================================
           AJAX
           ================================================= */

        $.ajax({

            type: "POST",

            url: urlAction,

            data: {

                offset: offset,
                cont_no_dom:cont_no_dom,
                dom_cnpj_cpf: dom_cnpj_cpf
            },


            /* ---------------------------------------------
               SUCESSO
               --------------------------------------------- */

            success: function(response) {

                $("#t_list_dom tbody")
                    .html(response);
            },


            /* ---------------------------------------------
               ERRO
               --------------------------------------------- */

            error: function(
                xhr,
                status,
                error
            ) {

                console.log(
                    xhr.responseText
                );

                alert(
                    "Erro ao carregar página Dominio: " +
                    error
                );
            }

        });
    }


    /* =====================================================
       INICIALIZAÇÃO
       ===================================================== */

    atualizarInfodom(1);

    montarPaginasdom(1);

</script>							
				</div>
			<!-- FIM Container -->
			<!--  -->
		
<!-- Fim Tabela Dominio -->
<!-- Ocultar Fim Dominio-->
</c:if>
<!-- FIM Dominio-->


<!-- Inicio ABA  -->

			<!--  -->
			<!-- Inicio Container -->
				<div class="container mt-3">
					<!-- Inicio Container -->
					<!-- Inicio row -->
	
	
<ul class="nav nav-tabs" id="myTab" role="tablist">

    <li class="nav-item" role="presentation">
        <button class="nav-link active"
                id="dados-tab"
                data-bs-toggle="tab"
                data-bs-target="#dados"
                type="button"
                role="tab">
            Dado Adicional
        </button>
    </li>

    <li class="nav-item" role="presentation">
        <button class="nav-link"
                id="financeiro-tab"
                data-bs-toggle="tab"
                data-bs-target="#financeiro"
                type="button"
                role="tab">
            Financeiro
        </button>
    </li>

    <li class="nav-item" role="presentation">
        <button class="nav-link"
                id="endereco-tab"
                data-bs-toggle="tab"
                data-bs-target="#endereco"
                type="button"
                role="tab">
            Endereço de Envio
        </button>
    </li>

</ul>


<div class="tab-content border border-top-0 p-3" id="myTabContent">

    <!-- DADO ADICIONAL -->
    <div class="tab-pane fade show active"
         id="dados"
         role="tabpanel"
         aria-labelledby="dados-tab">

   <div class="row">
    <div class="col-md-6 mb-3"> 
    <label for="email_nf" class="form-label"> E-mail - NF </label> 
    <input type="email" class="form-control" id="email_nf" name="email_nf" placeholder="Digite o e-mail para NF"> 
    </div>
     <div class="col-md-6 mb-3"> <label for="nome" class="form-label"> Nome </label> 
     <input type="text" class="form-control" id="nome" name="nome" placeholder="Digite o nome"> </div>
      </div>


    </div>


    <!-- FINANCEIRO -->
    <div class="tab-pane fade"
         id="financeiro"
         role="tabpanel"
         aria-labelledby="financeiro-tab">

        <div class="row">

            <div class="col-md-6 mb-3">
                <label for="chave_pix" class="form-label">
                    Chave Pix
                </label>

                <input type="text"
                       class="form-control"
                       id="chave_pix"
                       name="chave_pix"
                       placeholder="Digite a chave Pix">
            </div>

            <div class="col-md-6 mb-3">
                <label for="nome_pix" class="form-label">
                    Nome
                </label>

                <input type="text"
                       class="form-control"
                       id="nome_pix"
                       name="nome_pix"
                       placeholder="Nome do titular">
            </div>

        </div>

    </div>


    <!-- ENDEREÇO DE ENVIO -->
    <div class="tab-pane fade"
         id="endereco"
         role="tabpanel"
         aria-labelledby="endereco-tab">

        <div class="row">

            <div class="col-md-8 mb-3">
                <label for="endereco_completo" class="form-label">
                    Endereço completo
                </label>

                <input type="text"
                       class="form-control"
                       id="endereco_completo"
                       name="endereco_completo"
                       placeholder="Rua, número, complemento, bairro...">
            </div>

            <div class="col-md-4 mb-3">
                <label for="cep" class="form-label">
                    CEP
                </label>

                <input type="text"
                       class="form-control"
                       id="cep"
                       name="cep"
                       placeholder="00000-000"
                       maxlength="9">
            </div>

        </div>

    </div>

</div>
'
	
	

					<!-- FIM row -->
					<!-- FIM Container -->
				</div>
			<!-- FIM Container -->
			<!--  -->

  
<!-- Fim ABA  -->

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
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


</body>

</html>