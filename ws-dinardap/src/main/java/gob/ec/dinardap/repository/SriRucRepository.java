/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package gob.ec.dinardap.repository;

import gob.ec.dinardap.entities.SriRuc;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author eduar
 */
public interface SriRucRepository extends JpaRepository<SriRuc, Long> {

    SriRuc findFirstByEstadoContribuyenteAndVerificado(String estadoContribuyente, Boolean verificado);

    SriRuc findFirstByEstadoContribuyenteAndTipoContribuyenteAndVerificado(String estadoContribuyente,
            String tipoContribuyente, Boolean verificado);
    
    SriRuc findFirstByEstadoContribuyenteAndTipoContribuyenteAndEstadoEstablecimientoAndVerificado(String estadoContribuyente,
            String tipoContribuyente, String estadoEstablecimiento, Boolean verificado);

}
