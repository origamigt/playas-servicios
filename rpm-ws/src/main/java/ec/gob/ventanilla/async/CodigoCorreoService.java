/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.ventanilla.async;

import ec.gob.ventanilla.conf.AppProps;
import ec.gob.ventanilla.entity.CodigoCorreo;
import ec.gob.ventanilla.repository.CodigoCorreoRepository;
import ec.gob.ventanilla.util.Util;
import org.apache.commons.lang.time.DateUtils;
import org.apache.commons.text.RandomStringGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Optional;

/**
 *
 * @author ORIGAMI
 */
@Service
public class CodigoCorreoService {

    @Autowired
    private CodigoCorreoRepository repository;

    @Autowired
    private AppProps appProps;
    @Autowired
    private EmailService emailService;

    public CodigoCorreo generarCodigo(CodigoCorreo codigoCorreo) {
        //codigoCorreo.setCodigo(genCodigoVerif());
        codigoCorreo.setCodigo("12345");
        codigoCorreo.setFecha(new Date());
        codigoCorreo.setValidado(Boolean.FALSE);
        codigoCorreo = repository.save(codigoCorreo);
        emailService.sendMail(codigoCorreo.getCorreo(), "Código de Verificación",
                Util.getHtmlCodigoVerificacion(codigoCorreo.getCodigo(), appProps.getDominio()));
        codigoCorreo.setCodigo(null); // SE NULEA PARA QUE LUEGO SE VALIDE =D
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

    public String genCodigoVerif() {
        char[][] pairs = {{'0', '9'}};
        RandomStringGenerator sg = new RandomStringGenerator.Builder().withinRange(pairs).build();
        return sg.generate(5);
    }

}
