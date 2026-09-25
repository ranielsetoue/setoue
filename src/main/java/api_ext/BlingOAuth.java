package api_ext;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import com.google.gson.Gson;

public class BlingOAuth {

    private static final String AUTH_URL =
            "https://www.bling.com.br/Api/v3/oauth/authorize";

    private static final String TOKEN_URL =
            "https://api.bling.com.br/Api/v3/oauth/token";

    private final String clientId;

    private final String clientSecret;

    private final String redirectUri;

    private final HttpClient client;

    private final Gson gson;


    public BlingOAuth(
            String clientId,
            String clientSecret,
            String redirectUri) {

        this.clientId = clientId;

        this.clientSecret = clientSecret;

        this.redirectUri = redirectUri;

        this.client = HttpClient.newHttpClient();

        this.gson = new Gson();
    }


    // =========================================================
    // URL DE AUTORIZAÇÃO
    // =========================================================

    public String criarUrlAutorizacao(
            String state) {

        return AUTH_URL
                + "?response_type=code"
                + "&client_id="
                + encode(clientId)
                + "&state="
                + encode(state);
    }


    // =========================================================
    // TROCA CODE POR JWT
    // =========================================================

    public BlingToken obterToken(
            String code)
            throws IOException, InterruptedException {

        String basic =
                criarBasic();


        String body =
                "grant_type=authorization_code"
                + "&code="
                + encode(code)
                + "&redirect_uri="
                + encode(redirectUri);


        HttpRequest request =
                HttpRequest.newBuilder()
                        .uri(
                                URI.create(
                                        TOKEN_URL))
                        .header(
                                "Authorization",
                                "Basic " + basic)
                        .header(
                                "Content-Type",
                                "application/x-www-form-urlencoded")
                        .header(
                                "Accept",
                                "application/json")
                        .header(
                                "enable-jwt",
                                "1")
                        .POST(
                                HttpRequest
                                        .BodyPublishers
                                        .ofString(body))
                        .build();


        HttpResponse<String> response =
                client.send(
                        request,
                        HttpResponse.BodyHandlers
                                .ofString());


        if (response.statusCode() != 200) {

            throw new IOException(
                    "Erro ao obter token Bling. HTTP "
                    + response.statusCode()
                    + " - "
                    + response.body());
        }


        return gson.fromJson(
                response.body(),
                BlingToken.class);
    }


    // =========================================================
    // RENOVA JWT
    // =========================================================

    public BlingToken renovarToken(
            String refreshToken)
            throws IOException, InterruptedException {

        String basic =
                criarBasic();


        String body =
                "grant_type=refresh_token"
                + "&refresh_token="
                + encode(refreshToken)
                + "&redirect_uri="
                + encode(redirectUri);


        HttpRequest request =
                HttpRequest.newBuilder()
                        .uri(
                                URI.create(
                                        TOKEN_URL))
                        .header(
                                "Authorization",
                                "Basic " + basic)
                        .header(
                                "Content-Type",
                                "application/x-www-form-urlencoded")
                        .header(
                                "Accept",
                                "application/json")
                        .header(
                                "enable-jwt",
                                "1")
                        .POST(
                                HttpRequest
                                        .BodyPublishers
                                        .ofString(body))
                        .build();


        HttpResponse<String> response =
                client.send(
                        request,
                        HttpResponse.BodyHandlers
                                .ofString());


        if (response.statusCode() != 200) {

            throw new IOException(
                    "Erro ao renovar token Bling. HTTP "
                    + response.statusCode()
                    + " - "
                    + response.body());
        }


        return gson.fromJson(
                response.body(),
                BlingToken.class);
    }


    // =========================================================
    // BASIC AUTH
    // =========================================================

    private String criarBasic() {

        String credencial =
                clientId
                + ":"
                + clientSecret;


        return Base64.getEncoder()
                .encodeToString(
                        credencial.getBytes(
                                StandardCharsets.UTF_8));
    }


    // =========================================================
    // ENCODE
    // =========================================================

    private String encode(
            String valor) {

        return URLEncoder.encode(
                valor,
                StandardCharsets.UTF_8);
    }
}
