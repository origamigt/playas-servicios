package ec.gob.ventanilla.security;


import ec.gob.ventanilla.entity.AclUser;
import ec.gob.ventanilla.repository.AclUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class JwtUserDetailsService implements UserDetailsService {

    @Autowired
    private AclUserRepository usuarioRepository;

    public UserDetails loadUserByUsernameAndClave(String username, String clave) throws UsernameNotFoundException {

        AclUser usuario = usuarioRepository.login(username, clave);
        if (usuario == null) {
            throw new UsernameNotFoundException(String.format("Usuario no encontrado", username));
        } else {
            return new User(username, usuario.getPass(),
                    new ArrayList<>());
        }

    }

    @Override
    public UserDetails loadUserByUsername(String usuario) throws UsernameNotFoundException {
        AclUser u = usuarioRepository.findByUsername(usuario);
        if (u == null) {
            throw new UsernameNotFoundException(String.format("Usuario no encontrado", usuario));
        } else {
            return new User(usuario, u.getPass(),
                    new ArrayList<>());
        }

    }
}
