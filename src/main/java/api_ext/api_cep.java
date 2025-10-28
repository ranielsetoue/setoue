package api_ext;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.net.URL;
import java.net.URLConnection;

import com.google.gson.Gson;

import cla.cla_end_c;

public class api_cep implements Serializable {

	private static final long serialVersionUID = 1L;

	public static cla_end_c cons_cep(String CEP) throws Exception {

		CEP = CEP.replaceAll("\\.", "");
		CEP = CEP.replaceAll("\\/", "");
		CEP = CEP.replaceAll("\\-", "");
		CEP = CEP.replaceAll("\\ ", "");

		URL url = new URL("https://viacep.com.br/ws/" + CEP + "/json/");
		URLConnection connection = url.openConnection();
		InputStream is = connection.getInputStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));

		String cep = "";
		StringBuilder jsonCEP = new StringBuilder();

		while ((cep = br.readLine()) != null) {
			jsonCEP.append(cep);
		}

		cla_end_c cl_cep = new Gson().fromJson(jsonCEP.toString(), cla_end_c.class);
		cl_cep.setEnderenco(cl_cep.getLogradouro());
		cl_cep.setMunicipio(cl_cep.getLocalidade());

		return cl_cep;

	}
}
