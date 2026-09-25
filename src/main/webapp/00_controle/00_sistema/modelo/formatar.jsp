 ```html
<ul class="nav nav-tabs" id="myTab" role="tablist">

	<li class="nav-item" role="presentation">
		<button class="nav-link active" id="dados-tab" data-bs-toggle="tab"
			data-bs-target="#dados" type="button" role="tab">Dado
			Adicional</button>
	</li>

	<li class="nav-item" role="presentation">
		<button class="nav-link" id="financeiro-tab" data-bs-toggle="tab"
			data-bs-target="#financeiro" type="button" role="tab">
			Financeiro</button>
	</li>

	<li class="nav-item" role="presentation">
		<button class="nav-link" id="endereco-tab" data-bs-toggle="tab"
			data-bs-target="#endereco" type="button" role="tab">
			Endereço de Envio</button>
	</li>

</ul>


<div class="tab-content border border-top-0 p-3" id="myTabContent">

	<!-- DADO ADICIONAL -->
	<div class="tab-pane fade show active" id="dados" role="tabpanel"
		aria-labelledby="dados-tab">

		<div class="row">

			<div class="col-md-6 mb-3">
				<label id="l_tel_1" data-placeholder="Telefone"></label> <input
					type="text" maxlength="20" name="tel_1" id="tel_1"
					autocomplete="off" class="form-control" placeholder="Telefone"
					value="${pre_glo.tel_1}">
			</div>

			<div class="col-md-6 mb-3">
				<label id="l_email_1" data-placeholder="E-mail"></label>
				<textarea name="email_1" id="email_1" class="form-control"
					placeholder="E-mail envio Nota Fiscal" autocomplete="off" rows="1"
					style="overflow: hidden; resize: none;"
					oninput="this.style.height='auto'; this.style.height=this.scrollHeight+'px';">${pre_glo.email_1}</textarea>

			</div>

		</div>

	</div>


	<!-- FINANCEIRO -->
	<div class="tab-pane fade" id="financeiro" role="tabpanel"
		aria-labelledby="financeiro-tab">

		<div class="row">

			<div class="col-md-6 mb-3">
				<label for="chave_pix" class="form-label"> Chave Pix </label> <input
					type="text" class="form-control" id="chave_pix" name="chave_pix"
					placeholder="Digite a chave Pix">
			</div>

			<div class="col-md-6 mb-3">
				<label for="nome_pix" class="form-label"> Nome </label> <input
					type="text" class="form-control" id="nome_pix" name="nome_pix"
					placeholder="Nome do titular">
			</div>

		</div>

	</div>


	<!-- ENDEREÇO DE ENVIO -->
	<div class="tab-pane fade" id="endereco" role="tabpanel"
		aria-labelledby="endereco-tab">

		<div class="row">

			<div class="col-md-8 mb-3">
				<label for="endereco_completo" class="form-label"> Endereço
					completo </label> <input type="text" class="form-control"
					id="endereco_completo" name="endereco_completo"
					placeholder="Rua, número, complemento, bairro...">
			</div>

			<div class="col-md-4 mb-3">
				<label for="cep" class="form-label"> CEP </label> <input type="text"
					class="form-control" id="cep" name="cep" placeholder="00000-000"
					maxlength="9">
			</div>

		</div>

	</div>

</div>
```
