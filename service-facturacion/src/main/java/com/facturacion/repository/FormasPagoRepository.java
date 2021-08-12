package com.facturacion.repository;

import com.facturacion.entites.FormasPago;
import org.springframework.data.repository.CrudRepository;

public interface FormasPagoRepository extends CrudRepository<FormasPago, Long> {

    FormasPago findByCodigo(String codigo);

}
