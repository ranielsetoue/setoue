			<!--  -->
			<!-- Inicio Container -->
			<c:if test="${cons_true}">
				<div class="container mt-3">
					<!-- Inicio Container -->
					<!-- Inicio row -->
					<div id="c_div_obs" class="row align-items-center text-center text-md-left">
						<!-- Inicio row -->
						<!-- coluna esquerda -->
						<div id="c_uf"
							class="col-12 col-md-4 mb-2 mb-0 align-self-center text-center">
						<input name="UF" id="UF"
								type="text" autocomplete="off" value="${sis_tel.sis_tel.ABC1}"
								class="form-control" placeholder="UF">
						</div>
						<!-- coluna esquerda -->
						<!-- coluna Central -->
						<div id="c_cep"
							class="col-12 col-md-4 mb-2 mb-0 align-self-center text-center">
							<input name="CEP" id="CEP"
								type="text" autocomplete="off" value="${sis_tel.ABC2}"
								class="form-control" placeholder="CEP">
						</div>
						<!-- coluna Central -->
						<!-- coluna Direita -->
						<div id="c_obs"
							class="col-12 col-md-4 mb-2 mb-0 align-self-center text-center">
							<input name="observacao" id="observacao"
								type="text" autocomplete="off" value="${sis_tel.ABC3}"
								class="form-control" placeholder="Observacao" rows="1">
						</div>
						<!-- coluna Direita -->
						<!-- FIM row -->
					</div>
					<!-- FIM row -->
					<!-- FIM Container -->
				</div>
			</c:if>
			<!-- FIM Container -->
			<!--  -->
