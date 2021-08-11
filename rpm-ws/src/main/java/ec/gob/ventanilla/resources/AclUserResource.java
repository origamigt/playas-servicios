package ec.gob.ventanilla.resources;

import com.google.gson.Gson;
import ec.gob.ventanilla.async.EmailService;
import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.AclRol;
import ec.gob.ventanilla.entity.AclUser;
import ec.gob.ventanilla.entity.AppLogs;
import ec.gob.ventanilla.entity.PubPersona;
import ec.gob.ventanilla.repository.AclUserRepository;
import ec.gob.ventanilla.repository.AppLogsRepository;
import ec.gob.ventanilla.repository.PubPersonaRepository;
import ec.gob.ventanilla.security.MD5PasswordEncoder;
import ec.gob.ventanilla.util.SisVars;
import ec.gob.ventanilla.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@RestController
@RequestMapping("/rpm-ventanilla/api/")
public class AclUserResource {

    @Autowired
    private AclUserRepository aur;
    @Autowired
    private PubPersonaRepository pubPersonaRepository;
    @Autowired
    private EmailService emailService;
    @Autowired
    private AppLogsRepository appLogsRepository;
    @Autowired
    private AppProps appProps;
    private AppLogs appLogs;

    private Gson gson;

    @RequestMapping(value = "usuario/loginUser", method = RequestMethod.POST)
    public ResponseEntity<?> login(@RequestBody AclUser user) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();
        gson = new Gson();

        appLogs = new AppLogs(new Date(), "/api/usuario/loginUser/" + gson.toJson(user), null, "login", request.getRemoteAddr());
        appLogsRepository.save(appLogs);
        user.setPass(new MD5PasswordEncoder().encode(user.getPass()));
        AclUser aclUser = aur.login(user.getUsername(), user.getPass());
        if (aclUser != null) {
            aclUser.setUrlRp(appProps.getLogo());
            return new ResponseEntity<>(aclUser, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "usuario/saveUser", method = RequestMethod.POST)
    @Transactional

    public ResponseEntity<?> registrarUsuario(@RequestBody AclUser aclUser) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();

        gson = new Gson();
        appLogs = new AppLogs(new Date(), "/api/usuario/saveUser/" + gson.toJson(aclUser), null, "registrarUsuario", request.getRemoteAddr());
        appLogsRepository.save(appLogs);

        try {
            PubPersona persona = aclUser.getPersona();
            PubPersona personFind = pubPersonaRepository.findByCedRuc(persona.getCedRuc());
            //ACTUALIZAR DATOS =)
            if (personFind != null) {
                personFind.setDireccion(persona.getDireccion());
                personFind.setTelefono1(persona.getTelefono1());
                personFind.setTelefono2(persona.getTelefono2());
                if (personFind.getCorreo1() != null) {
                    if (!persona.getCorreo1().contains("***")) {
                        personFind.setCorreo1(persona.getCorreo1());
                    }
                } else {
                    personFind.setCorreo1(persona.getCorreo1());
                }

            } else {
                personFind = persona;
                if (persona.getFechaExpedicionLong() != null) {
                    personFind.setFechaExpedicion(new Date(persona.getFechaExpedicionLong()));
                }
                if (persona.getFechaNacimientoLong() != null) {
                    personFind.setFechaNacimiento(new Date(persona.getFechaNacimientoLong()));
                }
                personFind.setFechaCreacion(new Date());
            }

            personFind = pubPersonaRepository.save(personFind);

            AclUser temp = aur.findByUsername(aclUser.getUsername());
            if (temp != null) {
                aclUser.setId(temp.getId());
            }
            aclUser.setPass(new MD5PasswordEncoder().encode(aclUser.getPass()));
            aclUser.setPersona(personFind);
            aclUser.setRol(new AclRol(2));
            aclUser = aur.save(aclUser);
            if (!aclUser.getHabilitado()) {
                emailService.sendMail(personFind.getCorreo1(), SisVars.activacionUsuario, Util.getHtmlAprobarUsuario(aclUser, appProps.getDominio()));
            }
            return new ResponseEntity<>(aclUser, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "usuario/identificacion/{identificacion}", method = RequestMethod.GET)
    public ResponseEntity<?> findByUsername(@PathVariable String identificacion) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();
        appLogs = new AppLogs(new Date(), "/api/usuario/identificacion/" + identificacion, null, "findByUsername", request.getRemoteAddr());
        appLogsRepository.save(appLogs);
        try {
            AclUser aclUser = aur.findByUsername(identificacion);
            if (aclUser == null) {
                aclUser = new AclUser();
            }
            if (aclUser.getPersona() != null) {
                aclUser.getPersona().setCorreoCodificado(aclUser.getPersona().getCorreo1().replaceAll("(?<=.{3}).(?=.*@)", "*"));
                if (aclUser.getPersona().getFechaExpedicion() != null) {
                    aclUser.getPersona().setFechaExpedicionLong(aclUser.getPersona().getFechaExpedicion().getTime());
                }
            }
            return new ResponseEntity<>(aclUser, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "user/token/{username}", method = RequestMethod.GET)
    public ResponseEntity<?> findTokenByUsername(@PathVariable String username) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();
        appLogs = new AppLogs(new Date(), "/api/user/token/" + username, null, "findTokenByUsername", request.getRemoteAddr());
        appLogsRepository.save(appLogs);
        try {
            AclUser aclUser = aur.findByUsername(username);

            return new ResponseEntity<>(null, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "usuario/recuperar/emailuser/{emailuser}/iduser/{iduser}/username/{username}", method
            = RequestMethod.GET)
    public ResponseEntity<?> recuperarClaveUsuario(@PathVariable String emailuser, @PathVariable Long iduser, @PathVariable String username) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();
        appLogs = new AppLogs(new Date(), "/api/usuario/recuperar/emailuser/" + emailuser + "/iduser/" + iduser + "/username/" + username, null, "recuperarClaveUsuario", request.getRemoteAddr());
        appLogsRepository.save(appLogs);
        try {
            AclUser aclUser = aur.findById(iduser.intValue()).get();
            emailService.sendMail(aclUser.getPersona().getCorreo1(), SisVars.recuperarClave, Util.getMailHtmlRecuperarClave(iduser, username, appProps.getDominio()));
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.ACCEPTED);
        }
    }

    @RequestMapping(value = "usuario/activarUsuario/identificacion/{identificacion}/fechaValidacion/{fechaValidacion}",
            method = RequestMethod.GET)
    public ResponseEntity<?> activarUsuario(@PathVariable String identificacion, @PathVariable Long fechaValidacion) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        appLogs = new AppLogs(new Date(), "/api/usuario/activarUsuario/identificacion/" + identificacion + "/fechaValidacion/" + fechaValidacion, null, "activarUsuario", request.getRemoteAddr());
        appLogsRepository.save(appLogs);
        try {
            Date fecha = new Date(fechaValidacion);
            AclUser aclUser = aur.findByUsername(identificacion);
            if (fecha.after(new Date())) {
                if (aclUser != null) {
                    aclUser.setHabilitado(Boolean.TRUE);
                    aur.save(aclUser);
                    return new ResponseEntity<>(aclUser, HttpStatus.OK);
                }
            }
            return new ResponseEntity<>(aclUser, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.ACCEPTED);
        }
    }

    @RequestMapping(value = "usuario/actualizarContrasenia", method = RequestMethod.POST)
    public ResponseEntity<?> actualizarContrasenia(@RequestBody AclUser user) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        gson = new Gson();
        appLogs = new AppLogs(new Date(), "/api/usuario/actualizarContrasenia" + gson.toJson(user), null, "actualizarContrasenia", request.getRemoteAddr());
        appLogsRepository.save(appLogs);
        if (user != null) {
            AclUser aclUser = aur.findByUsername(user.getUsername());
            if (aclUser != null) {
                aclUser.setPass(new MD5PasswordEncoder().encode(user.getPass()));
                aur.save(aclUser);
                return new ResponseEntity<>(aclUser, HttpStatus.OK);
            }
        }
        return new ResponseEntity<>(HttpStatus.ACCEPTED);
    }

}
