package ec.gob.ventanilla.repository;

import ec.gob.ventanilla.entity.PubSolicitud;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PubSolicitudRepository extends PagingAndSortingRepository<PubSolicitud, Long> {

    @Query("SELECT solicitudes "
            + "FROM PubSolicitud solicitudes WHERE solicitudes.user.id= ?1 and solicitudes.numeroTramite is not null "
            + "and solicitudes.fechaIngreso is not null "
            + "ORDER BY solicitudes.fechaIngreso DESC")
    Page<PubSolicitud> findPubSolicitudByUserId(Integer userId, Pageable pageable);

    @Query("SELECT solicitudes "
            + "FROM PubSolicitud solicitudes"
            + " WHERE solicitudes.user.id= ?1 " //and solicitudes.numeroTramite is not null "
            //+ " and solicitudes.fechaIngreso is not null "
            + " ORDER BY solicitudes.fechaIngreso DESC")
    List<PubSolicitud> findPubSolicitudByUserId(Integer usuario);

    @Query("SELECT ps FROM PubSolicitud ps WHERE ps.id = ?1")
    PubSolicitud encontrarPorId(Long id);

    PubSolicitud findByNumeroTramite(Long tramite);

    @Query(value = "SELECT nextval('app.dev_reference_seq')", nativeQuery = true)
    Long getNextDeveloperReferenceId();



}
