package com.facturacion.repository;

import com.facturacion.entites.Firma;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface FirmaRepository extends MongoRepository<Firma, String> {
}
