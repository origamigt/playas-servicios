package ec.gob.ventanilla.async;

import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.PubPersona;
import ec.gob.ventanilla.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.Date;

@Service
public class PersonaService {

    @Autowired
    private AppProps appProps;

    public PubPersona buscarPersonaDinardap(String identificacion) {

        try {
            RestTemplate restTemplate = new RestTemplate(Util.getClientHttpRequestFactory(appProps.getUsuarioDinardap(),
                    appProps.getClaveDinardap()));
            URI uri = new URI(appProps.getUrlDinardap() + "PLAYAS/persona/identificacion/" + identificacion);
            ResponseEntity<PubPersona> contribuyente = restTemplate.getForEntity(uri, PubPersona.class);
            if (contribuyente.getBody() != null) {
                //System.out.println(contribuyente.getBody().toString());
                //contribuyente.getBody().setFechaExpedicion(new Date(contribuyente.getBody().getFechaExpedicionLong()));
                //contribuyente.getBody().setFechaNacimiento(new Date(contribuyente.getBody().getFechaNacimientoLong()));
                return contribuyente.getBody();
            }
        } catch (URISyntaxException | RestClientException e) {
            System.out.println(e);
        }

        return null;
    }

}
