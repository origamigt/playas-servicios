package com.facturacion.controller;

import com.facturacion.RestAPI;
import com.facturacion.entites.TipoIdentificacion;
import com.facturacion.repository.TipoIdentificacionRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
@RequestMapping(RestAPI.tipoIdentificacionFacturacion)
public class TipoIdentificacionController {

    @Autowired
    private TipoIdentificacionRepository tipoIdentificacionRepository;

    @RequestMapping(value =  RestAPI.tipoIdentificacionFacturacionPOST, method = RequestMethod.POST)
    public TipoIdentificacion createPet(@Valid @RequestBody TipoIdentificacion tipoIdentificacion) {
        tipoIdentificacion.set_id(ObjectId.get());
        tipoIdentificacionRepository.save(tipoIdentificacion);
        return tipoIdentificacion;
    }

}
