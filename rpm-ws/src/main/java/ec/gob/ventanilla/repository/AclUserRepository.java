package ec.gob.ventanilla.repository;

import ec.gob.ventanilla.entity.AclUser;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;


@Transactional
public interface AclUserRepository extends CrudRepository<AclUser, Integer> {
	
	@Query(value="SELECT " +
			"new ec.gob.ventanilla.entity.AclUser(a.id, a.username, a.pass, a.habilitado, a.persona) " +
			"FROM AclUser a WHERE a.username=?1 and  a.pass=?2 ")
	AclUser login(String username, String password);
	
	AclUser findByUsername(String username);

	AclUser findTopByPersona_CedRuc(String ciRuc);

}
