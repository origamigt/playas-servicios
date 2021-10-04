package ec.gob.ventanilla.util;


import ec.gob.ventanilla.entity.AclUser;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;

import java.util.Calendar;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;

public class Util {

    public static HttpComponentsClientHttpRequestFactory getClientHttpRequestFactory(String user, String pass) {
        HttpComponentsClientHttpRequestFactory clientHttpRequestFactory = new HttpComponentsClientHttpRequestFactory();
        clientHttpRequestFactory.setHttpClient(httpClient(user, pass));
        return clientHttpRequestFactory;
    }

    public static HttpClient httpClient(String user, String pass) {
        CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
        credentialsProvider.setCredentials(AuthScope.ANY, new UsernamePasswordCredentials(user, pass));
        HttpClient client1 = HttpClientBuilder.create().setDefaultCredentialsProvider(credentialsProvider).build();
        return client1;
    }

    public static String getMailHtmlRecuperarClave(Integer idUser, String user, String dominio) {
        try {
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.HOUR, 24);
            StringBuilder sb = new StringBuilder();
            // cabecera:
            sb.append("<div> <img src=\"").append(dominio).append("resources/images/mailhead1.png\" /> </div>");
            sb.append("<h1> Cambio de Clave </h1>");
            // mensaje:
            String mensaje = "Este correo tiene una validez de 24 horas.<br/>"
                    + "Para el cambio de clave hacer clic en el siguiente enlace: "
                    + "<a href=\"" + dominio + "registro/cambio-clave.xhtml?code1=" + idUser + "&code2="
                    + user + "&code3=" + cal.getTimeInMillis() + "\" target=\"_new\">AQUI.</a>";
            sb.append("<p>").append(mensaje).append("</p>");

            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String getHtmlCodigoVerificacion(String codigo, String dominio) {
        try {
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.HOUR, 24);
            StringBuilder sb = new StringBuilder();
            // cabecera:
            sb.append("<div> <img src=\"").append(dominio).append("\" /> </div>");
            sb.append("<h1> Código de Verificación <br> " + codigo + "</br> </h1>");
            // mensaje:
            String mensaje = "Este código permanecerá activo durante 5 minutos y es válido por una sola ocasión. <br/>";
            sb.append("<p>").append(mensaje).append("</p>");
            // footer:

            sb.append("</center>");
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    public static String getHtmlActivacionUsuario(String obs, String dominio) {
        try {
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.HOUR, 24);
            StringBuilder sb = new StringBuilder();
            // cabecera:
            sb.append("<div> <img src=\"").append(dominio).append("\" /> </div>");
            sb.append("<h1> Estimado usuario <br> " + obs + "</br> </h1>");
            // mensaje:
            String mensaje = "No responda a este correo. <br/>";
            sb.append("<p>").append(mensaje).append("</p>");
            // footer:

            sb.append("</center>");
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static <T> Predicate<T> distinctByKey(Function<? super T, ?> keyExtractor) {
        Map<Object, Boolean> seen = new ConcurrentHashMap<>();
        return t -> seen.putIfAbsent(keyExtractor.apply(t), Boolean.TRUE) == null;
    }

}
