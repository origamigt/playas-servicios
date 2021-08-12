package com.facturacion.repository;

import com.facturacion.entites.Porcentajes;
import org.springframework.data.repository.CrudRepository;

public interface PorcentajeRepository extends CrudRepository<Porcentajes, Long> {

    Porcentajes findByCodigoTarifaAndPorcentaje(String codigo, Double valorPorcentaje);

}
