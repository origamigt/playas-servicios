package com.rp.catastro.catastro.controller;
import com.rp.catastro.catastro.SisVars;
import com.rp.catastro.catastro.dinardap.ServicioDINARDAP;
import com.rp.catastro.catastro.entities.PubPersona;
import com.rp.catastro.catastro.repository.PubPersonaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/persona/")
public class PubPersonaController {

    @Autowired
    private PubPersonaRepository pubPersonaRepository;
    @Autowired
    private ServicioDINARDAP servicioDINARDAP;


    @RequestMapping(value = "/identificacion/{identificacion}", method = RequestMethod.GET)
    public ResponseEntity<PubPersona> findPersonByCi(@PathVariable(value = "identificacion") String identificacion) {
        try {
            return new ResponseEntity<>(pubPersonaRepository.findByCedRuc(identificacion), HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ResponseEntity<>(null, HttpStatus.OK);

    }

    /**
     * aplicacion: SGR / VENTANILLA-WEB / VENTANILLA-MOVIL PAQUETE POR NOMBRES
     * AUN NO ESTA DEFINIDO codigoPaquete : "C" : Cedula - codigoPaquete = 2416
     * codigoPaquete : "R" || "J" : Cedula - codigoPaquete = 2419
     *
     * @param aplicacion
     * @param codigoPaquete
     * @param identificacion
     * @return
     */
    @RequestMapping(value = "aplicacion/{aplicacion}/codigoPaquete/{codigoPaquete}/identificacion/{identificacion}", method = RequestMethod.GET)
    public ResponseEntity<PubPersona> findEnte(@PathVariable(value = "aplicacion") String aplicacion,
                                               @PathVariable(value = "codigoPaquete") String codigoPaquete,
                                               @PathVariable(value = "identificacion") String identificacion) {

        try {
            String codigo = "", parametro = "";
            Boolean acept;
            switch (aplicacion) {
                case "SIGERI":
                case "VENTANILLA-WEB":
                case "VENTANILLA-MOVIL":
                case "ENTREGA-TRAMITE":
                    acept = Boolean.TRUE;
                    break;
                default:
                    acept = Boolean.FALSE;
                    break;
            }
            switch (codigoPaquete) {
                case "C":
                    codigo = SisVars.paqueteDemografico;
                    parametro = SisVars.parametroDemograficoSri;
                    break;
                case "R":
                case "J":
                    codigo = SisVars.paqueteSri;
                    parametro = SisVars.parametroDemograficoSri;
                    break;
                default:
                    acept = Boolean.FALSE;
                    break;

            }
            if (acept) {
                PubPersona pubPersona = servicioDINARDAP.datosDINARDAP(identificacion, codigo, parametro,
                        SisVars.urlInterOperatividad, SisVars.interOperatividadUser, SisVars.interOperatividadPass);
                pubPersona.setTipoDocumento(codigoPaquete);
                return new ResponseEntity<>(pubPersona, HttpStatus.OK);
            } else {
                return new ResponseEntity<>(HttpStatus.OK);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ResponseEntity<>(HttpStatus.OK);

    }

}
