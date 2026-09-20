<script type="text/javascript">
<span style="cursor:pointer;" onclick="carregarPaginacont(1)"></span>
<span>|</span>

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

function montarPaginascont() {

 var registrosPorPagina = 5;
 var totalRegistros = totalRegistrosCont;

 var totalPaginas = Math.ceil(totalRegistros / registrosPorPagina);

 var html = "";

 for (var pagina = 1; pagina <= totalPaginas; pagina++) {

     if (pagina > 1) {
         html += " - ";
     }

     html += '<span style="cursor:pointer;" ';
     html += 'onclick="carregarPaginacont(' + pagina + ')">';
     html += pagina;
     html += '</span>';
 }

 document.getElementById("pag_cont").innerHTML = html;
}

montarPaginascont(1);

function carregarPaginacont(pagina) {

 atualizarInfocont(pagina);

 var registrosPorPagina = 5;
 var offset = (pagina - 1) * registrosPorPagina;

 var urlAction = '<%=request.getContextPath()%>/lt_sis_busc/?fun=pag_cont';
 var cont_cnpj_cpf = document.getElementById('cnpj_cpf').value;
     	

 
 
 $.ajax({
     type: "POST",
     url: urlAction,
     data: {
         offset: offset,cont_cnpj_cpf: cont_cnpj_cpf
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
