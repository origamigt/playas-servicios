package ec.gob.ventanilla.resources;

import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.AppLogs;
import ec.gob.ventanilla.repository.AppLogsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@RestController
@RequestMapping("/rpm-ventanilla/api/")
public class TramitesResource {

    @Autowired
    private AppLogsRepository appLogsRepository;

    private AppLogs appLogs;
    @Autowired
    private AppProps appProps;

    @RequestMapping(value = "/entregaTramiteAPP/tramite/{tramite}/identificacionRetira/{identificacionRetira}/usuarioSGR/{usuarioSGR}/registrador/{registrador}", method = RequestMethod.GET)
    @Async
    public ResponseEntity<?> finalizarTramiteParaSiempreAPP(@PathVariable(name = "tramite") Long tramite,
                                                            @PathVariable(name = "identificacionRetira") String identificacionRetira,
                                                            @PathVariable(name = "usuarioSGR") String usuarioSGR,
                                                            @PathVariable(name = "registrador") String registrador) {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        appLogs = new AppLogs(new Date(), "/api/entregaTramiteAPP/tramite/" + tramite + "/identificacionRetira/" + identificacionRetira
                + "/usuarioSGR/" + usuarioSGR + "/registrador/" + registrador, null, "finalizarTramiteParaSiempreAPP", request.getRemoteAddr());
        appLogsRepository.save(appLogs);
        try {
            RestTemplate restTemplate = new RestTemplate();
            String response = restTemplate.getForObject(appProps.getRpEntregaTramiteAPP() + "/entregaTramiteAPP/tramite/" + tramite + "/identificacionRetira/"
                    + identificacionRetira + "/usuarioSGR/" + usuarioSGR + "/registrador/" + registrador, String.class);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (RestClientException e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

}
