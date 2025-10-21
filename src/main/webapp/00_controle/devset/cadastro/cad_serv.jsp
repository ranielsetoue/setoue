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


<title>Cadastro de Serviço</title>


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
					<hr>
					<!-- coluna esquerda -->
					<div
						class="col-12  col-md-5 mb-2 mb-md-0 align-self-center align-items-center">
								<hr>

		<div class="btn-group" role="group">
			<button id="btnGroupDrop1" type="button" class="btn btn-primary"
				data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				Cadastro</button>
		<div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
								<a class="dropdown-item"
									href="<%=request.getContextPath()%>/00_controle/devset/controle.jsp">PAGINA
									INICIAL</a> <a class="dropdown-item"
									href="<%=request.getContextPath()%>/00_controle/devset/cadastro/cad_sis.jsp">
									SISTEMA</a> <a class="dropdown-item"
									href="<%=request.getContextPath()%>/00_controle/devset/cadastro/cad_cli.jsp">CLIENTE</a>
								<a class="dropdown-item"
									href="<%=request.getContextPath()%>/00_controle/devset/cadastro/cad_for.jsp">FORNECEDOR</a>
								<a class="dropdown-item"
									href="<%=request.getContextPath()%>/00_controle/devset/cadastro/cad_pro.jsp">PRODUTO</a>
								<a class="dropdown-item"
									href="<%=request.getContextPath()%>/00_controle/devset/cadastro/cad_serv.jsp">SERVICO</a>
				</div>
		</div>
						
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