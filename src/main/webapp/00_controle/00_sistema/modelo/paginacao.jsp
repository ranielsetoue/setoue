<!-- 
salvar
						totalRegistrosdom++;

						// Volta para a primeira página
					    carregarPaginacont(1);
salvar	

excluir
							totalRegistrosdom--;

						// Volta para a primeira página
					    carregarPaginacont(1);
	
excluir
 -->

<div id="paginacao_dom"
     class="d-flex align-items-center justify-content-center flex-wrap mt-2">

    <!-- PAGINAÇÃO -->
    <span id="pag_dom"
          class="d-flex align-items-center">
    </span>

    <!-- SEPARADOR -->
    <span class="text-secondary mx-2">|</span>

    <!-- INFORMAÇÃO -->
    <span id="info_dom"
          class="text-secondary">
    </span>

</div>


<script type="text/javascript">

    /* =====================================================
       CONFIGURAÇÃO
       ===================================================== */

    var totalRegistrosdom = ${dom_list_qt.size()};
    var paginaAtualDom = 1;
    var registrosPorPaginaDom = 5;


    /* =====================================================
       ATUALIZA INFORMAÇÃO
       Exemplo: 1 - 5 de 21
       ===================================================== */

    function atualizarInfodom(pagina) {

        var registrosPorPagina =
            registrosPorPaginaDom;

        var totalRegistros =
            totalRegistrosdom || 0;

        var infoDom =
            document.getElementById("info_dom");


        /* Nenhum registro */

        if (totalRegistros === 0) {

            infoDom.innerHTML =
                "0 - 0 de 0";

            return;
        }


        /* Primeiro registro */

        var inicio =
            ((pagina - 1) * registrosPorPagina) + 1;


        /* Último registro */

        var fim =
            pagina * registrosPorPagina;


        /* Não ultrapassar total */

        if (fim > totalRegistros) {

            fim = totalRegistros;
        }


        infoDom.innerHTML =
            inicio + " - " + fim +
            " de " + totalRegistros;
    }


    /* =====================================================
       MONTA PAGINAÇÃO
       ===================================================== */

    function montarPaginasdom(paginaAtual) {

        var registrosPorPagina =
            registrosPorPaginaDom;

        var totalRegistros =
            totalRegistrosdom || 0;

        var totalPaginas =
            Math.ceil(
                totalRegistros / registrosPorPagina
            );

        var html = "";


        /* =================================================
           SEM REGISTROS
           ================================================= */

        if (totalPaginas === 0) {

            document.getElementById(
                "pag_dom"
            ).innerHTML = "";

            return;
        }


        /* =================================================
           BOTÃO PRIMEIRA
           ================================================= */

        if (paginaAtual === 1) {

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
                'onclick="carregarPaginadom(1)">' +
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
           
           Página 1:
           1 2 3

           Página 2:
           1 2 3

           Página 3:
           2 3 4

           Página 4:
           3 4 5

           Última:
           4 5 6
           ================================================= */

        var inicio;
        var fim;


        if (totalPaginas <= 3) {

            inicio = 1;
            fim = totalPaginas;

        } else {

            inicio = paginaAtual - 1;
            fim = paginaAtual + 1;


            /* Primeira ou segunda */

            if (paginaAtual <= 2) {

                inicio = 1;
                fim = 3;
            }


            /* Penúltima ou última */

            if (paginaAtual >= totalPaginas - 1) {

                inicio = totalPaginas - 2;
                fim = totalPaginas;
            }
        }


        /* =================================================
           NÚMEROS DAS PÁGINAS
           ================================================= */

        for (
            var pagina = inicio;
            pagina <= fim;
            pagina++
        ) {


            /* ---------------------------------------------
               PÁGINA ATUAL
               --------------------------------------------- */

            if (pagina === paginaAtual) {

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
                    'onclick="carregarPaginadom(' +
                    pagina +
                    ')">' +
                    pagina +
                    '</button>';
            }
        }


        /* =================================================
           COLOCA NA TELA
           ================================================= */

        document.getElementById(
            "pag_dom"
        ).innerHTML = html;
    }


    /* =====================================================
       CARREGA A PÁGINA
       ===================================================== */

    function carregarPaginadom(pagina) {

        /* Guarda página atual */

        paginaAtualDom = pagina;


        /* Atualiza informação */

        atualizarInfodom(pagina);


        /* Atualiza paginação */

        montarPaginasdom(pagina);


        /* =================================================
           OFFSET
           ================================================= */

        var registrosPorPagina =
            registrosPorPaginaDom;

        var offset =
            (pagina - 1) *
            registrosPorPagina;


        /* =================================================
           URL
           ================================================= */

        var urlAction =
            '<%=request.getContextPath()%>/lt_sis_busc/?fun=pag_dom';


        /* =================================================
           CNPJ / CPF
           ================================================= */

        var campoCnpjCpf =
            document.getElementById(
                'cnpj_cpf'
            );

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

                cont_cnpj_cpf: cont_cnpj_cpf
            },


            /* ---------------------------------------------
               SUCESSO
               --------------------------------------------- */

            success: function(response) {

                $("#t_list_dom tbody")
                    .html(response);
            },


            /* ---------------------------------------------
               ERRO
               --------------------------------------------- */

            error: function(
                xhr,
                status,
                error
            ) {

                console.log(
                    xhr.responseText
                );

                alert(
                    "Erro ao carregar página Dominio: " +
                    error
                );
            }

        });
    }


    /* =====================================================
       INICIALIZAÇÃO
       ===================================================== */

    atualizarInfodom(1);

    montarPaginasdom(1);

</script>