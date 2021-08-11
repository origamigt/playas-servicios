package com.facturacion.controller;

import com.facturacion.RestAPI;
import com.facturacion.entites.DocElectronico;
import com.facturacion.repository.DocElectronicoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping(RestAPI.docElectronicoFacturacion)
public class DocElectronicoController {

    @Autowired
    private DocElectronicoRepository docElectronicoRepository;

    @RequestMapping(value = RestAPI.docElectronicoFacturacionGET, method = RequestMethod.GET)
    public List<DocElectronico> getAllAmbientesFacturacion(){
        return docElectronicoRepository.findAll();
    }

    @RequestMapping(value =  RestAPI.docElectronicoFacturacionPOST, method = RequestMethod.POST)
    public DocElectronico guardarDocumentos(@Valid @RequestBody DocElectronico docElectronico) {
       // docElectronico.set_id(ObjectId.get());
        docElectronicoRepository.save(docElectronico);
        return docElectronico;
    }

}
