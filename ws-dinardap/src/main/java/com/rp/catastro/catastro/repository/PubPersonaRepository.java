package com.rp.catastro.catastro.repository;

import com.rp.catastro.catastro.entities.PubPersona;
import org.springframework.data.repository.CrudRepository;

public interface PubPersonaRepository extends CrudRepository<PubPersona, Long> {

    PubPersona findByCedRuc(String cedRuc);

}
