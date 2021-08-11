package com.facturacion.controller;

import com.facturacion.RestAPI;
import com.facturacion.entites.Comprobante;
import com.facturacion.repository.ComprobanteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping(RestAPI.comprobanteFacturacion)
public class ComprobanteController {

    @Autowired
    private ComprobanteRepository comprobanteRepository;

    @RequestMapping(value = RestAPI.comprobanteFacturacionGET, method = RequestMethod.GET)
    public List<Comprobante> getAllAmbientesFacturacion(){
        return comprobanteRepository.findAll();
    }

    @RequestMapping(value =  RestAPI.comprobanteFacturacionPOST, method = RequestMethod.POST)
    public Comprobante createPet(@Valid @RequestBody Comprobante comprobante) {
        comprobanteRepository.save(comprobante);
        return comprobante;
    }

}
