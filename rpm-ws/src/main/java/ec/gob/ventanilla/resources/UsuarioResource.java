package ec.gob.ventanilla.resources;

import com.google.gson.Gson;
import ec.gob.ventanilla.async.CodigoCorreoService;
import ec.gob.ventanilla.async.EmailService;
import ec.gob.ventanilla.async.PersonaService;
import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.*;
import ec.gob.ventanilla.model.DataModel;
import ec.gob.ventanilla.model.UsuarioRegistro;
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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

@RestController
@RequestMapping("/rpm-ventanilla/api/")
public class UsuarioResource {

    @Autowired
    private AclUserRepository aur;
    @Autowired
    private PubPersonaRepository pubPersonaRepository;
    @Autowired
    private CodigoCorreoService correoService;
    @Autowired
    private PersonaService personaService;
    @Autowired
    private AppProps appProps;
    @Autowired
    private EmailService emailService;

    @RequestMapping(value = "usuario/loginUser", method = RequestMethod.POST)
    public ResponseEntity<?> login(@RequestBody AclUser user) {
        user.setClave(new MD5PasswordEncoder().encode(user.getClave()));
        AclUser aclUser = aur.login(user.getUsuario(), user.getClave());
        if (aclUser != null) {
            return new ResponseEntity<>(aclUser, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(new DataModel("Datos incorrectos"), HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "usuario/consultar", method = RequestMethod.POST)
    @Transactional
    public ResponseEntity<?> registrarUsuario(@RequestBody UsuarioRegistro usuarioRegistro) {
        try {
            AclUser aclUser = aur.findByUsuario(usuarioRegistro.getIdentificacion());
            if (aclUser == null) {
                PubPersona personFind = pubPersonaRepository.findByCedRuc(usuarioRegistro.getIdentificacion());
                PubPersona persona;
                if (personFind == null) {
                    personFind = personaService.buscarPersonaDinardap(usuarioRegistro.getIdentificacion());
                    if (personFind == null) {
                        return new ResponseEntity<>(new DataModel("Conexión no disponible con el registro civil"), HttpStatus.ACCEPTED);
                    }
                    personFind.setCedRuc(usuarioRegistro.getIdentificacion());
                    personFind = pubPersonaRepository.save(personFind);
                }
                if (personFind.getFechaExpedicion() == null) {
                    persona = personaService.buscarPersonaDinardap(usuarioRegistro.getIdentificacion());
                    if (persona != null && persona.getFechaExpedicion() != null) {
                        personFind.setFechaExpedicion(persona.getFechaExpedicion());
                    } else {
                        return new ResponseEntity<>(new DataModel("Conexión no disponible con el registro civil"), HttpStatus.ACCEPTED);
                    }
                }
                Date usuarioFechaExpedicion = new SimpleDateFormat("yyyy-MM-dd").parse(usuarioRegistro.getFechaExpedicion());
                if (personFind.getFechaExpedicion().equals(usuarioFechaExpedicion)) {
                    usuarioRegistro.setNombresCompletos(personFind.getNombres() + " " + personFind.getApellidos());
                    usuarioRegistro.setCorreo(personFind.getCorreo1());
                    usuarioRegistro.setDireccion(personFind.getDireccion());
                    usuarioRegistro.setCelular(personFind.getTelefono1());
                    usuarioRegistro.setPersonaId(personFind.getId());
                    usuarioRegistro.setCreado(Boolean.FALSE);
                    return new ResponseEntity<>(usuarioRegistro, HttpStatus.OK);
                } else {
                    return new ResponseEntity<>(new DataModel("Fecha de expedición incorrecta"), HttpStatus.ACCEPTED);
                }
            }
            return new ResponseEntity<>(new DataModel("Usuario registrado"), HttpStatus.ACCEPTED);


        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "usuario/consultar/recuperar", method = RequestMethod.POST)
    public ResponseEntity<?> findByUsuario(@RequestBody UsuarioRegistro usuarioRegistro) {
        try {
            AclUser aclUser = aur.findByUsuario(usuarioRegistro.getIdentificacion());
            if (aclUser != null) {
                PubPersona personFind = aclUser.getPersona();
                Date usuarioFechaExpedicion = new SimpleDateFormat("yyyy-MM-dd").parse(usuarioRegistro.getFechaExpedicion());
                if (personFind.getFechaExpedicion().equals(usuarioFechaExpedicion)) {
                    usuarioRegistro.setNombresCompletos(personFind.getNombres() + " " + personFind.getApellidos());
                    usuarioRegistro.setCorreo(personFind.getCorreo1());
                    usuarioRegistro.setCorreoCodificado(personFind.getCorreo1().replaceAll("(?<=.{3}).(?=.*@)", "*"));
                    usuarioRegistro.setDireccion(personFind.getDireccion());
                    usuarioRegistro.setCelular(personFind.getTelefono1() != null ? personFind.getTelefono1() : "");
                    usuarioRegistro.setPersonaId(personFind.getId());
                    usuarioRegistro.setCreado(Boolean.TRUE);
                    CodigoCorreo codigoCorreo = new CodigoCorreo();
                    codigoCorreo.setValidado(Boolean.FALSE);
                    codigoCorreo.setCelular(personFind.getTelefono1());
                    codigoCorreo.setPersona(personFind.getNombres() + " " + personFind.getApellidos());
                    codigoCorreo.setCorreo(personFind.getCorreo1());
                    codigoCorreo.setIdentificacion(personFind.getCedRuc());
                    correoService.generarCodigoRegistro(codigoCorreo);
                    return new ResponseEntity<>(usuarioRegistro, HttpStatus.OK);
                } else {
                    return new ResponseEntity<>(new DataModel("Fecha de expedición incorrecta"), HttpStatus.ACCEPTED);
                }
            }
            return new ResponseEntity<>(new DataModel("Usuario no encontrado"), HttpStatus.ACCEPTED);


        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }
    }

    @RequestMapping(value = "usuario/actualizarContrasenia", method = RequestMethod.POST)
    public ResponseEntity<?> actualizarContrasenia(@RequestBody AclUser user) {
        Optional<AclUser> aclUser;
        if (user.getId() != null) {
            aclUser = aur.findById(user.getId());
        } else {
            aclUser = aur.findByUsuarioOP(user.getUsuario());
        }

        if (aclUser.isPresent()) {
            AclUser u = aclUser.get();
            u.setClave(new MD5PasswordEncoder().encode(user.getClave()));
            aur.save(u);
            return new ResponseEntity<>(aclUser, HttpStatus.OK);
        }
        return new ResponseEntity<>(new DataModel("No se pudo actualizar la contraseña intente nuevamente"), HttpStatus.ACCEPTED);
    }

    @RequestMapping(value = "usuario/activarUsuarioEntidad", method = RequestMethod.POST)
    public ResponseEntity<?> actualizarContrasenia(@RequestBody UsuarioRegistro usuarioRegistro) {
        AclUser aclUser = aur.findByUsuario(usuarioRegistro.getIdentificacion());
        String txt;
        if (usuarioRegistro.getCreado()) {
            txt = "Estimado " + aclUser.getPersona().getNombres() + " su usuario ha sido activado correctamente, puede iniciar sesión con su número de RUC.";
            aclUser.setHabilitado(Boolean.TRUE);
            aclUser.setObservacion("ENTIDAD ACTIVADA");
        } else {
            txt = "Estimado " + aclUser.getPersona().getNombres() + " su usuario no ha podido ser verificado por las siguientes razones: <br/>" + usuarioRegistro.getTipo();
            aclUser.setHabilitado(Boolean.FALSE);
            aclUser.setObservacion(usuarioRegistro.getTipo());
        }
        emailService.sendMail(aclUser.getPersona().getCorreo1(), "ACTIVACIÓN DE USUARIO",
                Util.getHtmlActivacionUsuario(txt, appProps.getLogo()));
        return new ResponseEntity<>(usuarioRegistro, HttpStatus.OK);
    }

}
