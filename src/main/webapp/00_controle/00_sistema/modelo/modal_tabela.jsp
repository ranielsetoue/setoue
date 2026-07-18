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
<title>${h_titulo_web}</title>


<script type="text/javascript">

	function sav_cont() {


			if (document.getElementById("cont_tipo_ace").value == '' && document.getElementById("cont_l_usu").value !== ''
		
		) {
			alert('Preencher Dado');
		} else {
		
		
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


		                // ✅ FECHA O MODAL
		                const modalEl = document.getElementById('adi_cont');
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
	
	}

	
	function limpar_modal_contato() {
		document.getElementById('adi_cont')?.addEventListener('show.bs.modal', function () {
			  this.querySelectorAll('input, textarea, select').forEach(campo => {
			    if (campo.type !== 'button' && campo.type !== 'submit') {
			      campo.value = '';
			    }
			  });
			});
		}
	
	
	
	</script>


<!--  -->
</head>
<body>

	<!-- ----- inicio body -->
	<!--  -->
<!-- Inico Contado-->
			<!--  -->
			<!-- Inicio Container -->
				<div class="container mt-1">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div class="row align-items-center text-center text-md-left g-1">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div
							class="col-12 col-md-8 mb-2 mb-0 align-self-center text-center">
							
							
							<textarea name="cont_bus_cont" id="cont_bus_cont" class="form-control"
								placeholder="Busca Contado" autocomplete="off" rows="1"
								style="overflow: hidden; resize: none;"
								oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';"></textarea>
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div
							class="col-12 col-md-2 mb-2 align-self-center text-center text-md-start">
				<button onclick="bus_p1();" class="btn btn-success"
						type="button" id="button-addon2">Buscar Contado</button>
							
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12 col-md-2 mb-2 text-center text-md-start">
<!--  -->
	<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" onclick="limpar_modal_contato()" data-bs-toggle="modal" data-bs-target="#adi_cont">
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
<hr>
																		<label id="l_cont_l_usu" data-placeholder="Usuario para Login"></label>
													<textarea name="cont_l_usu" id="cont_l_usu"
														class="form-control" placeholder="Usuario para Login"
														autocomplete="off" rows="1"
														style="overflow: hidden; resize: none;"
														oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_cont.l_usu}</textarea>
									
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div
							class="col-12  mb-2 align-self-center text-center">
																<label id="l_cont_l_sen" data-placeholder="Senha para Login"></label>
													<textarea name="cont_l_sen" id="cont_l_sen"
														class="form-control" placeholder="Senha para Login"
														autocomplete="off" rows="1"
														style="overflow: hidden; resize: none;"
														oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_cont.l_sen}</textarea>

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
					<label id="l_cont_tipo_ace" data-placeholder="Autorização de Acesso"></label>						
				<input class="form-control" list="list_cont_tipo_ace" value="${pre_dom.ace_per_aut}"
								name="cont_tipo_ace" id="cont_tipo_ace" placeholder="Autorização de Acesso"
								onblur="validarcontTipoSite()"
								>

							<datalist id="list_cont_tipo_ace">
								<c:forEach items="${sis_cons_tip_ace}" var="t_tipo_ace">
									<option value="${t_tipo_ace.nomeDesc}"></option>
								</c:forEach>
							</datalist>
		<script>
function validarcontTipoSite() {
    const input = document.getElementById("cont_tipo_ace");
    const datalist = document.getElementById("list_cont_tipo_ace");
    const opcoescont = Array.from(datalist.options).map(o => o.value);

    if (input.value.trim() !== "" && !opcoescont.includes(input.value)) {
        input.value = "";
        alert("Selecione um valor válido da lista");
    }
}
</script>



					
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
	<hr>
					<!-- FIM Container -->
				</div>
			<!-- FIM Container -->
			<!--  -->
<!--Tabela Contado  -->
				<!-- Inicio Container -->
				<div class="container mt-1">
					<!-- Inicio Container -->
		<div style="height: 250px; overflow: scroll;">
			<table class="table" id="tb02">
				<thead>
					<tr>
						<th scope="col">Nome</th>
						<th scope="col">Deletar</th>
						<th scope="col">Editar</th>

					</tr>
				</thead>
				<tbody>
					<c:forEach items="${dom_list}" var="ml">
						<tr>
							<td><c:out value="${ml.no_dom}"></c:out></td>
							<td><a onclick="exc_don();"
								href="<%=request.getContextPath()%>/cad_sis?fun=exc_id_dom&id_dominio=${ml.id_sis_dom}"
								class="btn btn-danger">Excluir</a></td>
							<td><button type="button" id="adicionar_dom"
									onclick="edit_dom2('${ml.id_sis_dom}');edit_dom1('${ml.sis_url}');edit_dom('${ml.no_dom}');"
									class="btn btn-warning" data-bs-toggle="modal">Detalhes</button></td>

						</tr>

					</c:forEach>
				</tbody>
			</table>
		</div>
							<!-- FIM Container -->
				</div>
			<!-- FIM Container -->
			<!--  -->
		
<!-- Tabela Contado -->
			<!-- FIM DADO -->
<!-- FIM Contado -->




</body>

</html>