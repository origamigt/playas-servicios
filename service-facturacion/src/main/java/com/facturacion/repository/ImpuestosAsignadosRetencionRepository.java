package com.facturacion.repository;

import com.facturacion.entites.ImpuestosAsignadosRetencion;
import org.springframework.data.repository.CrudRepository;

public interface ImpuestosAsignadosRetencionRepository extends CrudRepository<ImpuestosAsignadosRetencion, Long> {

    ImpuestosAsignadosRetencion findByCodigo(String codigo);

}
