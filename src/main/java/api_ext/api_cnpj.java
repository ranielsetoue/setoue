package api_ext;

import java.util.HashMap;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.google.gson.Gson;

import cla.cla_cnpj;

public class api_cnpj {

	// CACHE LOCAL (CNJP → resposta JSON)
	private static final Map<String, CacheItem> CACHE = new HashMap<>();

	// TEMPO PARA EXPIRAR CACHE (10 minutos)
	private static final long CACHE_TEMPO_MS = 10 * 60 * 1000;

	// LIMITE RECEITAWS
	private static final int MAX_POR_CICLO = 3;
	private static int contConsulta = 0;
	private static long ultimoCiclo = System.currentTimeMillis();

	// ITEM DO CACHE
	private static class CacheItem {
		String json;
		long timestamp;

		CacheItem(String json) {
			this.json = json;
			this.timestamp = System.currentTimeMillis();
		}

		boolean expirado() {
			return (System.currentTimeMillis() - timestamp) > CACHE_TEMPO_MS;
		}
	}

	// MÉTODO PRINCIPAL
	public static cla_cnpj cons_cnpj(String CNPJ) throws Exception {

		CNPJ = CNPJ.replaceAll("\\D", "");

		// === 1) TENTA CONSULTAR DO CACHE ===
		if (CACHE.containsKey(CNPJ)) {

			CacheItem item = CACHE.get(CNPJ);

			if (!item.expirado()) {
				/*
				 * System.out.println("CACHE → " + CNPJ);
				 */
				return new Gson().fromJson(item.json, cla_cnpj.class);
			} else {
				CACHE.remove(CNPJ); // remove expirada
			}
		}

		// === 2) CONTROLE LIMITE 3 CONSULTAS → AGUARDA 60s ===
		controlarLimite();

		// === 3) CONSULTA VIA APACHE HTTPCLIENT ===
		String url = "https://receitaws.com.br/v1/cnpj/" + CNPJ;

		CloseableHttpClient client = HttpClients.createDefault();
		HttpGet request = new HttpGet(url);

		CloseableHttpResponse response = client.execute(request);

		HttpEntity entity = response.getEntity();
		String json = EntityUtils.toString(entity, "UTF-8");

		response.close();
		client.close();

		// salva no CACHE
		CACHE.put(CNPJ, new CacheItem(json));

		/*
		 * System.out.println("API → " + CNPJ);
		 */

		return new Gson().fromJson(json, cla_cnpj.class);
	}

	// CONTROLE DE RATE-LIMIT
	private static void controlarLimite() {

		long agora = System.currentTimeMillis();

		// reinicia ciclo se passou mais de 60s
		if (agora - ultimoCiclo > 60_000) {
			contConsulta = 0;
			ultimoCiclo = agora;
		}

		contConsulta++;

		// se chegou a 3 consultas → espera 60s
		if (contConsulta >= MAX_POR_CICLO) {
			System.out.println("Limite atingido. Aguardando 60s...");
			try {
				Thread.sleep(60_000);
			} catch (InterruptedException e) {
			}

			contConsulta = 0;
			ultimoCiclo = System.currentTimeMillis();
		}
	}


}
