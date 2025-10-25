<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Favicon -->
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/desenho/logo.png" type="image/x-icon">
    
    <title>Login</title>
</head>
<body>

<!-- ===== Formulário Login ===== -->
<form method="post" action="<%=request.getContextPath()%>/lt_sis_log/" onsubmit="return validardados()">
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
                    <input class="form-control" placeholder="Login Usuario" type="text" name="l_usu" id="l_usu" autocomplete="off" value="set">
                </div>

                <div class="col-12 col-md-5 mb-2 mb-md-0">
                    <input class="form-control" placeholder="Login Senha" type="text" name="l_sen" id="l_sen" autocomplete="off" value="12">
                </div>

                <div class="col-12 col-md-2 mb-2 mb-md-0">
                    <button type="submit" class="btn btn-success">Logar</button>
                </div>
            </div>
        </div>
    </div>
</form>

<!-- ===== Formulário Recuperar Senha ===== -->
<form id="formUserA" method="post" action="<%=request.getContextPath()%>/serv_recup_senha" onsubmit="return validardados()">
    <div class="container-fluid mt-3 px-4">
        <div class="container mt-3">
            <div class="row align-items-center text-center text-md-left">
                
                <div class="col-12 col-md-5 mb-2 mb-md-0 d-flex justify-content-md-start justify-content-center align-items-center">
                    <input type="hidden" name="recuperar_senha" id="recuperar_senha" value="">
                    <button type="button" class="btn btn-light" onclick="recuperarsenha();">Recuperar Senha</button>
                </div>

                <div class="col-12 col-md-5 mb-2 mb-md-0 text-center"></div>
                <div class="col-12 col-md-2 mb-2 mb-md-0 text-center"></div>

            </div>
        </div>
    </div>
</form>

<!-- ===== Scripts ===== -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
