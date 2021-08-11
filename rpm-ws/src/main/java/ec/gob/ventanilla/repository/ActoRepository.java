package ec.gob.ventanilla.repository;

import ec.gob.ventanilla.entity.Acto;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ActoRepository extends CrudRepository<Acto, Integer> {

    List<Acto> findAllByCertificadoOrderByOrdenAsc(Boolean certificado);

    //List<Acto> findAllByLibro_IdAndCertificado(Integer idLibro, Boolean certificado);

}
