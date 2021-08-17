/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.facturacion.repository;

import com.facturacion.entites.Cajero;
import org.springframework.data.repository.CrudRepository;

/**
 *
 * @author Administrator
 */
public interface CajeroRepository extends CrudRepository<Cajero, Long> {
    
    Cajero findByPuntoEmision(String puntoEmision);
    
}
