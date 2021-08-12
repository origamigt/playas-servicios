package com.facturacion.controller;

import com.facturacion.RestAPI;
import com.facturacion.entites.Porcentajes;
import com.facturacion.repository.PorcentajeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(RestAPI.porcentajeIVAFacturacion)
public class PorcentajesController {

    @Autowired
    private PorcentajeRepository porcentajeRepository;

    @RequestMapping(value = RestAPI.porcentajeIVAFacturacionPOST, method = RequestMethod.POST)
    public Porcentajes guardarPorcentajeIVAFacturacion(@RequestBody Porcentajes porcentajeIVA){
        porcentajeRepository.save(porcentajeIVA);
        return porcentajeIVA;
    }

}
