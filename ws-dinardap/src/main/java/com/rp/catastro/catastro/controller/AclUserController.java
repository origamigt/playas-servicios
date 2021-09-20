package com.rp.catastro.catastro.controller;

import com.rp.catastro.catastro.entities.AclUser;
import com.rp.catastro.catastro.repository.AclUserRepository;
import com.rp.catastro.catastro.security.MD5PasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/rpl/usuario")
public class AclUserController {

    @Autowired
    private AclUserRepository aclUserRepository;

    @RequestMapping(value = "/loginUser", method = RequestMethod.POST)
    public ResponseEntity<?> login(@RequestBody AclUser user) {
        AclUser aclUser = aclUserRepository.findByUsuarioAndClave(user.getUsuario(),  new MD5PasswordEncoder().encode(user.getClave()));
        if (aclUser != null) {
            System.out.println("aclUser " + aclUser.getRegistrador());
            return new ResponseEntity<>(aclUser, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }
    }



}
