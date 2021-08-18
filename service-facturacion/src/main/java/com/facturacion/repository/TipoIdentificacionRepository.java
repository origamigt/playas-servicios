package com.facturacion.repository;

import com.facturacion.entites.TipoIdentificacion;
import org.springframework.data.repository.CrudRepository;

public interface TipoIdentificacionRepository extends CrudRepository<TipoIdentificacion, Long> {

    TipoIdentificacion findByTamanio(Integer tamanio);

}
