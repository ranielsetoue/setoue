<!-- 
/* =====================================================
INICIO PAGINAÇÃO CONS
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
            cons: cons
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