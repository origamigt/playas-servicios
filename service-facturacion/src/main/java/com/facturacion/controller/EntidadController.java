package com.facturacion.controller;

import com.facturacion.RestAPI;
import com.facturacion.entites.Entidad;
import com.facturacion.repository.EntidadRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping(RestAPI.entidadFacturacion)
public class EntidadController {

    @Autowired
    private EntidadRepository entidadRepository;

    @RequestMapping(value = RestAPI.entidadFacturacionGET, method = RequestMethod.GET)
    public List<Entidad> getAllAmbientesFacturacion(){
        return entidadRepository.findAll();
    }

    @RequestMapping(value =  RestAPI.entidadFacturacionPOST, method = RequestMethod.POST)
    public Entidad createPet(@Valid @RequestBody Entidad entidad) {
        //entidad.set_id(ObjectId.get());
        entidadRepository.save(entidad);
        return entidad;
    }


}
