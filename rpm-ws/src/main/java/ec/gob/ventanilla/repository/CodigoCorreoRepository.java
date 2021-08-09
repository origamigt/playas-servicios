/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.ventanilla.repository;

import ec.gob.ventanilla.entity.CodigoCorreo;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

/**
 *
 * @author ORIGAMI
 */
public interface CodigoCorreoRepository extends CrudRepository<CodigoCorreo, Long> {
    
    Optional<CodigoCorreo> findFirstByCodigoAndCorreoOrderByIdDesc(String codigo, String correo);
    
}
