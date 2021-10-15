/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.ventanilla.resources;

//import com.google.gson.Gson;

import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.AppLogs;
import ec.gob.ventanilla.model.facturacionelectronica.ComprobanteSRI;
import ec.gob.ventanilla.repository.AppLogsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author gutya
 */
@RestController
@RequestMapping("/rpm-ventanilla/api/facturacionElectronica/")
public class FacturacionResource {

    @Autowired
    private AppProps appProps;


    @RequestMapping(value = "consultaFacturasContribuyente/{identificacion}", method = RequestMethod.GET)
    public ResponseEntity<List<ComprobanteSRI>> findAllFacturas(@PathVariable String identificacion) {
        try {
            RestTemplate restTemplate = new RestTemplate();
            URI uri = new URI(appProps.getRpFacturas() + identificacion);
            ResponseEntity<ComprobanteSRI[]> facturas
                    = restTemplate.getForEntity(uri, ComprobanteSRI[].class);
            if (facturas != null) {
                if (facturas.getBody() != null) {
                    List<ComprobanteSRI> comprobanteSRI = Arrays.asList(facturas.getBody());
                    return new ResponseEntity<>(comprobanteSRI, HttpStatus.OK);
                } else {
                    return new ResponseEntity<>(null, HttpStatus.OK);
                }
            } else {
                return new ResponseEntity<>(null, HttpStatus.OK);
            }
        } catch (URISyntaxException | RestClientException ex) {
            Logger.getLogger(FacturacionResource.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
