package com.facturacion.repository;

import com.facturacion.entites.Directorios;
import org.springframework.data.repository.CrudRepository;

public interface DirectoriosRepository extends CrudRepository<Directorios, String> {

    Directorios findByCodigo(Integer codigo);

}
