package ec.gob.ventanilla.resources;

import com.google.gson.Gson;
import ec.gob.ventanilla.async.SolicitudServices;
import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.Acto;
import ec.gob.ventanilla.entity.AppLogs;
import ec.gob.ventanilla.entity.PubSolicitud;
import ec.gob.ventanilla.entity.SolicitudRequisito;
import ec.gob.ventanilla.model.ActoRequisito;
import ec.gob.ventanilla.model.DatosProforma;
import ec.gob.ventanilla.repository.ActoRepository;
import ec.gob.ventanilla.repository.AppLogsRepository;
import ec.gob.ventanilla.repository.PubSolicitudRepository;
import ec.gob.ventanilla.repository.SolicitudRequisitoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
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
import java.util.Optional;

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
    private AppProps appProps;

    @RequestMapping(value = "registrarCertificado", method = RequestMethod.POST)
    public ResponseEntity<?> registroSolicitud(@RequestBody PubSolicitud pubSolicitud) {
        try {
            pubSolicitud = services.registrarSolicitudCertificados(pubSolicitud);
            return new ResponseEntity<>(pubSolicitud, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "registrarInscripcion", method = RequestMethod.POST)
    public ResponseEntity<?> registroSolicitudInscripcion(@RequestBody PubSolicitud pubSolicitud) {
        try {
            pubSolicitud = services.registrarSolicitudInscripciones(pubSolicitud);
            return new ResponseEntity<>(pubSolicitud, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "solicitudes/usuario/{usuario}", method = RequestMethod.GET)
    public ResponseEntity<List<PubSolicitud>> getSolicitudesMovilByUsuario(@PathVariable Integer usuario) {

        List<PubSolicitud> pubSolicituds = pubSolicitudRepository.findPubSolicitudByUser(usuario, PageRequest.of(0, 50));
        if (pubSolicituds != null && !pubSolicituds.isEmpty()) {
            for (PubSolicitud solicitud : pubSolicituds) {
                Optional<Acto> acto =actoRepository.findById(solicitud.getTipoSolicitud());
                acto.ifPresent(value -> solicitud.setActo(value.getActo()));

            }
        } else {
            pubSolicituds = new ArrayList<>();
        }
        System.out.println(pubSolicituds.size());
        return new ResponseEntity<>(pubSolicituds, HttpStatus.OK);
    }

    @RequestMapping(value = "consultar/tramite/{numtramite}", method = RequestMethod.GET)
    public ResponseEntity<?> consultaTramitesByNumTramite(@PathVariable(name = "numtramite") Integer numtramite) {
        try {
            RestTemplate restTemplate = new RestTemplate();
            DatosProforma response = restTemplate.getForObject(appProps.getRpConsultarTramite() + numtramite, DatosProforma.class);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (RestClientException e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
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

    @RequestMapping(value = "solicitudes/requisitos/usuario/{usuario}", method = RequestMethod.GET)
    public ResponseEntity<List<ActoRequisito>> getRequisitosByUsuario(@PathVariable Integer usuario) {
        return new ResponseEntity<>(services.requisitosUsuarios(usuario), HttpStatus.OK);
    }

}
