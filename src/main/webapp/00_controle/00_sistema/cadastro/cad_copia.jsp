<script type="text/javascript">

var totalRegistrosCont = ${cont_list_qt.size()};
function atualizarInfocont(pagina) {

	   var registrosPorPagina = 5;
	    var totalRegistros = totalRegistrosCont;

	    var inicio = ((pagina - 1) * registrosPorPagina) + 1;

	    var fim = pagina * registrosPorPagina;

	    if (fim > totalRegistros) {
	        fim = totalRegistros;
		   	    
	    }
	    document.getElementById("info_cont").innerHTML =
	        inicio + " - " + fim  + " de " + totalRegistros;

}

atualizarInfocont(1);
function montarPaginascont(paginaAtual) {

	    var registrosPorPagina = 5;
	    var totalRegistros = totalRegistrosCont || 0;
	    var totalPaginas = Math.ceil(totalRegistros / registrosPorPagina);

	    var html = "";

	    // PRIMEIRA
	    html += '<span style="cursor:pointer;" ';
	    html += 'onclick="carregarPaginacont(1)">Primeira</span>';

	    if (totalPaginas > 0) {
	        html += " | ";
	    }

	    // Define quais páginas serão exibidas
	    var inicio;
	    var fim;

	    if (totalPaginas <= 3) {

	        inicio = 1;
	        fim = totalPaginas;

	    } else {

	        inicio = paginaAtual - 1;
	        fim = paginaAtual + 1;

	        if (inicio < 1) {
	            inicio = 1;
	            fim = 3;
	        }

	        if (fim > totalPaginas) {
	            fim = totalPaginas;
	            inicio = totalPaginas - 2;
	        }
	    }

	    // NÚMEROS DAS PÁGINAS
	    for (var pagina = inicio; pagina <= fim; pagina++) {

	        if (pagina > inicio) {
	            html += " - ";
	        }

	        if (pagina == paginaAtual) {

	            // PÁGINA ATUAL DESTACADA
	            html += '<span style="cursor:pointer; font-weight:bold; text-decoration:underline;" ';
	            html += 'onclick="carregarPaginacont(' + pagina + ')">';
	            html += pagina;
	            html += '</span>';

	        } else {

	            html += '<span style="cursor:pointer;" ';
	            html += 'onclick="carregarPaginacont(' + pagina + ')">';
	            html += pagina;
	            html += '</span>';
	        }
	    }

	    document.getElementById("pag_cont").innerHTML = html;


}

montarPaginascont(1);


function carregarPaginacont(pagina) {

    atualizarInfocont(pagina);

    // Atualiza as páginas exibidas
    montarPaginascont(pagina);

    var registrosPorPagina = 5;

    var offset = (pagina - 1) * registrosPorPagina;

    var urlAction = '<%=request.getContextPath()%>/lt_sis_busc/?fun=pag_cont';

    var cont_cnpj_cpf = document.getElementById('cnpj_cpf').value;

    $.ajax({

        type: "POST",

        url: urlAction,

        data: {
            offset: offset,
            cont_cnpj_cpf: cont_cnpj_cpf
        },

        success: function(response) {

            $("#t_list_cont tbody").html(response);

        },

        error: function(xhr, status, error) {

            console.log(xhr.responseText);

            alert("Erro ao carregar página Contato: " + error);

        }

    });
}


</script>
