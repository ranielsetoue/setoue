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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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
<c:set scope="session" var="aces_dev" value="${sessionScope.aces_dev}" />

<!--  -->
<title>${h_titulo_web}</title>


<!--  -->
</head>
<body>

	<%@ include file="/00_controle/00_sistema/Layout/cabecalho.jsp" %>

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