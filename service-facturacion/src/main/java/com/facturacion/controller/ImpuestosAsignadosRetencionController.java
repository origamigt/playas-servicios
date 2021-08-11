package com.facturacion.controller;

import com.facturacion.RestAPI;
import com.facturacion.entites.ImpuestosAsignadosRetencion;
import com.facturacion.repository.ImpuestosAsignadosRetencionRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
@RequestMapping(RestAPI.impuestosAsignadosRetencionFacturacion)
public class ImpuestosAsignadosRetencionController {

    @Autowired
    private ImpuestosAsignadosRetencionRepository impuestosAsignadosRetencionRepository;

    @RequestMapping(value =  RestAPI.impuestosAsignadosRetencionFacturacionPOST, method = RequestMethod.POST)
    public ImpuestosAsignadosRetencion createPet(@Valid @RequestBody ImpuestosAsignadosRetencion impuestosAsignadosRetencion) {
        impuestosAsignadosRetencion.set_id(ObjectId.get());
        impuestosAsignadosRetencionRepository.save(impuestosAsignadosRetencion);
        return impuestosAsignadosRetencion;
    }

}
