package com.facturacion.controller;

import com.facturacion.RestAPI;
import com.facturacion.entites.Directorios;
import com.facturacion.repository.DirectoriosRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(RestAPI.directorioFacturacion)
public class DirectoriosController {

    @Autowired
    private DirectoriosRepository directoriosRepository;

    @RequestMapping(value = RestAPI.directorioFacturacionPOST, method = RequestMethod.POST)
    public Directorios guardarDirectorioFacturacion(@RequestBody Directorios directorios){
        //directorios.set_id(ObjectId.get());
        directoriosRepository.save(directorios);
        return directorios;
    }
}
