package com.facturacion.repository;

import com.facturacion.entites.Ambiente;
import java.util.List;
import org.springframework.data.repository.CrudRepository;

public interface AmbienteRepository extends CrudRepository<Ambiente, Long> {
    
    @Override
    List<Ambiente> findAll();
    
    Ambiente findByCodigo(String codigo);
    
}
