package com.facturacion.repository;

import com.facturacion.entites.DocElectronico;
import java.util.List;
import org.springframework.data.repository.CrudRepository;

public interface DocElectronicoRepository extends CrudRepository<DocElectronico, Long> {

    @Override
    List<DocElectronico> findAll();
    
}
