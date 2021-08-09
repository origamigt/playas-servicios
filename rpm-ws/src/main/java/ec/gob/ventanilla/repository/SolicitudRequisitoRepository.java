/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.ventanilla.repository;

import ec.gob.ventanilla.entity.SolicitudRequisito;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/**
 *
 * @author ORIGAMI
 */
public interface SolicitudRequisitoRepository extends CrudRepository<SolicitudRequisito, Long> {

    List<SolicitudRequisito> findAllBySolicitud_IdAndTipo(Long id, String tipo);

}
