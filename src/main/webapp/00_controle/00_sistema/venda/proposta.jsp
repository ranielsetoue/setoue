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

<c:set scope="session" var="naoexitedado"
	value="${sessionScope.naoexitedado}" />

<c:set scope="session" var="list_cons_ocult"
	value="${sessionScope.list_cons_ocult}" />


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

		if (document.getElementById("bus_cnpj_cpf").value == null
				|| document.getElementById("bus_cnpj_cpf").value == '') {

		} else {

			if (confirm('Deseja realmente excluir os dados?')) {

				var urlAction = '<%=request.getContextPath()%>/lt_sis_excluir/?fun=excluir';
				var busc_cnpj_cpf = document.getElementById('bus_cnpj_cpf').value;

				
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

	
	
	
	
	function carregarcontato() {

		
	    var urlAction = '<%=request.getContextPath()%>/lt_sis_salvar/?fun=atual_list_sis_cont';
	    var cont_cnpj_cpf = document.getElementById('bus_cnpj_cpf').value;

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

	var contListVazia = ${empty cont_list ? true : false};

	// Função opcional para reavaliar a visibilidade (útil se você tiver função de deletar)
	function atualizarVisibilidadeBotao() {
		 var divTextarea = document.getElementById('div_textarea_cont');
		    var divBotao = document.getElementById('div_botao_cont');
		    var divtabela = document.getElementById('div_tabela_cont');
	    
		    if (divTextarea) divTextarea.style.display = contListVazia ? 'none' : '';
		    if (divBotao) divBotao.style.display = contListVazia ? 'none' : '';
		    if (divtabela) divtabela.style.display = contListVazia ? 'none' : '';

	
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
		
						// Ocultar apenas o textarea
						document.getElementById('div_textarea_cont').style.display = '';

						// Exibir apenas o botão
						document.getElementById('div_botao_cont').style.display = '';
						// Exibir apenas o botão
						document.getElementById('div_tabela_cont').style.display = '';
	
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
		        	  // Após excluir no banco...
		    	    // 1. Remove a linha da tabela visualmente
						//  elemento.closest("tr").remove();
						   // Diminui o total
				      //      totalRegistrosCont--;
	        		 // Volta para a primeira página
			  		//	  carregarPaginacont(1);
		     
		            
			  			   // 1. Remove a linha da tabela visualmente
			              var tr = elemento.closest("tr");
			              if (tr) tr.remove();

			              // 2. Diminui o total de registros
			              if (typeof totalRegistrosCont !== 'undefined') {
			                  totalRegistrosCont--;
			              }

			              // 3. Função interna para forçar a ocultação
			              function forcarOcultacao() {
			                  if (totalRegistrosCont <= 0) {
			                      // Tenta ocultar pelas DIVs (se você adicionou os IDs nelas)
			                      var divTextarea = document.getElementById('div_textarea_cont');
			                      var divBotao = document.getElementById('div_botao_cont');
			          		    var divtabela = document.getElementById('div_tabela_cont');

			                      if (divTextarea) divTextarea.style.display = 'none';
			                      if (divBotao) divBotao.style.display = 'none';
			                      if (divtabela) divBotao.style.display = 'none';

			                      // Tenta ocultar diretamente pelos elementos (caso as DIVs não tenham os IDs)
			                      var txt = document.getElementById('cont_bus_cont');
			                      var btn = document.getElementById('busc_cont');
			                      var btn1 = document.getElementById('div_tabela_cont');
			                      if (txt) txt.style.display = 'none';
			                      if (btn) btn.style.display = 'none';
			                      if (btn1) btn1.style.display = 'none';
			                  }
			              }

			              // 4. Aplica a ocultação imediatamente
			              forcarOcultacao();

			              // 5. Recarrega a primeira página
			              carregarPaginacont(1);
			              
			              // 6. REFORÇO: Força a ocultação novamente após 300ms
			              // Isso garante que, se o carregarPaginacont(1) redesenhar a tela e mostrar os campos,
			              // nós os ocultamos logo em seguida.
			              setTimeout(forcarOcultacao, 300);
	        		 
			         
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
		
		var cnpjCpf = document.getElementById("bus_cnpj_cpf").value.trim();
		
		if (cnpjCpf === "") {
 		alert("Informe o CNPJ ou CPF antes de adicionar um contato."); 
 		document.getElementById("bus_cnpj_cpf").focus();
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


function sel_cons(cnpj_cpf, element) {
    // Define o valor e dispara o evento 'input' em cadeia
    $('#bus_cnpj_cpf').val(bus_cnpj_cpf).trigger('input');
    sis_busc();
}


function confirmarCliente() {
	  return new Promise((resolve) => {
	    const modal = document.getElementById('modalConfirmar');
	    const btnSim = document.getElementById('btnSim');
	    const btnNao = document.getElementById('btnNao');

	    // Mostra o modal
	    modal.style.display = 'flex';

	    // Evento do botão Sim
	    btnSim.onclick = () => {
	      modal.style.display = 'none';
	      resolve(true);
	    };

	    // Evento do botão Não
	    btnNao.onclick = () => {
	      modal.style.display = 'none';
	      resolve(false);
	    };
	  });
	}
</script>
<style>
  /* Por padrão (mobile): mostra a versão multi-linha */
  .mensagem-desktop {
    display: none;
  }

  .mensagem-mobile {
    display: block;
    text-align: center;
    font-family: monospace;
    font-size: 14px;
    white-space: pre-wrap;
  }

  /* A partir de 768px (tablet/desktop): mostra a versão linha única */
  @media (min-width: 768px) {
    .mensagem-desktop {
      display: block;
      text-align: center;
      font-family: monospace;
      font-size: 14px;
    }

    .mensagem-mobile {
      display: none;
    }
  }
</style>

 <!-- Importando o CSS externo -->
<c:set var="l_css" value="${pageContext.request.contextPath}/00_controle/00_sistema/Layout"/>
<link rel="stylesheet" href="${l_css}/css/botao.css">

<!--  -->
</head>
<body>

	<%@ include file="/00_controle/00_sistema/Layout/cabecalho.jsp" %>

	<!-- ----- inicio body -->
	<!--  -->
	<!-- Borda -->
	<div class="container-fluid	 mt-3 px-4">
		<!-- Borda -->
		<!-- inicio form -->
		<form id="fon_cad" method="post"
			action="<%=request.getContextPath()%>/lt_sis_busc/"
			onsubmit="return validardados()? true : false">
			<input type="hidden" name="fun" id="fun" value="" />
			<!-- Inicio Container -->
	
	
<!-- Inicio Cabecalho Proposta -->
<div class="container mt-3">
    <div class="row align-items-end">
        <!-- coluna esquerda - Número da Proposta -->
        <div class="col-12 col-md-3 mb-2 mb-md-0">
            <label>Número da Proposta</label>
            <input class="form-control" name="pro_id" id="pro_id" 
                   maxlength="18" placeholder="Número da Proposta" 
                   readonly value="${not empty pre_glo.pro_id ? pre_glo.pro_id : ''}">
        </div>
        
        <!-- coluna Central - Data -->
        <div class="col-12 col-md-2 mb-2 mb-md-0">
            <label>Data</label>

            <c:choose>
                <c:when test="${not empty pre_glo.reg_data}">
                    <fmt:formatDate value="${pre_glo.reg_data}" pattern="dd/MM/yyyy HH:mm" var="dataFormatada"/>
                </c:when>
                <c:otherwise>
                    <c:set var="dataFormatada" value=""/>
                </c:otherwise>
            </c:choose>

            <input class="form-control" name="pro_dat" id="pro_dat" 
                   placeholder="Data" readonly 
                   value="${dataFormatada}">
        </div>
        
        <!-- coluna Direita - Botões -->
        <div class="col-12 col-md-7">
            <div class="row align-items-end">
                <div class="col-6 col-md-3 mb-2 mb-md-0">
                    <!-- Espaçador invisível para alinhar com os inputs -->
                    <div style="height: 24px;"></div>
                    <button type="button" class="btn btn-info w-100"
                            onclick="window.location.href='<%=request.getContextPath()%>/lt_sis_busc/?fun=novo';">
                        CANCELAR
                    </button>
                </div>
                <div class="col-6 col-md-3 mb-2 mb-md-0">
                    <!-- Espaçador invisível para alinhar com os inputs -->
                    <div style="height: 24px;"></div>
                    <button type="button" class="btn btn-success w-100"
                            onclick="salvar_dado();">
                        SALVAR
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Fim Cabecalho Proposta -->	
	
	
	
	
	
	
	
	
					<div class="container mt-md-3">
					<!-- Inicio Container -->



<!-- Inicio row -->
<div class="row align-items-center text-center text-md-left">
    
    <!-- Coluna única englobando o input-group -->
    <div class="col-12 mb-2 mb-md-0 align-self-center text-center">
        
   </div>
<!-- FIM row -->

<c:if test="${not empty naoexitedado and naoexitedado eq 'true'}">						
<div>
  <hr>
  <!-- Versão Desktop (linha única) -->
  <p class="mensagem-desktop">Registro não localizado. Informe um CPF ou CNPJ válido para prosseguir com o cadastro</p>

  <!-- Versão Mobile (múltiplas linhas) -->
  <p class="mensagem-mobile">
    Registro não localizado.<br>
    Informe CPF ou CNPJ<br>
    válido para prosseguir com o cadastro.
  </p>
  <hr>
</div>
</c:if>





					<!-- FIM row -->
					<!-- FIM Container -->
				</div>
			<!-- FIM Container -->
			<!--  -->
</div>



	

			<!-- INICIO DADO -->
			

<div class="container mt-3">
    <div class="row align-items-center text-center text-md-start">
        
        <!-- Coluna Esquerda: Busca -->
        <div class="col-12 col-md-3 mb-2 mb-md-0">
                    <label id="l_bus_cnpj_cpf" data-placeholder="CNPJ / CPF" for="bus_cnpj_cpf"></label>
        
            <div class="input-group" >
                <!-- Alterado onfocus para chamar a nova função com confirmação -->
               <input class="form-control" list="list_cnpj_cpf"
    name="bus_cnpj_cpf" id="bus_cnpj_cpf"
    onfocus="perguntarSeDesejaLimpar()"
    oninput="handleBusca(this);"
    placeholder="CNPJ, CPF ou Nome" value="${pre_glo.cnpj_cpf}">
    
              
    

                <datalist id="list_cnpj_cpf">
                    <c:forEach items="${sis_cons}" var="l_cnpj_cpf">
                        <option value="${l_cnpj_cpf.cnpjCpf}">${l_cnpj_cpf.nomeDesc}</option>
                    </c:forEach>
                </datalist>

                <button onclick="sis_busc();" id="buc_dado" type="button" class="btn btn-outline-secondary" title="Buscar">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                    </svg>
                </button>
            </div>
        </div>

        <!-- Coluna Direita: Nome -->

        <div id="div_nome_desc" class="col-12 col-md-9 mb-2 mb-md-0">
        <c:if test="${not empty cons_true and cons_true eq 'true'}">
                <div id="div_nome_cliente">
            <label id="l_nome_desc" data-placeholder="Nome" for="nome_desc"></label>
            <textarea class="form-control" autocomplete="off"
                name="nome_desc" id="nome_desc"
                placeholder="Nome" rows="1"
                style="overflow: hidden; resize: none; line-height: 1.5;"
                >${pre_glo.nome_desc}</textarea>
        </div>
        </c:if>
</div>
<c:if test="${not empty cons_true and cons_true eq 'true'}">

<c:if test="${not empty insc_ocult and insc_ocult eq 'true'}">
						
												<!-- coluna Direita -->
						<div id="div_no_fan"
							class="col-12 col-md-12 mt-3 mb-2 mb-0 align-self-center text-center">
							<label id="l_no_fan" data-placeholder="Nome Fantasia"></label>
							<textarea class="form-control" name="no_fan" id="no_fan"
								autocomplete="off" placeholder="Nome Fantasia" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_glo.no_fan}</textarea>

						</div>
						<!-- coluna Direita -->
					</c:if>
					</c:if>
				
    </div>
    
    <!-- Mensagem de erro -->
    <div class="row mt-1">
        <div class="col-12">
            <small id="erro_busca" class="text-danger d-none">Dado inválido</small>
        </div>
    </div>
</div>

<script>
    let modalAberto = false; // Evita que o onfocus dispare o modal múltiplas vezes

    function mostrarModalConfirmacao() {
        return new Promise((resolve) => {
            const modal = document.getElementById('modalConfirmar');
            const btnSim = document.getElementById('btnSim');
            const btnNao = document.getElementById('btnNao');

            modal.style.display = 'flex';
            modalAberto = true;

            const handlerSim = () => {
                modal.style.display = 'none';
                modalAberto = false;
                btnSim.removeEventListener('click', handlerSim);
                btnNao.removeEventListener('click', handlerNao);
                resolve(true);
            };
            
            const handlerNao = () => {
                modal.style.display = 'none';
                modalAberto = false;
                btnSim.removeEventListener('click', handlerSim);
                btnNao.removeEventListener('click', handlerNao);
                resolve(false);
            };

            btnSim.addEventListener('click', handlerSim);
            btnNao.addEventListener('click', handlerNao);
        });
    }

    async function perguntarSeDesejaLimpar() {
        const campoBusca = document.getElementById('bus_cnpj_cpf');
        
        // Se o modal já estiver aberto ou o campo já estiver vazio, não faz nada
        if (modalAberto || !campoBusca || campoBusca.value.trim() === '') {
            return;
        }

        const confirmar = await mostrarModalConfirmacao();

        if (confirmar) {
            // 1. Limpa o campo de busca
            campoBusca.value = '';

            // 2. Força a atualização do oninput (para remover bordas de erro e habilitar botão)
            campoBusca.dispatchEvent(new Event('input'));

            // 3. Limpa os demais campos com segurança
            const idsParaLimpar = ['nome_desc', 'ins_est', 'ins_mun', 'no_fan', 'end_rua', 'end_num', 'end_com', 'end_uf', 'end_cep', 'obs', 'tel_1', 'email_1', 'tel_2', 'email_2'];
            idsParaLimpar.forEach(id => {
                const el = document.getElementById(id);
                if (el) {
                    el.value = '';
                    el.dispatchEvent(new Event('input')); // Ajusta altura de textareas e labels
                }
            });

            // 4. Esconde as divs
            ['div_nome_cliente','div_no_fan', 'div_dado_cliente', 'div_contado','div_dado_Aba', 'erro_busca'].forEach(id => {
                const el = document.getElementById(id);
                if (el) el.classList.add('d-none');
            });

            // 5. GARANTIA DO DATALIST: Não fazemos nenhuma manipulação complexa.
            // Apenas verificamos se o atributo está lá. O navegador mantém as opções vivas.
            if (campoBusca.getAttribute('list') !== 'list_cnpj_cpf') {
                campoBusca.setAttribute('list', 'list_cnpj_cpf');
            }

            // 6. Devolve o foco ao campo
            setTimeout(() => {
                campoBusca.focus();
            }, 100);

        } else {
            // Se clicou em NÃO, tira o foco para não ficar perguntando em loop
            campoBusca.blur();
        }
    }

    function adjustHeight(el) {
        if (!el) return;
        el.style.height = 'auto';
        const lineHeight = parseFloat(getComputedStyle(el).lineHeight) || 24;
        const maxLines = 3;
        const maxHeight = lineHeight * maxLines;

        if (el.scrollHeight > maxHeight) {
            el.style.height = maxHeight + 'px';
            el.style.overflowY = 'auto';
        } else {
            el.style.height = el.scrollHeight + 'px';
            el.style.overflowY = 'hidden';
        }
    }
    
    document.addEventListener("DOMContentLoaded", function() {
        const textarea = document.getElementById('nome_desc');
        if (textarea) adjustHeight(textarea);
    });
</script>

<c:if test="${not empty cons_true and cons_true eq 'true'}">
<div id="div_dado_cliente">


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
						<div class="col-12 col-md-6 mb-2 mb-0 align-self-end text-center">

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
							<label id="l_tel_1" data-placeholder="Whatshapp"></label> 
							<input
								type="text" maxlength="20" name="tel_1" id="tel_1"
								autocomplete="off" class="form-control" placeholder="Whatshapp"
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
							<label id="l_email_1" data-placeholder="E-mail envio Nota Fiscal"></label>
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

	</div>	



<div id="div_contado">	
<!-- Inico Contado-->
<c:if test="${not empty tab_cont_ocult and tab_cont_ocult eq 'true'}">
<
<!-- Ocultar Inico Contado-->
		<!-- Inicio Container -->
				<div class="container mt-1">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left g-1">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div  id="div_textarea_cont"
							class="col-12 col-md-8 mb-2 mb-0 align-self-center text-center" <c:if test="${empty cont_list}"> style="display:none;" </c:if>>
	
	
 							
							
							
							<textarea name="cont_bus_cont" id="cont_bus_cont" class="form-control"
								placeholder="Busca Contado" autocomplete="off" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';"></textarea>
 	
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div id="div_botao_cont"
							class="col-12 col-md-2 mb-2 align-self-center text-center text-md-start" <c:if test="${empty cont_list}"> style="display:none;" </c:if>>
							
				<button onclick="bus_p1();" class="btn btn-success"
						type="button" id="busc_cont"   >Buscar Contado</button>
			 			
						
						</div>

						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-2 mb-2 text-center text-md-start">
<!--  -->

	<!-- Button trigger modal -->
<button type="button" class="btn btn-primary rounded-pill px-4" style="white-space: nowrap;" onclick="limpar_modal_contato()" data-bs-target="#adi_cont">
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
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';"></textarea>
								
							
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
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';"></textarea>
							
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
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';"></textarea>
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
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';"></textarea>
							
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
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';"></textarea>
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
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';"></textarea>

	
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
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';"></textarea>
				
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
				<div id="div_tabela_cont" class="container mt-1" <c:if test="${empty cont_list}"> style="display:none;" </c:if>>
 
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
            document.getElementById('bus_cnpj_cpf');

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

</div>




<!-- Inicio ABA  -->

<div id="div_dado_Aba">	
<!--  -->
<!-- Inicio Container -->
<div class="container mt-3">
	<!-- Inicio Container -->
	<!-- Inicio row -->
	<div class="row align-items-center text-center text-md-left">
		<!-- Inicio row -->

<!-- INICIO DADO ABA -->


<ul class="nav nav-tabs" id="myTab" role="tablist">
	<li class="nav-item" role="presentation">
		<button class="nav-link active" id="dados-tab" data-bs-toggle="tab"
			data-bs-target="#dados" type="button" role="tab">Dado
			Adicional</button>
	</li>

	<li class="nav-item" role="presentation">
		<button class="nav-link" id="financeiro-tab" data-bs-toggle="tab"
			data-bs-target="#financeiro" type="button" role="tab">
			Financeiro</button>
	</li>

	<li class="nav-item" role="presentation">
		<button class="nav-link" id="endereco-tab" data-bs-toggle="tab"
			data-bs-target="#endereco" type="button" role="tab">
			Endereço de Envio</button>
	</li>

</ul>


<div class="tab-content border border-top-0 p-3" id="myTabContent">

	<!-- DADO ADICIONAL -->
	<div class="tab-pane fade show active" id="dados" role="tabpanel"
		aria-labelledby="dados-tab">

		<div class="row align-items-center text-center text-md-left">

<c:if test="${not empty insc_ocult and insc_ocult eq 'true'}">

<fieldset class="border rounded p-3">

    <legend class="float-none w-auto px-2 text-start fs-6">
        Consultar na Receita Federal
    </legend>
    		<div class="row align-items-center text-center text-md-left">
    
			<div class="col-12 col-md-5 mb-2 mb-0 align-self-center text-center">
				<label id="l_tel_2" data-placeholder="Telefone"></label> <input
					type="text" maxlength="20" name="tel_2" id="tel_2"
					autocomplete="off" class="form-control" placeholder="Telefone"
					value="${pre_glo_ad.tel_2}">
			</div>

			<div class="col-12 col-md-7 mb-2 mb-0 align-self-center text-center">
				<label id="l_email_2" data-placeholder="E-mail"></label>
				<textarea name="email_2" id="email_2" class="form-control"
					placeholder="E-mail" autocomplete="off" rows="1"
					style="overflow: hidden; resize: none;"
					oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_glo_ad.email_2}</textarea>

			</div>
			</div>
</fieldset>
						</c:if>

<c:if test="${empty insc_ocult or insc_ocult eq 'false'}">
    		<div class="row align-items-center text-center text-md-left">
    
			<div class="col-12 col-md-5 mb-2 mb-0 align-self-center text-center">
				<label id="l_tel_2" data-placeholder="Telefone"></label> <input
					type="text" maxlength="20" name="tel_2" id="tel_2"
					autocomplete="off" class="form-control" placeholder="Telefone"
					value="${pre_glo_ad.tel_2}">
			</div>

			<div class="col-12 col-md-7 mb-2 mb-0 align-self-center text-center">
				<label id="l_email_2" data-placeholder="E-mail"></label>
				<textarea name="email_2" id="email_2" class="form-control"
					placeholder="E-mail" autocomplete="off" rows="1"
					style="overflow: hidden; resize: none;"
					oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_glo_ad.email_2}</textarea>

			</div>
			</div>

</c:if>
		</div>

	</div>


	<!-- FINANCEIRO -->
	<div class="tab-pane fade" id="financeiro" role="tabpanel"
		aria-labelledby="financeiro-tab">

		<div class="row">

			<div class="col-md-6 mb-3">
				<label for="chave_pix" class="form-label"> Em Contrução </label> <input
					type="text" class="form-control" id="chave_pix" name="chave_pix"
					placeholder="Em Contrução">
			</div>

			<div class="col-md-6 mb-3">
				<label for="nome_pix" class="form-label"> Em Contrução </label> <input
					type="text" class="form-control" id="nome_pix" name="nome_pix"
					placeholder="Em Contrução">
			</div>

		</div>

	</div>


	<!-- ENDEREÇO DE ENVIO -->
	<div class="tab-pane fade" id="endereco" role="tabpanel"
		aria-labelledby="endereco-tab">

		<div class="row">

			<div class="col-md-8 mb-3">
				<label for="endereco_completo" class="form-label"> Em Contrução
					</label> <input type="text" class="form-control"
					id="endereco_completo" name="endereco_completo"
					placeholder="Em Contrução">
			</div>

			<div class="col-md-4 mb-3">
				<label for="cep" class="form-label"> Em Contrução </label> <input type="text"
					class="form-control" id="cep" name="cep" placeholder="Em Contrução"
					maxlength="9">
			</div>

		</div>

	</div>

</div>
</div>

<!-- FIM DADO ABA -->

		<!-- FIM row -->
	</div>
	<!-- FIM Container -->
</div>
<!-- FIM Container -->
<!--  -->
				<!-- FIM Ocultar-->
			</c:if>
			<!-- FIM Ocultar -->









<!-- INICIO CONSULTAR DADO CLIENTE -->
<c:if test="${empty list_cons_ocult or list_cons_ocult eq 'true'}">
<!-- INICIO CONSULTAR DADO CLIENTE -->
			<!--  -->
			<!-- Inicio Container -->
				<div class="container mt-3">
					<!-- Inicio Container -->
<hr>					
<!-- INICIO CONSULTAR DADO  -->

				<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left">
	
<a>Cliente Encontrado</a>
					<!-- FIM row -->
					</div>



<!--Inico Tabela Consultar Cliente Pelo Nome -->
<!-- Inicio Container -->
<div class="container mt-1">
	<!-- Inicio Container -->

	<div style="height: 350px; overflow: scroll;">
	<table class="table" id="t_list_cons">
    <thead>
        <tr>
            <th scope="col">CNPJ ou CPF</th>
            <th scope="col">Nome</th>
            <th scope="col">Nome Fantasia</th>
            <th scope="col">Selecionar</th>
        </tr>
    </thead>
   <tbody>
    <!-- Verifica se a lista existe e não está vazia no escopo da requisição -->
    <c:choose>
        <c:when test="${not empty requestScope.list_cons_dado}">
            <c:forEach items="${requestScope.list_cons_dado}" var="ml">
                <tr>
                    <td><c:out value="${ml.cnpj_cpf}" /></td>
                    <td><c:out value="${ml.nome_desc}" /></td>
                    <td><c:out value="${ml.no_fan}" /></td>
                    <td>
                        <a onclick="sel_cons('${ml.cnpj_cpf}', this); return false;" 
                           class="btn btn-warning text-dark">
                           Selecionar
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <tr>
                <td colspan="4" class="text-center text-muted">
                    Nenhum registro encontrado ou tipo de dados inválido.
                </td>
            </tr>
        </c:otherwise>
    </c:choose>
</tbody></table>

	</div>
	<hr>

<!-- 
/* =====================================================
INICIO PAGINAÇÃO cons
===================================================== */
-->
<div id="paginacao_cons"
class="d-flex align-items-center justify-content-center flex-wrap mt-2">

<!-- PAGINAÇÃO -->
<span id="pag_cons"
class="d-flex align-items-center">
</span>

<!-- SEPARADOR -->
<span class="text-secondary mx-2">|</span>

<!-- INFORMAÇÃO -->
<span id="info_cons"
class="text-secondary">
</span>

</div>
<script type="text/javascript">

/* ===================================================== 
INICIO PAGINAÇÃO SCRIPT CONS
===================================================== */

/* =====================================================
CONFIGURAÇÃO
===================================================== */

// CORREÇÃO 1: Garante que sempre será um número, evitando erro de sintaxe no JS.
// Se 'cons_list_qt' for um número inteiro direto no Java, use apenas: ${empty cons_list_qt ? 0 : cons_list_qt}
var totalRegistroscons = ${not empty cons_list_qt ? cons_list_qt : 0}; 
var paginaAtualcons = 1;
var registrosPorPaginacons = 5;

/* =====================================================
ATUALIZA INFORMAÇÃO
===================================================== */
function atualizarInfocons(pagina) {
var registrosPorPagina = registrosPorPaginacons;
var totalRegistros = totalRegistroscons || 0;
var infocons = document.getElementById("info_cons");

if (totalRegistros === 0) {
infocons.innerHTML = "0 - 0 de 0";
return;
}

var inicio = ((pagina - 1) * registrosPorPagina) + 1;
var fim = pagina * registrosPorPagina;

if (fim > totalRegistros) {
fim = totalRegistros;
}

infocons.innerHTML = inicio + " - " + fim + " de " + totalRegistros;
}

/* =====================================================
MONTA PAGINAÇÃO
===================================================== */
function montarPaginascons(paginaAtual) {
var registrosPorPagina = registrosPorPaginacons;
var totalRegistros = totalRegistroscons || 0;
var totalPaginas = Math.ceil(totalRegistros / registrosPorPagina);
var html = "";

if (totalPaginas === 0) {
document.getElementById("pag_cons").innerHTML = "";
return;
}

// Botão Primeira
if (paginaAtual === 1) {
html += '<button type="button" class="btn btn-light border rounded-3 px-3 py-2" disabled>Primeira</button>';
} else {
html += '<button type="button" class="btn btn-light border rounded-3 px-3 py-2" onclick="carregarPaginacons(1)">Primeira</button>';
}

html += '<span class="text-secondary mx-2">|</span>';

// Define as páginas visíveis
var inicio, fim;

if (totalPaginas <= 3) {
inicio = 1;
fim = totalPaginas;
} else {
inicio = paginaAtual - 1;
fim = paginaAtual + 1;

if (paginaAtual <= 2) {
inicio = 1;
fim = 3;
}
if (paginaAtual >= totalPaginas - 1) {
inicio = totalPaginas - 2;
fim = totalPaginas;
}
}

// Números das páginas
for (var pagina = inicio; pagina <= fim; pagina++) {
if (pagina === paginaAtual) {
html += '<button type="button" class="btn btn-primary rounded-3 px-3 py-2 mx-1" disabled>' + pagina + '</button>';
} else {
html += '<button type="button" class="btn btn-light border rounded-3 px-3 py-2 mx-1" onclick="carregarPaginacons(' + pagina + ')">' + pagina + '</button>';
}
}

document.getElementById("pag_cons").innerHTML = html;
}

/* =====================================================
CARREGA A PÁGINA (AJAX)
===================================================== */
function carregarPaginacons(pagina) {
paginaAtualcons = pagina;

// CORREÇÃO 2: Trocado de 'dom' para 'cons'
atualizarInfocons(pagina); 
montarPaginascons(pagina); 

var registrosPorPagina = registrosPorPaginacons;
var offset = (pagina - 1) * registrosPorPagina;

var urlAction = '<%=request.getContextPath()%>/lt_sis_busc/?fun=pag_cons';
var cons = document.getElementById('bus_cnpj_cpf').value;

$.ajax({
type: "POST",
url: urlAction,
data: {
offset: offset,
cons : cons
},
success: function(response) {
$("#t_list_cons tbody").html(response);
},
error: function(xhr, status, error) {
console.log(xhr.responseText);
alert("Erro ao carregar página cons: " + error);
}
});
}

/* =====================================================
INICIALIZAÇÃO
===================================================== */
atualizarInfocons(1);
montarPaginascons(1);

</script>

<!-- 
/* =====================================================
FIM PAGINAÇÃO CONS
===================================================== */
-->










	<!-- FIM Container -->
</div>
<!-- FIM Container -->
<!-- Fim Consultar Cliente Pelo Nome -->





<!-- FIM CONSULTAR DADO -->
					<!-- coluna Direita -->
<hr>
					<!-- FIM Container -->
				</div>
			<!-- FIM Container -->
			<!--  -->
<!-- FIM CONSULTAR DADO CLIENTE -->
</c:if>
<!-- FIM CONSULTAR DADO CLIENTE -->
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

<div id="modalConfirmar" class="modal-overlay">
  <div class="modal-box">
    <p class="modal-texto">Deseja selecionar outro Cliente?</p>
    <div class="modal-botoes">
      <button id="btnSim" class="btn btn-sim">Sim</button>
      <button id="btnNao" class="btn btn-nao">Não</button>
    </div>
  </div>
</div>

	<!-- ====== SCRIPT PRINCIPAL ====== -->
	<script type="text/javascript">
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

    // Inicializa apenas os labels, SEM adicionar listeners conflitantes
    document.addEventListener('DOMContentLoaded', () => {
        initLabels();
    });
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