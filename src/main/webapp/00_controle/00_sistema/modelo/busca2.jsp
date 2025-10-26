<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<title>Busca de Sistemas</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body>

<!-- Formulário de login -->
<form id="formLogin" method="post" action="<%=request.getContextPath()%>/lt_sis_log/" onsubmit="return validardadosLogin()">
    <div class="container-fluid mt-3 px-4">
        <div class="container">
            <div class="row align-items-center text-center text-md-left">

                <!-- Coluna esquerda: logo -->
                <div class="col-12 col-md-2 align-self-center">
                    <img height="200" width="400" src="<%=request.getContextPath()%>/desenho/logo.png" alt="Logo" class="img-fluid">
                </div>

                <!-- Coluna central: título -->
                <div class="col-12 col-md-7 mb-2 mb-md-0 align-self-center text-center">
                    <c:choose>
                        <c:when test="${empty h_titulo_pagina}">
                            <h3>SET DEV</h3>
                        </c:when>
                        <c:otherwise>
                            <h3>${h_titulo_pagina}</h3>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Coluna direita: usuário e logout -->
                <div class="col-12 col-md-3 d-flex justify-content-center justify-content-md-end align-items-center">
                    <table style="display:none;">
                        <tr>
                            <td class="pl-2">
                                <a>Usuario: </a>
                                <c:if test="${not empty sessionScope.usu_html}">
                                    ${sessionScope.usu_html}
                                </c:if>
                            </td>
                            <td>
                                <a href="<%=request.getContextPath()%>/lt_sis_log/?f_out_log=f_out_log">
                                    <button type="button" class="btn btn-warning">Logout</button>
                                </a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <!-- Campos login -->
        <div class="container mt-3">
            <div class="row align-items-center text-center text-md-left">

                <div class="col-12 col-md-5 mb-2 mb-md-0">
                    <input class="form-control" placeholder="Login Usuario" type="text" name="l_usu" id="l_usu" autocomplete="off" value="setran">
                </div>

                <div class="col-12 col-md-5 mb-2 mb-md-0">
                    <input class="form-control" placeholder="Login Senha" type="text" name="l_sen" id="l_sen" autocomplete="off" value="1234">
                </div>

                <div class="col-12 col-md-2 mb-2 mb-md-0">
                    <button type="submit" class="btn btn-success">Logar</button>
                </div>
            </div>
        </div>
    </div>
</form>

<!-- Formulário de busca -->
<div class="container mt-4">
    <h2>Busca de Sistemas</h2>

    <form id="formBusca" method="post" action="<%=request.getContextPath()%>/lt_dev/" class="mb-3">
        <input type="hidden" name="fun" id="fun" value="" />

        <label for="termo" class="form-label">Digite o nome, CPF/CNPJ ou ID:</label>
        <input type="text" name="termo" id="termo" class="form-control" value="${param.termo}" placeholder="Ex: Raniel Assis Setoue">

        <button type="button" class="btn btn-primary mt-2" onclick="enviarForm('buscar_dado')">Buscar</button>
        <button type="button" class="btn btn-secondary mt-2" onclick="enviarForm('pg_ini')">Página Inicial</button>
    </form>

    <hr />

    <!-- Resultados -->
    <c:if test="${not empty listaResultados}">
        <h4>Resultados encontrados: ${fn:length(listaResultados)}</h4>
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Nome</th>
                    <th>CPF/CNPJ</th>
                    <th>Data Cadastro</th>
                    <th>Nome Fantasia</th>
                    <th>Endereço</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${listaResultados}">
                    <tr>
                        <td>${item.nome_desc}</td>
                        <td>${item.cnpj_cpf}</td>
                        <td><fmt:formatDate value="${item.reg_data}" pattern="dd/MM/yyyy HH:mm:ss" /></td>
                        <td>${item.no_fan}</td>
                        <td>${item.end_rua}, ${item.end_num} ${item.end_com}, ${item.end_bar} - ${item.end_mun}/${item.end_uf} CEP: ${item.end_cep}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty listaResultados}">
        <div class="alert alert-warning">Nenhum registro encontrado.</div>
    </c:if>
</div>

<script type="text/javascript">
    function enviarForm(funcao) {
        if (!validardados()) return false; // chama sua validação
        document.getElementById('fun').value = funcao; // define o parâmetro fun
        document.getElementById('formBusca').submit(); // envia o formulário
    }

    function validardados() {
        // exemplo de validação simples
        var termo = document.getElementById('termo').value.trim();
        if (termo === "") {
            alert("Digite algum valor para buscar.");
            return false;
        }
        return true;
    }

    function validardadosLogin() {
        var login = document.getElementById('l_usu').value.trim();
        var senha = document.getElementById('l_sen').value.trim();
        if (login === "" || senha === "") {
            alert("Preencha usuário e senha.");
            return false;
        }
        return true;
    }
</script>

</body>
</html>
