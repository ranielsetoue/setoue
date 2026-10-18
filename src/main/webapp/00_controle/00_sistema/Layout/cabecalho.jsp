<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <!-- Importando o CSS externo -->
<c:set var="l_css" value="${pageContext.request.contextPath}/00_controle/00_sistema/Layout"/>
<link rel="stylesheet" href="${l_css}/css/botao.css">

<!-- ===== INÍCIO DO CABEÇALHO (Fragmento) ===== -->
<div class="container-fluid mt-3 px-4">
	<div class="container">
		<div class="row align-items-center text-center text-md-center">

			<!-- Coluna Esquerda: Logo -->
			<div class="col-12 col-md-2 align-self-center align-items-center">
				<img height="100" width="200"
					src="<%=request.getContextPath()%>/desenho/logo.png" alt="Logo"
					class="img-fluid">
			</div>

			<!-- Coluna Central: Título -->
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

			<!-- Coluna Direita: Usuário e Logout -->
			<div
				class="col-12 col-md-3 d-flex justify-content-center justify-content-md-end align-items-center">
				<table>
					<tr>
						<td class="pl-2"><span>Usuario: </span> <c:if
								test="${not empty sessionScope.usu_html}">
                                ${sessionScope.usu_html}
                            </c:if></td>
						<td><a
							href="<%=request.getContextPath()%>/lt_sis_log/?f_out_log=f_out_log">
								<button type="button" class="btn btn-warning btn-sm">logout</button>
						</a></td>
					</tr>
				</table>
			</div>
		</div>
	</div>

	<!-- ===== INÍCIO DO MENU DE NAVEGAÇÃO ===== -->
	<div class="container mt-3">
		<div class="row align-items-center text-center text-md-left">
			<div class="col-12 col-md-12 text-start">


				<!-- Botão Cadastro -->
				<div class="btn-group me-2" role="group">
				<c:if test="${aces_ven_pro}">
					<button id="btnGroupDropCad" type="button"
						class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"
						aria-expanded="false">Cadastro</button>
					<ul class="dropdown-menu" aria-labelledby="btnGroupDropCad">
						<c:if test="${aces_cad_sis}">
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/lt_sis/?fun=cad_sis">SISTEMA</a></li>
						</c:if>
						<c:if test="${aces_cad_clin}">
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/lt_sis/?fun=cad_cli">CLIENTE</a></li>
						</c:if>
						<c:if test="${aces_cad_forn}">
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/lt_sis/?fun=cad_for">FORNECEDOR</a></li>
						</c:if>
						<c:if test="${aces_cad_prod}">
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/lt_sis/?fun=cad_pro">PRODUTO</a></li>
						</c:if>
						<c:if test="${aces_cad_serv}">
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/lt_sis/?fun=cad_serv">SERVICO</a></li>
						</c:if>
					</ul>
					</c:if>
				</div>

				<!-- Botão Venda -->
				<div class="btn-group me-2" role="group">
					<c:if test="${aces_ven_pro}">
					<button id="btnGroupDropVen" type="button"
						class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"
						aria-expanded="false">Venda</button>
					<ul class="dropdown-menu" aria-labelledby="btnGroupDropVen">
						<c:if test="${aces_ven_cons_pro}">
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/lt_sis/?fun=ven_cons_pro">Consultar
									Proposta</a></li>
						</c:if>
						<c:if test="${aces_ven_pro}">
				<c:if test="${aces_ven_pro_cons}">
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/lt_sis/?fun=ven_pro">Incluir
									Proposta</a></li>
										</c:if>
							</c:if>
						<c:if test="${aces_ven_orde}">
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/lt_sis/?fun=ven_orde">Ordem
									de Serviço</a></li>
						</c:if>
						<c:if test="${aces_ven_orc}">
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/lt_sis/?fun=ven_orc">Orçamento</a></li>
						</c:if>
					</ul>
					</c:if>
				</div>

				<!-- Botão TESTE -->
					<c:if test="${aces_ven_pro}">
				<c:if test="${aces_dev}">
					<div class="btn-group" role="group">
				
						<button id="btnGroupDropTeste" type="button"
							class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown"
							aria-expanded="false">DEV</button>
						<ul class="dropdown-menu" aria-labelledby="btnGroupDropTeste">
													<li><a class="dropdown-item"
						href="<%=request.getContextPath()%>/00_controle/devset/cadastro/cert_pdf.jsp">Certificado PDF</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/00_controle/devset/cadastro/pad_pdf.jsp">Padrão PDF</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/00_controle/devset/treinamento/treinamento.html">treinamento</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/00_controle/Investimento/daytrade.html">DayTrade</a></li>
						
						</ul>
					</div>
				</c:if>
</c:if>
			</div>
		</div>
	</div>
</div>

<!-- ===== FIM DO CABEÇALHO ===== -->