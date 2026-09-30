<!--Inico Tabela Consultar Cliente Pelo Nome -->
<!-- Inicio Container -->
<div class="container mt-1">
	<!-- Inicio Container -->

	<div style="height: 350px; overflow: scroll;">
		<table class="table" id="t_list_cons">
			<thead>
				<tr>

					<th scope="col">Nome</th>
					<th scope="col">Telefone</th>
					<th scope="col">E-mail</th>

					<th scope="col">Selecionar</th>
				</tr>
			</thead>
			<tbody>
				<tr>

					<td><c:out value="${ml.nome_desc}"></c:out></td>
					<td><c:out value="${ml.tel_1}"></c:out></td>
					<td><c:out value="${ml.email_1}"></c:out></td>
					 class="btn
					btn-danger">Selecionar
					</a>
					</td>
					<td><button type="button" id="sel_cons"
							onclick="detalhe_cons(this)" data-nome_desc="${ml.nome_desc}"
							data-tel_1="${ml.tel_1}" data-tel_2="${ml.tel_2}"
							data-email_1="${ml.email_1}" data-email_2="${ml.email_2}"
							data-setor_1="${ml.setor_1}" data-obs="${ml.obs}"
							class="btn btn-warning" data-bs-toggle="modal">Seleção</button></td>

				</tr>

			</tbody>
		</table>

	</div>
	<hr>

	<div id="paginacao_cons"
		class="d-flex align-items-center justify-content-center flex-wrap mt-2">
		<!-- PAGINAÇÃO -->
		<span id="pag_cons" class="d-flex align-items-center"> </span>

		<!-- SEPARADOR -->
		<span class="text-secondary mx-2">|</span>

		<!-- INFORMAÇÃO -->
		<span id="info_cons" class="text-secondary"> </span>

	</div>
	<script type="text/javascript">

/* =====================================================
CONFIGURAÇÃO
===================================================== */

var totalRegistroscons = ${cont_list_qt.size()};
var paginaAtualcons = 1;
var registrosPorPaginacons = 5;


/* =====================================================
ATUALIZA INFORMAÇÃO
Exemplo: 1 - 5 de 21
===================================================== */

function atualizarInfocons(pagina) {

var registrosPorPaginacons = registrosPorPaginacons;
var totalRegistroscons = totalRegistroscons || 0;

var infocons = document.getElementById("info_cons");

/* Nenhum registro */
if (totalRegistroscons === 0) {

infocons.innerHTML = "0 - 0 de 0";

return;
}


/* Primeiro registro */
var iniciocons =
((pagina - 1) * registrosPorPaginacons) + 1;


/* Último registro */
var fimcons =
pagina * registrosPorPaginacons;


/* Não ultrapassar total */
if (fimcons > totalRegistroscons) {

fimcons = totalRegistroscons;
}


infocons.innerHTML =
iniciocons + " - " + fimcons + " de " + totalRegistroscons;
}


/* =====================================================
MONTA A PAGINAÇÃO
===================================================== */

function montarPaginascons(paginaAtualcons) {

var registrosPorPaginacons = registrosPorPaginacons;

var totalRegistroscons =
totalRegistroscons || 0;

var totalPaginascons =
Math.ceil(
totalRegistroscons / registrosPorPaginacons
);

var html = "";


/* =================================================
SEM REGISTROS
================================================= */

if (totalPaginascons === 0) {

document.getElementById("pag_cons").innerHTML = "";

return;
}


/* =================================================
BOTÃO PRIMEIRA
================================================= */

if (paginaAtualcons === 1) {

html +=
'<button type="button" ' +
'class="btn btn-light border rounded-3 px-3 py-2" ' +
'disabled>' +
'Primeira' +
'</button>';

} else {

html +=
'<button type="button" ' +
'class="btn btn-light border rounded-3 px-3 py-2" ' +
'onclick="carregarPaginacons(1)">' +
'Primeira' +
'</button>';
}


/* =================================================
SEPARADOR
================================================= */

html +=
'<span class="text-secondary mx-2">|</span>';


/* =================================================
DEFINE AS PÁGINAS VISÍVEIS

Até 3 páginas:
1 2 3

Página 3:
2 3 4

Última:
4 5 6
================================================= */

var iniciocons;
var fimcons;


if (totalPaginascons <= 3) {

iniciocons = 1;
fimcons = totalPaginas;

} else {

iniciocons = paginaAtualcons - 1;
fimcons = paginaAtualcons + 1;


/* Primeira ou segunda página */

if (paginaAtualcons <= 2) {

iniciocons = 1;
fimcons = 3;
}


/* Penúltima ou última página */

if (paginaAtualcons >= totalPaginascons - 1) {

iniciocons = totalPaginascons - 2;
fimcons = totalPaginascons;
}
}


/* =================================================
NÚMEROS DAS PÁGINAS
================================================= */

for (
var pagina = iniciocons;
pagina <= fimcons;
pagina++
) {


/* ---------------------------------------------
PÁGINA ATUAL
--------------------------------------------- */

if (pagina === paginaAtualcons) {

html +=
'<button type="button" ' +
'class="btn btn-primary rounded-3 px-3 py-2 mx-1" ' +
'disabled>' +
pagina +
'</button>';

}


/* ---------------------------------------------
OUTRAS PÁGINAS
--------------------------------------------- */

else {

html +=
'<button type="button" ' +
'class="btn btn-light border rounded-3 px-3 py-2 mx-1" ' +
'onclick="carregarPaginacons(' +
pagina +
')">' +
pagina +
'</button>';
}
}


/* =================================================
COLOCA PAGINAÇÃO NA TELA
================================================= */

document.getElementById("pag_cons").innerHTML =
html;
}


/* =====================================================
CARREGA A PÁGINA
===================================================== */

function carregarPaginacont(pagina) {

/* Guarda página atual */
paginaAtualcons = pagina;


/* Atualiza informação */
atualizarInfocons(pagina);


/* Atualiza botões */
montarPaginascons(pagina);


/* =================================================
OFFSET
================================================= */

var registrosPorPaginacons =
registrosPorPaginacons;

var offset =
(pagina - 1) * registrosPorPaginacons;


/* =================================================
URL
================================================= */

var urlAction =
'<%=request.getContextPath()%>/lt_sis_busc/?fun=pag_cons';


/* =================================================
CNPJ / CPF
================================================= */
var cont_bus_cons = document.getElementById('cont_bus_cons).value;

var campoCnpjCpf =
document.getElementById('cnpj_cpf');

var cont_cnpj_cpf = "";

if (campoCnpjCpf) {

cont_cnpj_cpf =
campoCnpjCpf.value;
}


/* =================================================
AJAX
================================================= */

$.ajax({

type: "POST",

url: urlAction,

data: {

offset: offset,
cont_bus_contcons:cont_bus_contcons,
cont_cnpj_cpfcons: cont_cnpj_cpfcons
},


/* ---------------------------------------------
SUCESSO
--------------------------------------------- */

success: function(response) {

$("#t_list_cons tbody").html(response);
},


/* ---------------------------------------------
ERRO
--------------------------------------------- */

error: function(xhr, status, error) {

console.log(xhr.responseText);

alert(
"Erro ao carregar página Tabela cons: " +
error
);
}

});
}


/* =====================================================
INICIALIZA PAGINAÇÃO
===================================================== */

atualizarInfocont(1)cons;

montarPaginascons(1);

</script>
	<!-- FIM Container -->
</div>
<!-- FIM Container -->
<!-- Fim Consultar Cliente Pelo Nome -->


