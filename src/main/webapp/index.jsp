<!doctype html>
<html lang="en">
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


<title>Login</title>


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
						<table style="display: none;">

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
						class="col-12  col-md-5 mb-2 mb-md-0 align-self-center align-items-center">
						<input class="form-control" placeholder="Login Usuario"
							type="text" name="l_usu" id="l_usu" autocomplete="off"
							value="setran">
					</div>
					<!-- coluna esquerda -->

					<!-- coluna Central -->

					<div
						class="col-12 col-md-5 mb-2 mb-md-0 align-self-center text-center">

						<input class="form-control" placeholder="Login Senha" type="text"
							name="l_sen" id="l_sen" autocomplete="off" value="1234">

					</div>
					<!-- coluna Central -->

					<!-- coluna Direita -->
					<div
						class="col-12 col-md-2 mb-2 mb-md-0 align-items-center align-self-center ">
						<button type="submit" class="btn btn-success">Logar</button>
					</div>
					<!-- coluna Direita -->
				</div>
			</div>
			<!-- Fim Container -->
			<!--  -->


			<!-- Borda -->
		</div>
		<!-- Borda -->
	</form>
<!-- fim form -->
<!-- inicio form -->
<form id="formUserA" method="post"
	action="<%=request.getContextPath()%>/serv_recup_senha"
	onsubmit="return validardados()? true : false">
	
	<div class="container-fluid mt-3 px-4">
		<!-- Inicio Container -->
		<div class="container mt-3">
			<div class="row align-items-center text-center text-md-left">
				
				<!-- Coluna Esquerda (fica à esquerda no desktop, em cima no celular) -->
			<div class="col-12 col-md-5 mb-2 mb-md-0 d-flex justify-content-md-start justify-content-center align-items-center">
					<input type="hidden" name="recuperar_senha" id="recuperar_senha" value="">
					<button type="button" class="btn btn-light" onclick="recuperarsenha();">
						Recuperar Senha
					</button>
				</div>

				<!-- Coluna Central -->
				<div class="col-12 col-md-5 mb-2 mb-md-0 align-self-center text-center">
					<!-- conteúdo central opcional -->
				</div>

				<!-- Coluna Direita -->
				<div class="col-12 col-md-2 mb-2 mb-md-0 align-self-center text-center">
					<!-- conteúdo direito opcional -->
				</div>

			</div>
		</div>
	</div>
</form>
<!-- fim form -->



	<!-- ---- fim body-->
	<!-- Optional JavaScript; choose one of the two! -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
		integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
		integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
	<!-- Option 1: Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>

	<!-- Option 2: Separate Popper and Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
		integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
		integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13"
		crossorigin="anonymous"></script>
</body>
</html>