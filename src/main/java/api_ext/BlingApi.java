
package api_ext;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class BlingApi {

    private static final String BASE_URL =
            "https://api.bling.com.br/Api/v3";

    private final HttpClient client;

    private String accessToken;

    public BlingApi(String accessToken) {

        this.accessToken = accessToken;

        this.client = HttpClient.newHttpClient();
    }

    public void setAccessToken(String accessToken) {

        this.accessToken = accessToken;
    }

    public String getAccessToken() {

        return accessToken;
    }

    /**
     * GET genérico.
     */
    public String get(String endpoint)
            throws IOException, InterruptedException {

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(BASE_URL + endpoint))
                .header(
                        "Authorization",
                        "Bearer " + accessToken)
                .header(
                        "enable-jwt",
                        "1")
                .header(
                        "Accept",
                        "application/json")
                .GET()
                .build();

        HttpResponse<String> response =
                client.send(
                        request,
                        HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() < 200
                || response.statusCode() >= 300) {

            throw new IOException(
                    "Erro API Bling. HTTP "
                    + response.statusCode()
                    + " - "
                    + response.body());
        }

        return response.body();
    }

    /**
     * PATCH genérico.
     */
    public String patch(
            String endpoint,
            String json)
            throws IOException, InterruptedException {

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(BASE_URL + endpoint))
                .header(
                        "Authorization",
                        "Bearer " + accessToken)
                .header(
                        "enable-jwt",
                        "1")
                .header(
                        "Content-Type",
                        "application/json")
                .header(
                        "Accept",
                        "application/json")
                .method(
                        "PATCH",
                        HttpRequest.BodyPublishers.ofString(json))
                .build();

        HttpResponse<String> response =
                client.send(
                        request,
                        HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() < 200
                || response.statusCode() >= 300) {

            throw new IOException(
                    "Erro API Bling. HTTP "
                    + response.statusCode()
                    + " - "
                    + response.body());
        }

        return response.body();
    }

    /**
     * PUT genérico.
     */
    public String put(
            String endpoint,
            String json)
            throws IOException, InterruptedException {

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(BASE_URL + endpoint))
                .header(
                        "Authorization",
                        "Bearer " + accessToken)
                .header(
                        "enable-jwt",
                        "1")
                .header(
                        "Content-Type",
                        "application/json")
                .header(
                        "Accept",
                        "application/json")
                .PUT(
                        HttpRequest.BodyPublishers.ofString(json))
                .build();

        HttpResponse<String> response =
                client.send(
                        request,
                        HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() < 200
                || response.statusCode() >= 300) {

            throw new IOException(
                    "Erro API Bling. HTTP "
                    + response.statusCode()
                    + " - "
                    + response.body());
        }

        return response.body();
    }
}

