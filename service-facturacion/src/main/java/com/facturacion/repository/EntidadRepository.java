package com.facturacion.repository;

import com.facturacion.entites.Entidad;
import java.util.List;
import org.springframework.data.repository.CrudRepository;

public interface EntidadRepository extends CrudRepository<Entidad, Long> {
    
    @Override
    List<Entidad> findAll();
    
}
