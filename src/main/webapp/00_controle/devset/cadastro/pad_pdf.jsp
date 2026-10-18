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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Favicon (corrigido type="image/x-icon") -->
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/desenho/logo.png" type="image/x-icon">
    
    <title>${h_titulo_web}</title>

    <!-- Estilos personalizados para refinamento visual -->
    <style>
        body {
            background-color: #f4f6f9;
        }
        .card-upload {
            border: none;
            border-radius: 12px;
            overflow: hidden;
        }
        .card-header {
            border-bottom: none;
        }
        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
        }
        .btn-upload {
            padding: 12px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
    </style>
</head>
<body>

    <%@ include file="/00_controle/00_sistema/Layout/cabecalho.jsp" %>

    <!-- Variáveis de sessão mantidas conforme original -->
    <c:set scope="session" var="aces_cad_sis" value="${sessionScope.aces_cad_sis}" />
    <c:set scope="session" var="aces_cad_clin" value="${sessionScope.aces_cad_clin}" />
    <c:set scope="session" var="aces_cad_forn" value="${sessionScope.aces_cad_forn}" />
    <c:set scope="session" var="aces_cad_prod" value="${sessionScope.aces_cad_prod}" />
    <c:set scope="session" var="aces_cad_serv" value="${sessionScope.aces_cad_serv}" />
    <c:set scope="session" var="cons_true" value="${sessionScope.cons_true}" />
    <c:set scope="session" var="insc_ocult" value="${sessionScope.insc_ocult}" />
    <c:set scope="session" var="tab_dom_ocult" value="${sessionScope.tab_dom_ocult}" />
    <c:set scope="session" var="tab_cont_ocult" value="${sessionScope.tab_cont_ocult}" />
    <c:set scope="session" var="ocul_excluir" value="${sessionScope.ocul_excluir}" />
    <c:set scope="session" var="naoexitedado" value="${sessionScope.naoexitedado}" />
    <c:set scope="session" var="list_cons_ocult" value="${sessionScope.list_cons_ocult}" />
    <c:set scope="session" var="aces_dev" value="${sessionScope.aces_dev}" />

    <!-- Conteúdo Principal -->
    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card card-upload shadow-sm">
                    <div class="card-header bg-primary text-white text-center py-3">
                        <h4 class="mb-0">
                            <i class="bi bi-file-earmark-pdf-fill me-2"></i>Enviar PDFs
                        </h4>
                    </div>
                    <div class="card-body p-4 p-md-5">
                        <form action="upload" method="post" enctype="multipart/form-data">
                            <div class="mb-4">
                                <label for="arquivo" class="form-label fw-bold text-secondary">Selecione os arquivos</label>
                                <input class="form-control form-control-lg" type="file" id="arquivo" name="arquivo" accept="application/pdf" multiple required>
                                <div class="form-text mt-2" id="file-feedback">
                                    <i class="bi bi-info-circle me-1"></i>
                                    Você pode selecionar múltiplos arquivos. Apenas formatos <strong>.pdf</strong> são permitidos.
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-lg btn-upload">
                                    <i class="bi bi-cloud-upload-fill me-2"></i>Enviar Arquivos
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <!-- jQuery (mantido caso o cabeçalho ou outros scripts dependam dele, removida a duplicidade) -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" crossorigin="anonymous"></script>
    
    <!-- Bootstrap Bundle JS (Já inclui o Popper.js, tornando a chamada separada desnecessária) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Script para melhorar a UX mostrando os nomes dos arquivos selecionados -->
    <script>
        document.getElementById('arquivo').addEventListener('change', function(event) {
            const fileInput = event.target;
            const fileCount = fileInput.files.length;
            const feedback = document.getElementById('file-feedback');
            
            if (fileCount > 0) {
                let fileNames = Array.from(fileInput.files).map(file => file.name).join(', ');
                if (fileCount > 3) {
                    fileNames = Array.from(fileInput.files).slice(0, 3).map(file => file.name).join(', ') + ` <em>e mais ${fileCount - 3} arquivo(s)</em>`;
                }
                feedback.innerHTML = `<i class="bi bi-check-circle-fill text-success me-1"></i> <strong>${fileCount}</strong> arquivo(s) selecionado(s): <br><span class="text-muted small mt-1 d-block">${fileNames}</span>`;
            } else {
                feedback.innerHTML = `<i class="bi bi-info-circle me-1"></i> Você pode selecionar múltiplos arquivos. Apenas formatos <strong>.pdf</strong> são permitidos.`;
            }
        });
    </script>

</body>
</html>