package ec.gob.ventanilla.repository;


import ec.gob.ventanilla.model.payphone.ResponseCreate;
import org.springframework.data.repository.CrudRepository;

public interface ResponseCreateRepository extends CrudRepository<ResponseCreate, Long> {
    
    ResponseCreate findFirstByTransactionIdOrderByIdDesc(String id);
    
}
