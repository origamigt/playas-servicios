package com.facturacion.repository;

import com.facturacion.entites.SecuenciaComprobante;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.math.BigInteger;

public interface SecuenciaComprobanteRepository extends MongoRepository<SecuenciaComprobante, String> {

    SecuenciaComprobante findFirstByComprobante_CodigoOrderBySecuenciaDesc(String codigo);

}
