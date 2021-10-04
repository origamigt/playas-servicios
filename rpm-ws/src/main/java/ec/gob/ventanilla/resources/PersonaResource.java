package ec.gob.ventanilla.resources;

import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.AclUser;
import ec.gob.ventanilla.entity.AppLogs;
import ec.gob.ventanilla.entity.PubPersona;
import ec.gob.ventanilla.model.ConsultaDinardap;
import ec.gob.ventanilla.repository.AclUserRepository;
import ec.gob.ventanilla.repository.AppLogsRepository;
import ec.gob.ventanilla.repository.PubPersonaRepository;
import ec.gob.ventanilla.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Date;

@RestController
@RequestMapping("/rpm-ventanilla/api/")
public class PersonaResource {

    @Autowired
    private PubPersonaRepository personaRepository;

    @Autowired
    private AclUserRepository aclUserRepository;
    @Autowired
    private AppProps appProps;


    @RequestMapping(value = "person/update", method = RequestMethod.PUT)
    public ResponseEntity<?> updatePubPersona(@RequestBody PubPersona persona) {
        try {
            PubPersona personFind = personaRepository.findByCedRuc(persona.getCedRuc());
            personFind.setNombres(persona.getNombres());
            personFind.setApellidos(persona.getApellidos());
            personFind.setDireccion(persona.getDireccion());
            personFind.setTelefono1(persona.getTelefono1());
            personFind.setTelefono2(persona.getTelefono2());
            personFind.setCorreo1(persona.getCorreo1());
            personaRepository.save(personFind);
            AclUser u = aclUserRepository.findTopByPersona_CedRuc(personFind.getCedRuc());
            return new ResponseEntity<>(u, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "persona/actualizar", method = RequestMethod.POST)
    public ResponseEntity<?> actualzarPersona(@RequestBody PubPersona persona) {
        try {
            PubPersona personFind = personaRepository.findByCedRuc(persona.getCedRuc());
            personFind.setDireccion(persona.getDireccion());
            personFind.setTelefono1(persona.getTelefono1());
            personFind.setTelefono2(persona.getTelefono2());
            personFind.setCorreo1(persona.getCorreo1());
            personaRepository.save(personFind);
            return new ResponseEntity<>(personFind, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>( HttpStatus.ACCEPTED);
        }
    }

    @RequestMapping(value = "persona/actualizarCorreo", method = RequestMethod.POST)
    public ResponseEntity<?> actualzarCorreo(@RequestBody PubPersona persona) {
        try {
            PubPersona personFind = personaRepository.findByCedRuc(persona.getCedRuc());
            personFind.setCorreo1(persona.getCorreo1());
            personaRepository.save(personFind);
            return new ResponseEntity<>(personFind, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }


    @RequestMapping(value = "consultarPersona", method = RequestMethod.POST)
    public ResponseEntity<PubPersona> consultarPersonaDinardap(@RequestBody ConsultaDinardap consulta) {

        try {
            Boolean estaRegistrado;
            Long idPersona = null;
            PubPersona persona = personaRepository.findByCedRuc(consulta.getIdentificacion());
            if (persona == null) {
                estaRegistrado = Boolean.FALSE;
            } else if (persona.getFechaExpedicion() == null) {
                estaRegistrado = Boolean.FALSE;
                idPersona = persona.getId();
            } else {
                estaRegistrado = Boolean.TRUE;
            }
            if (!estaRegistrado) {
                RestTemplate restTemplate = new RestTemplate(Util.getClientHttpRequestFactory(appProps.getUsuarioDinardap(),
                        appProps.getClaveDinardap()));
                URI uri = new URI(appProps.getUrlDinardap() + consulta.getAplicacion() + "/persona/identificacion/" + consulta.getIdentificacion());
                System.out.println(appProps.getUrlDinardap() + consulta.getAplicacion() + "/persona/identificacion/" + consulta.getIdentificacion());
                ResponseEntity<PubPersona> contribuyente = restTemplate.getForEntity(uri, PubPersona.class);
                if (contribuyente.getBody() != null) {
                    if (idPersona != null) {
                        if (persona.getFechaExpedicion() == null) {
                            if (persona.getFechaExpedicionLong() != null) {
                                persona.setFechaExpedicion(new Date(contribuyente.getBody().getFechaExpedicionLong()));
                            }
                        }
                        if (persona.getFechaNacimiento() == null) {
                            if (persona.getFechaNacimientoLong() != null) {
                                persona.setFechaNacimiento(new Date(contribuyente.getBody().getFechaNacimientoLong()));
                            }
                        }
                        personaRepository.save(persona);
                    }
                }
                return new ResponseEntity<>(contribuyente.getBody(), HttpStatus.OK);
            } else {
                persona.setFechaExpedicionLong(persona.getFechaExpedicion().getTime());
                return new ResponseEntity<>(persona, HttpStatus.OK);
            }

        } catch (URISyntaxException | RestClientException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.ACCEPTED);
        }

    }

}
