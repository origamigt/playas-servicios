package com.facturacion.repository;

import com.facturacion.entites.Usuarios;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface UsuariosRepository extends MongoRepository<Usuarios, String> {
}
