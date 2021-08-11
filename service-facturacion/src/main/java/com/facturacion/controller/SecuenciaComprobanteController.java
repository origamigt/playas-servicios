package com.facturacion.controller;

import com.facturacion.RestAPI;
import com.facturacion.entites.SecuenciaComprobante;
import com.facturacion.repository.SecuenciaComprobanteRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(RestAPI.secuenciaComprobanteControllerFacturacion)
public class SecuenciaComprobanteController {

    @Autowired
    private SecuenciaComprobanteRepository secuenciaComprobanteRepository;

    @RequestMapping(value = RestAPI.secuenciaComprobanteFacturacionPOST, method = RequestMethod.POST)
    public SecuenciaComprobante guardarSecuenciaComprobanteControllerFacturacion(@RequestBody SecuenciaComprobante secuenciaComprobante) {
        secuenciaComprobante.set_id(ObjectId.get());
        secuenciaComprobanteRepository.save(secuenciaComprobante);
        return secuenciaComprobante;
    }




}
