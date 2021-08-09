/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.ventanilla.async;

import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.Acto;
import ec.gob.ventanilla.model.ActoRequisito;
import ec.gob.ventanilla.repository.ActoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;

/**
 *
 * @author ORIGAMI
 */
@Service
public class ActoServices {

    @Autowired
    private AppProps appProps;
    @Autowired
    private ActoRepository actoRepository;

    public List<Acto> findAll() {
        List<Acto> actos = actoRepository.findAllByCertificadoOrderByOrdenAsc(Boolean.TRUE);
        for (Acto a : actos) {
            a.setCertificadoNoPoseerBien(a.getId() == 114 ? Boolean.TRUE : Boolean.FALSE);
        }
        return actos;
    }

    public List<Acto> findActoInscripciones() {

        RestTemplate restTemplate = new RestTemplate();
        Acto[] actosRest = restTemplate.getForObject(appProps.getRpActosInscripciones(), Acto[].class);
        List<Acto> actos = Arrays.asList(actosRest);
        return actos;
    }

    public List<ActoRequisito> findActoRequisitos(Integer acto) {
        System.out.println(appProps.getRpActosInscripciones() + "/acto/" + acto);
        RestTemplate restTemplate = new RestTemplate();
        ActoRequisito[] actosRest = restTemplate.getForObject(appProps.getRpActosInscripciones() + "/acto/" + acto, ActoRequisito[].class);
        List<ActoRequisito> actos = Arrays.asList(actosRest);
        return actos;
    }

    public Acto findById(Integer id) {
        Acto acto = actoRepository.findById(id).get();
        acto.setCertificadoNoPoseerBien(acto.getId() == 114 ? Boolean.TRUE : Boolean.FALSE);
        return acto;
    }

}
