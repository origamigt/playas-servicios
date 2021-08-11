package com.facturacion.repository;

import com.facturacion.entites.MsgFormatoNotificacion;
import org.springframework.data.repository.CrudRepository;

public interface MsgFormatoNotificacionRepository extends CrudRepository<MsgFormatoNotificacion, String> {

    MsgFormatoNotificacion findTopByAsuntoIsNotNull();

}
