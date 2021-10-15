/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.ventanilla.async;

import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.AclRol;
import ec.gob.ventanilla.entity.AclUser;
import ec.gob.ventanilla.entity.CodigoCorreo;
import ec.gob.ventanilla.entity.PubPersona;
import ec.gob.ventanilla.model.UsuarioRegistro;
import ec.gob.ventanilla.repository.AclUserRepository;
import ec.gob.ventanilla.repository.CodigoCorreoRepository;
import ec.gob.ventanilla.repository.PubPersonaRepository;
import ec.gob.ventanilla.security.MD5PasswordEncoder;
import ec.gob.ventanilla.util.OmegaUploader;
import ec.gob.ventanilla.util.Util;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.commons.text.RandomStringGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Date;
import java.util.Optional;

/**
 * @author ORIGAMI
 */
@Service
public class CodigoCorreoService {
    @Autowired
    private AclUserRepository aur;
    @Autowired
    private CodigoCorreoRepository repository;
    @Autowired
    private PubPersonaRepository pubPersonaRepository;
    @Autowired
    private AppProps appProps;
    @Autowired
    private EmailService emailService;
    @Autowired
    private OmegaUploader omegaUploader;

    public CodigoCorreo generarCodigo(CodigoCorreo codigoCorreo) {
        if (appProps.getActiveProfile().equals("dev")) {
            codigoCorreo.setCodigo("12345");
        } else {
            codigoCorreo.setCodigo(genCodigoVerif());
        }
        codigoCorreo.setFecha(new Date());
        codigoCorreo.setValidado(Boolean.FALSE);
        codigoCorreo = repository.save(codigoCorreo);
        emailService.sendMail(codigoCorreo.getCorreo(), "Código de verificación",
                Util.getHtmlCodigoVerificacion(codigoCorreo.getCodigo(), appProps.getLogo()));
        enviarSms(codigoCorreo);
        codigoCorreo.setCodigo(null); // SE NULEA PARA QUE LUEGO SE VALIDE =D
        return codigoCorreo;
    }

    public CodigoCorreo generarCodigoRegistro(CodigoCorreo codigoCorreo) {
        if (appProps.getActiveProfile().equals("dev")) {
            codigoCorreo.setCodigo("12345");
        } else {
            codigoCorreo.setCodigo(genCodigoVerif());
        }
        codigoCorreo.setFecha(new Date());
        codigoCorreo.setValidado(Boolean.FALSE);
        codigoCorreo = repository.save(codigoCorreo);
        emailService.sendMail(codigoCorreo.getCorreo(), "Código de Verificación",
                Util.getHtmlCodigoVerificacion(codigoCorreo.getCodigo(), appProps.getLogo()));
        enviarSms(codigoCorreo);
        codigoCorreo.setCodigo(null); // SE NULEA PARA QUE LUEGO SE VALIDE =D
        codigoCorreo.setValidado(Boolean.FALSE);
        return codigoCorreo;
    }


    public CodigoCorreo validarCodigo(CodigoCorreo codigoCorreo) {

        Optional<CodigoCorreo> cc = repository.findFirstByCodigoAndCorreoOrderByIdDesc(codigoCorreo.getCodigo(), codigoCorreo.getCorreo());

        if (cc.isPresent()) {
            CodigoCorreo cod = cc.get();
            Date fechaServer = new Date();
            Date fechaMaxCodigo = DateUtils.addMinutes(cod.getFecha(), 5);
            if (fechaServer.before(fechaMaxCodigo)) {
                cod.setValidado(Boolean.TRUE);
                repository.save(cod);
                return cod;
            }
        }
        codigoCorreo.setValidado(Boolean.FALSE);
        return codigoCorreo;
    }

    public CodigoCorreo validarCodigoRegistroUsuario(CodigoCorreo codigoCorreo) {

        Optional<CodigoCorreo> cc = repository.findFirstByCodigoAndCorreoOrderByIdDesc(codigoCorreo.getCodigo(), codigoCorreo.getCorreo());
        System.out.println(cc.isPresent());
        if (cc.isPresent()) {
            CodigoCorreo cod = cc.get();
            Date fechaServer = new Date();
            Date fechaMaxCodigo = DateUtils.addMinutes(cod.getFecha(), 5);
            if (fechaServer.before(fechaMaxCodigo)) {
                cod.setValidado(Boolean.TRUE);
                repository.save(cod);
                UsuarioRegistro usuarioRegistro = codigoCorreo.getUsuarioRegistro();
                if (!usuarioRegistro.getCreado()) {
                    usuarioRegistro.setCreado(actualizarDatos(usuarioRegistro));
                    cod.setUsuarioRegistro(usuarioRegistro);
                }
                return cod;
            }
        }
        codigoCorreo.setValidado(Boolean.FALSE);
        return codigoCorreo;
    }

    private Boolean actualizarDatos(UsuarioRegistro usuarioRegistro) {
        try {
            //ACTUALIZAR DATOS =)
            PubPersona personFind = pubPersonaRepository.findByCedRuc(usuarioRegistro.getIdentificacion());
            personFind.setDireccion(usuarioRegistro.getDireccion());
            personFind.setTelefono1(usuarioRegistro.getCelular());
            personFind.setCorreo1(usuarioRegistro.getCorreo());
            personFind = pubPersonaRepository.save(personFind);

            AclUser usuario = new AclUser();
            AclUser temp = aur.findByUsuario(usuarioRegistro.getIdentificacion());
            if (temp != null) {
                usuario.setId(temp.getId());
            }
            usuario.setUsuario(usuarioRegistro.getIdentificacion());
            usuario.setClave(new MD5PasswordEncoder().encode(usuarioRegistro.getClave()));
            usuario.setPersona(personFind);

            if (usuarioRegistro.getTipo() != null && usuarioRegistro.getTipo().equals("ENTIDAD")) {
                //String archivo = appProps.getOutputDir() + new Date().getTime() + ".pdf";
                String archivo = new Date().getTime() + ".pdf";
                usuario.setRol(new AclRol(4));
                //FileUtils.writeByteArrayToFile(new File(archivo), usuarioRegistro.getMultipartFile());
                Long doc = omegaUploader.uploadFile(new ByteArrayInputStream(usuarioRegistro.getArchivo()),
                        archivo, "application/pdf", appProps.getDocUrl());
                usuario.setDocumento(doc);
            } else {
                usuario.setRol(new AclRol(2));
            }
            usuario.setHabilitado(Boolean.TRUE);
            aur.save(usuario);
            return Boolean.TRUE;
        } catch (Exception e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }

    }

    public void enviarSms(CodigoCorreo codigoCorreo) {
        if (codigoCorreo.getCelular() != null) {
            try {
                String text = "El código de RPV es " + codigoCorreo.getCodigo() + ". No lo compartas con nadie.";
                RestTemplate restTemplate = new RestTemplate();
                ((SimpleClientHttpRequestFactory) restTemplate.getRequestFactory()).setConnectTimeout(500);

                String telf = codigoCorreo.getCelular();
                if (codigoCorreo.getCelular().startsWith("0")) {
                    telf = telf.substring(1, 9);
                    telf = "593" + telf;
                }
                String url = appProps.getApiSms() + telf + "&text=" + text;
                restTemplate.getForObject(url, String.class);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public String genCodigoVerif() {
        char[][] pairs = {{'0', '9'}};
        RandomStringGenerator sg = new RandomStringGenerator.Builder().withinRange(pairs).build();
        return sg.generate(5);
    }

}
