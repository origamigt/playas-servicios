package com.facturacion.repository;

import com.facturacion.entites.FormasPago;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface FormasPagoRepository extends MongoRepository<FormasPago, String> {

    FormasPago findByCodigo(String codigo);

}
