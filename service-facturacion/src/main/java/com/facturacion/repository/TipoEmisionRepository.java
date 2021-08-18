package com.facturacion.repository;

import com.facturacion.entites.TipoEmision;
import org.springframework.data.repository.CrudRepository;

public interface TipoEmisionRepository extends CrudRepository<TipoEmision, Long> {

    TipoEmision findByCodigo(String codigo);

}
