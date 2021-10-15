package com.facturacion.repository;

import com.facturacion.entites.comprobanterespuestasri.ComprobanteSRI;

import java.util.List;
import org.springframework.data.repository.CrudRepository;

public interface ComprobanteSRIRepository extends CrudRepository<ComprobanteSRI, Long> {

    List<ComprobanteSRI> findByContribuyente_IdemtificacionAndNumAutorizacionIsNotNullOrderByFechaAutorizacionDesc(String identificacion);

}
