package com.facturacion.repository;

import com.facturacion.entites.RespuestaComprobante;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface RespuestaComprobanteRepository extends MongoRepository<RespuestaComprobante, String> {
}
