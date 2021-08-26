/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.facturacion.repository;

import com.facturacion.entites.MsgFormatoNotificacion;
import org.springframework.data.repository.CrudRepository;

/**
 *
 * @author Administrator
 */
public interface MsgFormatoNotificacionRepository extends CrudRepository<MsgFormatoNotificacion, Long> {
    
    MsgFormatoNotificacion findByTipo(Long tipo);
    
}
