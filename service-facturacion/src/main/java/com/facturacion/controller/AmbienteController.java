package com.facturacion.controller;

import com.facturacion.RestAPI;
import com.facturacion.entites.Ambiente;
import com.facturacion.repository.AmbienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping(RestAPI.ambienteFacturacion)
public class AmbienteController {

    @Autowired
    private AmbienteRepository ambienteRepository;

    @RequestMapping(value = RestAPI.ambienteFacturacionGET, method = RequestMethod.GET)
    public List<Ambiente> getAllAmbientesFacturacion(){
        return ambienteRepository.findAll();
    }

    @RequestMapping(value =  RestAPI.ambienteFacturacionPOST, method = RequestMethod.POST)
    public Ambiente createPet(@Valid @RequestBody Ambiente ambiente) {
        //ambiente.set_id(ObjectId.get());
        ambienteRepository.save(ambiente);
        return ambiente;
    }

}
