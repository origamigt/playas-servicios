package ec.gob.ventanilla.resources;

import ec.gob.ventanilla.async.ActoServices;
import ec.gob.ventanilla.entity.Acto;
import ec.gob.ventanilla.model.ActoRequisito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/rpm-ventanilla/api/")
public class ActoResource {

    @Autowired
    private ActoServices actoServices;

    @RequestMapping(value = "actosPopulares", method = RequestMethod.GET)
    public ResponseEntity<?> findAllActosMasUsados() {
        return new ResponseEntity<>(actoServices.findAll(), HttpStatus.OK);
    }

    @RequestMapping(value = "actos", method = RequestMethod.GET)
    public ResponseEntity<?> findAllActos() {
        return new ResponseEntity<>(actoServices.findAll(), HttpStatus.OK);
    }

    @RequestMapping(value = "actos/id/{idActo}", method = RequestMethod.GET)
    public ResponseEntity<Acto> findActoById(@PathVariable Integer idActo) {
        return new ResponseEntity<>(actoServices.findById(idActo), HttpStatus.OK);
    }

    @RequestMapping(value = "actosInscricipciones", method = RequestMethod.GET)
    public ResponseEntity<?> findActoInscripciones() {
        return new ResponseEntity<>(actoServices.findActoInscripciones(), HttpStatus.OK);
    }

    @RequestMapping(value = "requisitos/{acto}", method = RequestMethod.GET)
    public ResponseEntity<List<ActoRequisito>> findActoRequisitos(@PathVariable Integer acto) {
        return new ResponseEntity<>(actoServices.findActoRequisitos(acto), HttpStatus.OK);
    }

}
