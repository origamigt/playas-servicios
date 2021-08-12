package com.facturacion.controller;

import com.facturacion.RestAPI;
import com.facturacion.entites.FormasPago;
import com.facturacion.repository.FormasPagoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
@RequestMapping(RestAPI.formasPagoControllerFacturacion)
public class FormasPagoController {

    @Autowired
    private FormasPagoRepository formasPagoRepository;

    @RequestMapping(value = RestAPI.formasPagoControllerFacturacionPOST, method = RequestMethod.POST)
    public FormasPago formasPagoControllerFacturacionPOST(@Valid @RequestBody FormasPago formasPago){
        //formasPago.set_id(ObjectId.get());
        formasPagoRepository.save(formasPago);
        return formasPago;
    }



}
