package ec.gob.ventanilla.repository;

import ec.gob.ventanilla.entity.PubPersona;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

public interface PubPersonaRepository extends CrudRepository<PubPersona, Long> {

	PubPersona findByCedRuc(String cedRuc);

	@Query(value="SELECT pe FROM PubPersona pe WHERE pe.cedRuc=?1")
	PubPersona getPersonaByCedula(String cedula);
	

}
