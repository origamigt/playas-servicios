package ec.gob.ventanilla.resources;

import com.google.gson.Gson;
import ec.gob.ventanilla.async.PayPhoneService;
import ec.gob.ventanilla.entity.AppLogs;
import ec.gob.ventanilla.entity.PubSolicitud;
import ec.gob.ventanilla.model.payphone.CreateBtn;
import ec.gob.ventanilla.model.payphone.ResponseBtn;
import ec.gob.ventanilla.model.payphone.ResponseCreate;
import ec.gob.ventanilla.model.payphone.Tarjeta;
import ec.gob.ventanilla.repository.AppLogsRepository;
import ec.gob.ventanilla.repository.PubSolicitudRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@RestController
@RequestMapping("/rpm-ventanilla/api/pagos/")
//@Service
public class TarjetaResource {

    @Autowired
    private PubSolicitudRepository pubSolicitudRepository;
    @Autowired
    private PayPhoneService payPhoneService;



    @RequestMapping(value = "/tarjeta", method = RequestMethod.POST)
    public ResponseEntity<PubSolicitud> pagoEnLineaPayPhone(@RequestBody Tarjeta tarjeta) {
         PubSolicitud pubSolicitud = pubSolicitudRepository.findById(tarjeta.getIdSolicitud()).get();
        pubSolicitud.setEstado("A");
        pubSolicitud = pubSolicitudRepository.save(pubSolicitud);
        payPhoneService.payOnlinePayPhone(tarjeta, pubSolicitud);
        return new ResponseEntity<>(pubSolicitud, HttpStatus.OK);
    }

    @RequestMapping(value = "reverso/solicitud/{solicitud}", method = RequestMethod.GET)
    public ResponseEntity<Integer> pagoEnLineaPayPhone(@PathVariable Integer solicitud) {

        // payPhoneService.reverseOnlinePayPhone(solicitud.longValue());
        return new ResponseEntity<>(solicitud, HttpStatus.OK);
    }

    @RequestMapping(value = "generarLinkPago", method = RequestMethod.POST)
    public ResponseEntity<PubSolicitud> linkPagoPayPhone(@RequestBody PubSolicitud pubSolicitud) {
        if (pubSolicitud.getNumeroTramite() != null) {
            PubSolicitud solicitudBD = pubSolicitudRepository.findByNumeroTramite(pubSolicitud.getNumeroTramite());
            solicitudBD.setTotal(pubSolicitud.getTotal());
            CreateBtn response = payPhoneService.linkPagoPayPhone(solicitudBD);
            if (response != null && response.getPaymentId() != null) {
                solicitudBD.setLinkPago(response.getPayWithCard());
                solicitudBD.setPayWithPayPhone(response.getPayWithPayPhone());
                solicitudBD.setPaymentId(response.getPaymentId());

                pubSolicitud.setLinkPago(response.getPayWithCard());
                pubSolicitud.setPayWithPayPhone(response.getPayWithPayPhone());
                pubSolicitud.setPaymentId(response.getPaymentId());
            } else {
                solicitudBD.setLinkPago("");
                pubSolicitud.setLinkPago("");
            }

            pubSolicitudRepository.save(solicitudBD);
        }

        return new ResponseEntity<>(pubSolicitud, HttpStatus.OK);
    }

    @RequestMapping(value = "verificarPago", method = RequestMethod.POST)
    public ResponseEntity<ResponseCreate> verificarPago(@RequestBody ResponseBtn responseBtn) {
        return new ResponseEntity<>(payPhoneService.verificarPagoBtn(responseBtn), HttpStatus.OK);
    }

}
