<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html lang="pt-br">
<head>
<title>Busca de Sistemas</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>

<body>

	<!-- Formulário de login -->
	<form id="formLogin" method="post"
		action="<%=request.getContextPath()%>/lt_sis_log/"
		onsubmit="return validardadosLogin()">
		<div class="container-fluid mt-3 px-4">
			<div class="container">
				<div class="row align-items-center text-center text-md-left">

					<!-- Coluna esquerda: logo -->
					<div class="col-12 col-md-2 align-self-center">
						<img height="200" width="400"
							src="<%=request.getContextPath()%>/desenho/logo.png" alt="Logo"
							class="img-fluid">
					</div>

					<!-- Coluna central: título -->
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

					<!-- Coluna direita: usuário e logout -->
					<div
						class="col-12 col-md-3 d-flex justify-content-center justify-content-md-end align-items-center">
						<table>
							<tr>
								<td class="pl-2"><a>Usuario: </a> <c:if
										test="${not empty sessionScope.usu_html}">
                                    ${sessionScope.usu_html}
                                </c:if></td>
								<td><a
									href="<%=request.getContextPath()%>/lt_sis_log/?f_out_log=f_out_log">
										<button type="button" class="btn btn-warning">Logout</button>
								</a></td>
							</tr>
						</table>
					</div>
				</div>
			</div>

		</div>
	</form>



	<div class="container mt-4">
		<!-- ====== FORM DE BUSCA ====== -->
		<form id="formBusca" method="post"
			action="<%=request.getContextPath()%>/lt_dev/" class="mb-3">
			<input type="hidden" name="fun" id="fun" value="" /> <label
				for="termo" class="form-label">Digite o nome, CPF/CNPJ ou
				ID:</label> <input type="text" name="termo" id="termo" class="form-control"
				value="${param.termo}" placeholder="Ex: Raniel Assis Setoue"
				onfocus="limparFormulario()">
			<button type="button" class="btn btn-primary mt-2"
				onclick="enviarForm('buscar_dado')">Buscar</button>
		</form>

		<hr />

		<!-- ====== RESULTADOS DA BUSCA ====== -->
		<c:if test="${not empty listaResultados}">

			<table id="tab1-resul"
				class="table table-bordered table-striped text-center">
				<thead>
					<tr>
						<th>CPF/CNPJ</th>
						<th>Nome</th>
						<th>Nome Fantasia</th>
						<th>Selecionar</th>
					</tr>
				</thead>
				<tbody id="tab1-corpo">
					<c:forEach var="item" items="${listaResultados}">
						<tr>
							<td>${item.cnpj_cpf}</td>
							<td>${item.nome_desc}</td>
							<td>${item.no_fan}</td>
							<td>
								<button type="button" class="btn btn-warning"
									onclick="sel_clin(this);" data-cnpjcpf="${item.cnpj_cpf}"
									data-nome="${item.nome_desc}" data-fantasia="${item.no_fan}"
									data-endereco="${item.end_rua}" data-numero="${item.end_num}"
									data-complemento="${item.end_com}"
									data-bairro="${item.end_bar}" data-municipio="${item.end_mun}"
									data-estado="${item.end_uf}" data-cep="${item.end_cep}"
									data-observacao="${item.obs}"
									data-truefalse="${item.truefalse}"
									data-permissao="${item.tipo_ace}">SEL</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<!-- AUTO-SELEÇÃO SE HOUVER APENAS 1 RESULTADO -->
			<c:if test="${fn:length(listaResultados) == 1}">
				<script>
			document.addEventListener("DOMContentLoaded", () => {
				const tabela = document.querySelector("table.table");
				if (tabela) tabela.style.display = "none";
				const botao = tabela?.querySelector("button.btn-warning");
				if (botao) sel_clin(botao);
			});
			</script>
			</c:if>
		</c:if>
		<div class="container mt-3">
			<div class="row align-items-center text-center text-md-left">
				<div
					class="col-12 col-md-12 mb-2 mb-0 align-self-center text-center">
					<div id="paginacao" class="d-flex justify-content-center mt-2"></div>

				</div>

			</div>
		</div>

	</div>




	<!-- ====== FORMULÁRIO DE DADOS ====== -->
	<form id="fon_cad" method="post"
		action="<%=request.getContextPath()%>/lt_sis_busc/"
		onsubmit="return validardados()">
		<div class="container mt-md-3">
			<!-- CAMPOS PRINCIPAIS -->
			<div class="row g-2">
				<div class="col-md-4">
					<label id="l_cnpj_cpf" data-placeholder="CNPJ/CPF">CNPJ/CPF</label>
					<input id="cnpj_cpf" name="cnpj_cpf" class="form-control"
						placeholder="CNPJ ou CPF">
				</div>

				<div class="col-md-4">
					<label id="l_nome_desc" data-placeholder="Nome/Razão Social">Nome/Razão</label>
					<input id="nome_desc" name="nome_desc" class="form-control"
						placeholder="Nome ou Razão Social">
				</div>

				<div class="col-md-4">
					<label id="l_no_fan" data-placeholder="Nome Fantasia">Nome
						Fantasia</label> <input id="no_fan" name="no_fan" class="form-control"
						placeholder="Nome Fantasia">
				</div>
			</div>

			<div class="row g-2 mt-2">
				<div class="col-md-6">
					<label id="l_end_rua" data-placeholder="Endereço">Endereço</label>
					<input id="end_rua" name="end_rua" class="form-control"
						placeholder="Endereço">
				</div>
				<div class="col-md-2">
					<label id="l_end_num" data-placeholder="Número">Número</label> <input
						id="end_num" name="end_num" class="form-control"
						placeholder="Número">
				</div>
				<div class="col-md-4">
					<label id="l_end_com" data-placeholder="Complemento">Complemento</label>
					<input id="end_com" name="end_com" class="form-control"
						placeholder="Complemento">
				</div>
			</div>

			<div class="row g-2 mt-2">
				<div class="col-md-3">
					<label id="l_end_bar" data-placeholder="Bairro">Bairro</label> <input
						id="end_bar" name="end_bar" class="form-control"
						placeholder="Bairro">
				</div>
				<div class="col-md-3">
					<label id="l_end_mun" data-placeholder="Município">Município</label>
					<input id="end_mun" name="end_mun" class="form-control"
						placeholder="Município">
				</div>
				<div class="col-md-2">
					<label id="l_end_uf" data-placeholder="UF">UF</label> <input
						id="end_uf" name="end_uf" class="form-control" maxlength="2"
						placeholder="UF">
				</div>
				<div class="col-md-4">
					<label id="l_end_cep" data-placeholder="CEP">CEP</label> <input
						id="end_cep" name="end_cep" class="form-control" placeholder="CEP">
				</div>
			</div>

			<div class="row g-2 mt-2">
				<div class="col-md-6">
					<label id="l_obs" data-placeholder="Observações">Observações</label>
					<textarea id="obs" name="obs" class="form-control"
						placeholder="Observações"></textarea>
				</div>
				<div class="col-md-3">
					<label id="l_truefalse" data-placeholder="Ativo">Ativo</label> <input
						id="truefalse" name="truefalse" class="form-control"
						placeholder="Ativo ou Inativo">
				</div>
				<div class="col-md-3">
					<label id="l_tipo_ace" data-placeholder="Permissão">Permissão</label>
					<input id="tipo_ace" name="tipo_ace" class="form-control"
						placeholder="Permissão">
				</div>
			</div>

		</div>
	</form>

	<!-- ====== SCRIPT PRINCIPAL ====== -->
	<script>
// Função principal: seleciona cliente
function sel_clin(botao) {
	if (!botao) return;
	const campos = {
		cnpjcpf: "cnpj_cpf",
		nome: "nome_desc",
		fantasia: "no_fan",
		endereco: "end_rua",
		numero: "end_num",
		complemento: "end_com",
		bairro: "end_bar",
		municipio: "end_mun",
		estado: "end_uf",
		cep: "end_cep",
		observacao: "obs",
		truefalse: "truefalse",
		permissao: "tipo_ace"
	};

	// Preenche os campos
	for (const key in campos) {
		const id = campos[key];
		const input = document.getElementById(id);
		if (input) input.value = botao.getAttribute("data-" + key) || "";
	}

	// Oculta e limpa a tabela após seleção
	const tabela = document.querySelector("table.table");
	if (tabela) {
		tabela.style.opacity = "0"; // animação suave
		setTimeout(() => {
			tabela.style.display = "none";
			const tbody = tabela.querySelector("tbody");
			if (tbody) tbody.innerHTML = "";
		}, 400);
	}

	initLabels();
	highlightForm();

	// Rola suavemente até o formulário
	document.getElementById("fon_cad").scrollIntoView({ behavior: "smooth" });
}

// Efeito visual de destaque ao preencher
function highlightForm() {
	const form = document.getElementById("fon_cad");
	form.style.transition = "box-shadow 0.6s ease";
	form.style.boxShadow = "0 0 15px 3px gold";
	setTimeout(() => form.style.boxShadow = "none", 1200);
}

// ====== LIMPAR CAMPOS AO ENTRAR NO CAMPO DE BUSCA ======
function limparFormularioCadastro() {
	const inputs = document.querySelectorAll('#fon_cad input, #fon_cad textarea');
	inputs.forEach(input => input.value = '');
	initLabels();

	// Se quiser que a tabela reapareça limpa:
	const tabela = document.querySelector("table.table");
	if (tabela) {
		tabela.style.display = "none";
		const tbody = tabela.querySelector("tbody");
		if (tbody) tbody.innerHTML = "";
	}
}

// Detecta quando o usuário clica ou digita no campo de busca
document.addEventListener('DOMContentLoaded', () => {
	const campoBusca = document.getElementById('termo');
	if (campoBusca) {
		campoBusca.addEventListener('focus', limparFormularioCadastro);
		campoBusca.addEventListener('input', limparFormularioCadastro);
	}
	initLabels();
});

// Labels dinâmicos
function toggleLabel(inputId, labelId) {
	const input = document.getElementById(inputId);
	const label = document.getElementById(labelId);
	if (!input || !label) return;
	if (!input.value.trim()) {
		label.style.display = 'none';
	} else {
		label.style.display = 'inline';
		label.textContent = label.dataset.placeholder;
	}
}
function initLabels() {
	document.querySelectorAll('input[placeholder], textarea[placeholder]').forEach(input => {
		const labelId = 'l_' + input.id;
		const label = document.getElementById(labelId);
		if (label) {
			toggleLabel(input.id, labelId);
			input.addEventListener('input', () => toggleLabel(input.id, labelId));
			input.addEventListener('blur', () => toggleLabel(input.id, labelId));
		}
	});
}

// Validação e envio do formulário de busca
function enviarForm(funcao) {
	if (!validardados()) return false;
	document.getElementById('fun').value = funcao;
	document.getElementById('formBusca').submit();
}
function validardados() {
	const termo = document.getElementById('termo').value.trim();
	if (termo === "") {
		alert("Digite algum valor para buscar.");
		return false;
	}
	return true;
}

function limparFormulario() {
    // Limpa campos do formulário de dados
    const campos = [
        'cnpj_cpf', 'nome_desc', 'no_fan',
        'end_rua', 'end_num', 'end_com',
        'end_bar', 'end_mun', 'end_uf', 'end_cep',
        'obs', 'truefalse', 'tipo_ace','termo'
    ];
    campos.forEach(id => {
        const input = document.getElementById(id);
        if(input) input.value = '';
    });

    // Oculta a tabela de resultados antiga
    const tabela = document.querySelector('table.table');
    if(tabela) tabela.style.display = 'none';
}

//Paginação avançada com 3 páginas visíveis, reticências e atalhos de teclado
function paginarTabela(tabelaId, linhasPorPagina = 20) {
    const tabela = document.getElementById(tabelaId);
    if (!tabela) return;

    const tbody = tabela.querySelector('tbody');
    const linhas = Array.from(tbody.querySelectorAll('tr'));
    const totalPaginas = Math.ceil(linhas.length / linhasPorPagina);
    let paginaAtual = 1;

    function mostrarPagina(pagina) {
        paginaAtual = Math.max(1, Math.min(pagina, totalPaginas));
        const inicio = (paginaAtual - 1) * linhasPorPagina;
        const fim = inicio + linhasPorPagina;

        linhas.forEach((linha, i) => {
            linha.style.display = i >= inicio && i < fim ? '' : 'none';
        });

        renderPaginacao();
    }

    function renderPaginacao() {
        const container = document.getElementById('paginacao');
        container.innerHTML = '';

        if (totalPaginas <= 1) return;

        const grupoMaximo = 3; // número máximo de páginas visíveis
        let inicioGrupo = Math.max(1, paginaAtual - Math.floor(grupoMaximo / 2));
        let fimGrupo = inicioGrupo + grupoMaximo - 1;

        if (fimGrupo > totalPaginas) {
            fimGrupo = totalPaginas;
            inicioGrupo = Math.max(1, fimGrupo - grupoMaximo + 1);
        }

        // Botão "Anterior"
        const btnAnterior = document.createElement('button');
        btnAnterior.textContent = 'Anterior';
        btnAnterior.className = 'btn btn-sm mx-1 btn-outline-primary';
        btnAnterior.disabled = paginaAtual === 1;
        btnAnterior.addEventListener('click', () => mostrarPagina(paginaAtual - 1));
        container.appendChild(btnAnterior);

        // Reticências no início
        if (inicioGrupo > 1) {
            const ellipsisInicio = document.createElement('span');
            ellipsisInicio.textContent = '...';
            ellipsisInicio.className = 'mx-1 align-self-center';
            container.appendChild(ellipsisInicio);
        }

        // Botões de páginas
        for (let i = inicioGrupo; i <= fimGrupo; i++) {
            const btn = document.createElement('button');
            btn.textContent = i;
            btn.className = 'btn btn-sm mx-1 ' + (i === paginaAtual ? 'btn-primary' : 'btn-outline-primary');
            btn.addEventListener('click', () => mostrarPagina(i));
            container.appendChild(btn);
        }

        // Reticências no final
        if (fimGrupo < totalPaginas) {
            const ellipsisFim = document.createElement('span');
            ellipsisFim.textContent = '...';
            ellipsisFim.className = 'mx-1 align-self-center';
            container.appendChild(ellipsisFim);
        }

        // Botão "Próximo"
        const btnProximo = document.createElement('button');
        btnProximo.textContent = 'Próximo';
        btnProximo.className = 'btn btn-sm mx-1 btn-outline-primary';
        btnProximo.disabled = paginaAtual === totalPaginas;
        btnProximo.addEventListener('click', () => mostrarPagina(paginaAtual + 1));
        container.appendChild(btnProximo);
    }

    // Atalhos de teclado ← e →
    document.addEventListener('keydown', (event) => {
        const isInputActive =
            document.activeElement.tagName === 'INPUT' ||
            document.activeElement.tagName === 'TEXTAREA';
        if (isInputActive) return; // evita conflito com campos de texto

        if (event.key === 'ArrowLeft' && paginaAtual > 1) {
            mostrarPagina(paginaAtual - 1);
        } else if (event.key === 'ArrowRight' && paginaAtual < totalPaginas) {
            mostrarPagina(paginaAtual + 1);
        }
    });

    mostrarPagina(1);
}

// Inicializa a paginação após carregar a tabela
document.addEventListener('DOMContentLoaded', () => {
    const tabela = document.querySelector('table.table');
    if (tabela) {
        paginarTabela('tab1-resul', 2);
    }
});


</script>

</body>
</html>
