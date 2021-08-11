package com.facturacion.repository;

import com.facturacion.entites.Comprobante;
import java.util.List;
import org.springframework.data.repository.CrudRepository;

public interface ComprobanteRepository extends CrudRepository<Comprobante, Long> {
    
    @Override
    List<Comprobante> findAll();
    
}
