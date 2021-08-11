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
public class PubPersonaResource {

    @Autowired
    private PubPersonaRepository personaRepository;

    @Autowired
    private AclUserRepository aclUserRepository;
    @Autowired
    private AppProps appProps;
    @Autowired
    private AppLogsRepository appLogsRepository;

    private AppLogs appLogs;

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
            personFind.setNombres(persona.getNombres());
            personFind.setApellidos(persona.getApellidos());
            personFind.setDireccion(persona.getDireccion());
            personFind.setTelefono1(persona.getTelefono1());
            personFind.setTelefono2(persona.getTelefono2());
            personaRepository.save(personFind);
            return new ResponseEntity<>(personFind, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
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
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "rpl/persona/aplicacion/{aplicacion}/codigoPaquete/{codigoPaquete}/identificacion/{identificacion}",
            method = RequestMethod.GET)
    public ResponseEntity<PubPersona> findEnte(@PathVariable(value = "aplicacion") String aplicacion,
                                               @PathVariable(value = "codigoPaquete") String codigoPaquete,
                                               @PathVariable(value = "identificacion") String identificacion) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        appLogs = new AppLogs(new Date(), "/api/rpl/persona/aplicacion/" + aplicacion + "/codigoPaquete/" + codigoPaquete + "/identificacion/" + identificacion, null, "findEnte", request.getRemoteAddr());
        appLogsRepository.save(appLogs);

        try {
            Boolean estaRegistrado;
            Long idPersona = null;
            PubPersona persona = personaRepository.findByCedRuc(identificacion);
            if (persona == null) {
                estaRegistrado = Boolean.FALSE;
            } else if (persona.getFechaExpedicion() == null) {
                estaRegistrado = Boolean.FALSE;
                idPersona = persona.getId();
            } else {
                estaRegistrado = Boolean.TRUE;
            }
            if (!estaRegistrado) {
                RestTemplate restTemplate = new RestTemplate(Util.getClientHttpRequestFactory(appProps.getUserSgr(),
                        appProps.getPassSgr()));
                URI uri = new URI(appProps.getUrlPersona() + aplicacion + "/codigoPaquete/" + codigoPaquete
                        + "/identificacion/" + identificacion);
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
                System.out.println("persona: " + persona);
                return new ResponseEntity<>(persona, HttpStatus.OK);
            }

        } catch (URISyntaxException | RestClientException e) {
            System.out.println(e);
        }
        return new ResponseEntity<>(null, HttpStatus.OK);
    }

    @RequestMapping(value = "consultarPersona",
            method = RequestMethod.POST)
    public ResponseEntity<PubPersona> consultarPersonaDinardap(@RequestBody ConsultaDinardap consulta) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        appLogs = new AppLogs(new Date(), "/api/rpl/persona/aplicacion/" + consulta.getAplicacion() + "/codigoPaquete/" + consulta.getCodigoPaquete() + "/identificacion/" + consulta.getIdentificacion(), null, "findEnte", request.getRemoteAddr());
        appLogsRepository.save(appLogs);

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
                RestTemplate restTemplate = new RestTemplate(Util.getClientHttpRequestFactory(appProps.getUserSgr(),
                        appProps.getPassSgr()));
                URI uri = new URI(appProps.getUrlPersona() + consulta.getAplicacion() + "/codigoPaquete/" + consulta.getCodigoPaquete()
                        + "/identificacion/" + consulta.getIdentificacion());
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
                System.out.println("persona: " + persona);
                return new ResponseEntity<>(persona, HttpStatus.OK);
            }

        } catch (URISyntaxException | RestClientException e) {
            System.out.println(e);
        }
        return new ResponseEntity<>(null, HttpStatus.OK);
    }

}
