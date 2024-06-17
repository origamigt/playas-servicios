/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package gob.ec.dinardap.service;

import gob.ec.dinardap.dinardap.ServicioDINARDAP;
import gob.ec.dinardap.entities.SriRuc;
import gob.ec.dinardap.repository.SriRucRepository;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author eduar
 */
@Service
public class ConsultaSri {

    private static final Logger logger = Logger.getLogger(ConsultaSri.class.getName());

    @Autowired
    private SriRucRepository repo;
    @Autowired
    private ServicioDINARDAP service;

    public void consultarEntidades() {
        try {
            //SriRuc entidad = repo.findFirstByEstadoContribuyenteAndVerificado("ACTIVO", Boolean.FALSE);
            SriRuc entidad = repo.findFirstByEstadoContribuyenteAndTipoContribuyenteAndVerificado("ACTIVO",
                    "SOCIEDADES", Boolean.FALSE);
            entidad = service.datosSRI(entidad);
            if (entidad != null) {
                entidad.setVerificado(Boolean.TRUE);
                entidad.setFechaVerificacion(new Date());
                entidad = repo.save(entidad);
                System.out.println("ruc: " + entidad.getNumeroRuc() + ", correo: " + entidad.getCorreo());
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error: {0}", e.getMessage());
        }
    }

}
