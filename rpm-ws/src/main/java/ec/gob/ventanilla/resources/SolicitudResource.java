package ec.gob.ventanilla.resources;

import com.google.gson.Gson;
import ec.gob.ventanilla.async.SolicitudServices;
import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.AppLogs;
import ec.gob.ventanilla.entity.PubSolicitud;
import ec.gob.ventanilla.model.DatosProforma;
import ec.gob.ventanilla.repository.ActoRepository;
import ec.gob.ventanilla.repository.AppLogsRepository;
import ec.gob.ventanilla.repository.PubSolicitudRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/rpm-ventanilla/api/solicitud/")
@Service
public class SolicitudResource {

    @Autowired
    private PubSolicitudRepository pubSolicitudRepository;

    @Autowired
    private ActoRepository actoRepository;

    @Autowired
    private SolicitudServices services;

    @Autowired
    private AppLogsRepository appLogsRepository;

    private AppLogs appLogs;

    private Gson gson;
    @Autowired
    private AppProps appProps;

    @RequestMapping(value = "registrarCertificado", method = RequestMethod.POST)
    public ResponseEntity<?> registroSolicitud(@RequestBody PubSolicitud pubSolicitud) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();
        gson = new Gson();
        appLogs = new AppLogs(new Date(), "/api/solicitud/registrar/" + gson.toJson(pubSolicitud), null, "registroSolicitud", request.getRemoteAddr());
        appLogsRepository.save(appLogs);

        try {
            pubSolicitud = services.registrarSolicitudCertificados(pubSolicitud);
            return new ResponseEntity<>(pubSolicitud, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "registrarInscripcion", method = RequestMethod.POST)
    public ResponseEntity<?> registroSolicitudInscripcion(@RequestBody PubSolicitud pubSolicitud) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        gson = new Gson();
        appLogs = new AppLogs(new Date(), "/api/solicitud/registrarInscripcion" + gson.toJson(pubSolicitud), null, "registrarInscripcion", request.getRemoteAddr());
        appLogsRepository.save(appLogs);

        try {
            pubSolicitud = services.registrarSolicitudInscripciones(pubSolicitud);
            return new ResponseEntity<>(pubSolicitud, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "solicitudes/usuario", method = RequestMethod.GET)
    public ResponseEntity<List<PubSolicitud>> getSolicitudesByUsuario(
            @RequestParam(value = "userId") Integer userId, Pageable pageable) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        appLogs = new AppLogs(new Date(), "/api/solicitud/solicitudes/usuario/", null, "getSolicitudesByUsuario", request.getRemoteAddr());
        appLogsRepository.save(appLogs);

        Page<PubSolicitud> findPubSolicitudByUserId = pubSolicitudRepository.findPubSolicitudByUserId(userId, pageable);
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.add("totalPages", String.valueOf(findPubSolicitudByUserId.getTotalPages()));
        responseHeaders.add("rootSize", String.valueOf(pubSolicitudRepository.count()));
        return new ResponseEntity<>(findPubSolicitudByUserId.getContent(), responseHeaders, HttpStatus.OK);
    }

    @RequestMapping(value = "solicitudes/movil/usuario/{usuario}", method = RequestMethod.GET)
    public ResponseEntity<List<PubSolicitud>> getSolicitudesMovilByUsuario(@PathVariable Integer usuario) {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        appLogs = new AppLogs(new Date(), "/api/solicitud/solicitudes/movil/usuario/" + usuario, null, "getSolicitudesMovilByUsuario", request.getRemoteAddr());
        appLogsRepository.save(appLogs);

        List<PubSolicitud> pubSolicituds = pubSolicitudRepository.findPubSolicitudByUserId(usuario);
        if (pubSolicituds != null && !pubSolicituds.isEmpty()) {
            for (PubSolicitud solicitud : pubSolicituds) {
                solicitud.setActo(actoRepository.findById(solicitud.getTipoSolicitud()).get().getActo());
            }
        } else {
            pubSolicituds = new ArrayList<>();
        }

        return new ResponseEntity<>(pubSolicituds, HttpStatus.OK);
    }

    @RequestMapping(value = "consultar/tramite/{numtramite}", method = RequestMethod.GET)
    public ResponseEntity<?> consultaTramitesByNumTramite(@PathVariable(name = "numtramite") Integer numtramite) {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        appLogs = new AppLogs(new Date(), "/api/solicitud/consultar/tramite/" + numtramite, null, "consultaTramitesByNumTramite", request.getRemoteAddr());
        appLogsRepository.save(appLogs);

        try {
            RestTemplate restTemplate = new RestTemplate();
            DatosProforma response = restTemplate.getForObject(appProps.getRpConsultarTramite() + numtramite, DatosProforma.class);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (RestClientException e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "consulta/tramites/cedula/{documento}", method = RequestMethod.GET)
    public ResponseEntity<?> consultaTramitesByCedula(@PathVariable(name = "documento") String documento) {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        appLogs = new AppLogs(new Date(), "/api/solicitud/consulta/tramites/cedula/" + documento, null, "consultaTramitesByCedula", request.getRemoteAddr());
        appLogsRepository.save(appLogs);

        try {
            RestTemplate restTemplate = new RestTemplate();
            String urlConsultarTramiteRP = appProps.getRpConsultarTramite() + documento;
            String response = restTemplate.getForObject(urlConsultarTramiteRP, String.class);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (RestClientException e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "findAll", method = RequestMethod.GET)
    public ResponseEntity<List<PubSolicitud>> findAll(Pageable pageable) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        appLogs = new AppLogs(new Date(), "/api/solicitud/finaAll/" + pageable, null, "findAll", request.getRemoteAddr());
        appLogsRepository.save(appLogs);
        Page<PubSolicitud> pubSolicituds = pubSolicitudRepository.findAll(pageable);
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.add("totalPages", String.valueOf(pubSolicituds.getTotalPages()));
        responseHeaders.add("rootSize", String.valueOf(pubSolicitudRepository.count()));
        return new ResponseEntity<>(pubSolicituds.getContent(), responseHeaders, HttpStatus.OK);
    }

    @RequestMapping(value = "actualizarSolicitudObservacion", method = RequestMethod.POST)
    public ResponseEntity<?> actualizarSolicitudObservacion(@RequestBody PubSolicitud pubSolicitud) {

        try {
            pubSolicitud = services.actualizarSolicitudObservacion(pubSolicitud);
            return new ResponseEntity<>(pubSolicitud, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "buscarTramite", method = RequestMethod.POST)
    public ResponseEntity<?> buscarTramite(@RequestBody PubSolicitud pubSolicitud) {

        try {
            pubSolicitud = services.buscarTramite(pubSolicitud);
            return new ResponseEntity<>(pubSolicitud, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "actualizarRequisitos", method = RequestMethod.POST)
    public ResponseEntity<?> actualizarRequisitos(@RequestBody PubSolicitud pubSolicitud) {

        try {
            pubSolicitud = services.actualizarRequisitos(pubSolicitud);
            return new ResponseEntity<>(pubSolicitud, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "registrarPagoEnLina", method = RequestMethod.POST)
    public ResponseEntity<?> registrarPagoEnLina(@RequestBody PubSolicitud pubSolicitud) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();
        gson = new Gson();
        appLogs = new AppLogs(new Date(), "/api/solicitud/registrarPagoEnLina/" + gson.toJson(pubSolicitud), null, "registrarPagoEnLina", request.getRemoteAddr());
        appLogsRepository.save(appLogs);

        try {
            if (pubSolicitud.getTipoSolicitud() > 0) {
                pubSolicitud = services.registrarSolicitudCertificadosPagoEnLinea(pubSolicitud);
            } else {
                pubSolicitud = services.registrarSolicitudInscripcionesPagoEnLinea(pubSolicitud);
            }
            return new ResponseEntity<>(pubSolicitud, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "actualizarTramiteInscripcion", method = RequestMethod.POST)
    public ResponseEntity<PubSolicitud> linkPagoPayPhone(@RequestBody PubSolicitud pubSolicitud) {
        if (pubSolicitud.getNumeroTramite() != null && pubSolicitud.getNumeroTramiteInscripcion() != null) {
            PubSolicitud solicitudBD = pubSolicitudRepository.findByNumeroTramite(pubSolicitud.getNumeroTramite());
            solicitudBD.setNumeroTramiteInscripcion(pubSolicitud.getNumeroTramiteInscripcion());
            pubSolicitudRepository.save(solicitudBD);
        }

        return new ResponseEntity<>(pubSolicitud, HttpStatus.OK);
    }

}
