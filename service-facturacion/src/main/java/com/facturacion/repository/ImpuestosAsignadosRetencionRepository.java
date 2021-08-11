package com.facturacion.repository;

import com.facturacion.entites.ImpuestosAsignadosRetencion;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ImpuestosAsignadosRetencionRepository extends MongoRepository<ImpuestosAsignadosRetencion, String> {

    ImpuestosAsignadosRetencion findByCodigo(String codigo);

}
