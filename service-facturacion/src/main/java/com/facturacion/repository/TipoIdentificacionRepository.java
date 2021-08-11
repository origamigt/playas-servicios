package com.facturacion.repository;

import com.facturacion.entites.TipoIdentificacion;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface TipoIdentificacionRepository extends MongoRepository<TipoIdentificacion, String> {

    TipoIdentificacion findByTamanio(Integer tamanio);

}
