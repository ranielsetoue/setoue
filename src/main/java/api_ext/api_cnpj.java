package api_ext;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

import com.google.gson.Gson;

import cla.cla_cnpj;

public class api_cnpj {

	public static cla_cnpj cons_cnpj(String CNPJ) throws Exception {

		/*
		 * System.out.println(CNPJ);
		 */

		CNPJ = CNPJ.replaceAll("\\.", "");
		CNPJ = CNPJ.replaceAll("\\/", "");
		CNPJ = CNPJ.replaceAll("\\-", "");

		URL url = new URL("https://receitaws.com.br/v1/cnpj/" + CNPJ);
		URLConnection connection = url.openConnection();
		InputStream is = connection.getInputStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));

		String cnpj = "";
		StringBuilder jsonCNPJ = new StringBuilder();
		while ((cnpj = br.readLine()) != null) {
			jsonCNPJ.append(cnpj);
		}

		cla_cnpj cl_end_c = new Gson().fromJson(jsonCNPJ.toString(), cla_cnpj.class);
		return cl_end_c;

	}

}
