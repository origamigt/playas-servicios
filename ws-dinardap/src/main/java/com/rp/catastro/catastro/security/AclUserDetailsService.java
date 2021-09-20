package com.rp.catastro.catastro.security;

import com.rp.catastro.catastro.entities.AclUser;
import com.rp.catastro.catastro.repository.AclUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.security.core.userdetails.User;

@Component
public class AclUserDetailsService implements UserDetailsService {

    @Autowired
    private AclUserRepository aclUserRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        AclUser aclUser = aclUserRepository.findByUsuario(username);
        System.out.println("aclUser " + aclUser.toString());
        if (aclUser == null) {
            throw new UsernameNotFoundException(String.format("Usuario no encontrado", username));
        }

        UserDetails userDetails = User.withUsername(aclUser.getUsuario())
                .password(aclUser.getClave())
                .roles("USER").build();
        return userDetails;
    }
}
