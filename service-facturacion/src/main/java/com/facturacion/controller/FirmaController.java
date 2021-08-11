package com.facturacion.controller;

import com.facturacion.RestAPI;
import com.facturacion.entites.Firma;
import com.facturacion.repository.FirmaRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping(RestAPI.firmaFacturacion)
public class FirmaController {

    @Autowired
    private FirmaRepository firmaRepository;

    @RequestMapping(value = RestAPI.firmaFacturacionGET, method = RequestMethod.GET)
    public List<Firma> getAllAmbientesFacturacion(){
        return firmaRepository.findAll();
    }

    @RequestMapping(value =  RestAPI.firmaFacturacionPOST, method = RequestMethod.POST)
    public Firma createPet(@Valid @RequestBody Firma firma) {
       // firma.set_id(ObjectId.get());
        firmaRepository.save(firma);
        return firma;
    }

}
