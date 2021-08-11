/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.ventanilla.resources;

import ec.gob.ventanilla.async.CodigoCorreoService;
import ec.gob.ventanilla.entity.CodigoCorreo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author ORIGAMI
 */
@RestController
@RequestMapping("/api/correo/")
public class CodigoCorreoResource {

    @Autowired
    private CodigoCorreoService service;

    @RequestMapping(value = "generarCodigo", method = RequestMethod.POST)
    public ResponseEntity<?> registroCodigo(@RequestBody CodigoCorreo codigoCorreo) {
        try {
            return new ResponseEntity<>(service.generarCodigo(codigoCorreo), HttpStatus.OK);
        } catch (Exception e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

    @RequestMapping(value = "validarCodigo", method = RequestMethod.POST)
    public ResponseEntity<?> validarCodigo(@RequestBody CodigoCorreo codigoCorreo) {
        try {
            return new ResponseEntity<>(service.validarCodigo(codigoCorreo), HttpStatus.OK);
        } catch (Exception e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

}
