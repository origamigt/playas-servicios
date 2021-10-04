package ec.gob.ventanilla.repository;

import ec.gob.ventanilla.entity.AclUser;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;


@Transactional
public interface AclUserRepository extends CrudRepository<AclUser, Integer> {
	
	@Query(value="SELECT " +
			"new ec.gob.ventanilla.entity.AclUser(a.id, a.usuario, a.clave, a.habilitado, a.persona) " +
			"FROM AclUser a WHERE a.usuario=?1 and  a.clave=?2 ")
	AclUser login(String username, String password);
	
	AclUser findByUsuario(String username);

	@Query(value="SELECT a FROM AclUser a WHERE a.usuario=?1")
	Optional<AclUser> findByUsuarioOP(String username);

	AclUser findTopByPersona_CedRuc(String ciRuc);

}
