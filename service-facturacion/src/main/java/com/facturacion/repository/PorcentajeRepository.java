package com.facturacion.repository;

import com.facturacion.entites.Porcentajes;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface PorcentajeRepository extends MongoRepository<Porcentajes, String> {

    Porcentajes findByCodigoAndValorPorcentaje(String codigo, Double valorPorcentaje);

}
