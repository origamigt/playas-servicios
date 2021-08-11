package com.facturacion.controller;

import com.facturacion.RestAPI;
import com.facturacion.entites.FirmaDocElectronico;
import com.facturacion.repository.FirmaDocElectronicoRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping(RestAPI.firmaDocElectronicoFacturacion)
public class FirmaDocElectronicoController {

    @Autowired
    private FirmaDocElectronicoRepository firmaDocElectronicoRepository;


    @RequestMapping(value = RestAPI.firmaDocElectronicoFacturacionGET, method = RequestMethod.GET)
    public List<FirmaDocElectronico> getAllAmbientesFacturacion(){
        return firmaDocElectronicoRepository.findAll();
    }

    @RequestMapping(value =  RestAPI.firmaDocElectronicoFacturacionPOST, method = RequestMethod.POST)
    public FirmaDocElectronico createPet(@Valid @RequestBody FirmaDocElectronico firmaDocElectronico) {
        firmaDocElectronico.set_id(ObjectId.get());
        firmaDocElectronico.setPuntoEmision(String.format("%03d", Long.valueOf(firmaDocElectronico.getPuntoEmision())));
        firmaDocElectronicoRepository.save(firmaDocElectronico);
        return firmaDocElectronico;
    }

}
