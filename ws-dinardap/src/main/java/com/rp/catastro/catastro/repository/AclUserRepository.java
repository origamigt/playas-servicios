package com.rp.catastro.catastro.repository;


import com.rp.catastro.catastro.entities.AclUser;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

public interface AclUserRepository extends CrudRepository<AclUser, Integer> {

    AclUser findByUsuarioAndClave(String usuario, String clave);

    AclUser findByUsuario(String username);



}
