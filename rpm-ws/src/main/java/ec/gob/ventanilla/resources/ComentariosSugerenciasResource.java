package ec.gob.ventanilla.resources;

import com.google.gson.Gson;
import ec.gob.ventanilla.entity.AppLogs;
import ec.gob.ventanilla.entity.ComentariosSugerencias;
import ec.gob.ventanilla.repository.AppLogsRepository;
import ec.gob.ventanilla.repository.ComentariosSugerenciasRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@RestController
@RequestMapping("/rpm-ventanilla/api/")
public class ComentariosSugerenciasResource {

    @Autowired
    private ComentariosSugerenciasRepository comentariosSugerenciasRepository;

    @Autowired
    private AppLogsRepository appLogsRepository;

    private AppLogs appLogs;

    private Gson gson;

    @RequestMapping(value = "comments/save", method = RequestMethod.POST)
    public ResponseEntity<?> saveLogsApplication(ComentariosSugerencias comentariosSugerencias) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();
        gson = new Gson();
        appLogs = new AppLogs(new Date(), "/api/comments/save/" + gson.toJson(comentariosSugerencias), null, "saveLogsApplication", request.getRemoteAddr());
        appLogsRepository.save(appLogs);
        
        try {
            comentariosSugerencias.setFecha(new Date());
            comentariosSugerencias = comentariosSugerenciasRepository.save(comentariosSugerencias);
            return new ResponseEntity<>(comentariosSugerencias, HttpStatus.OK);
        } catch (Exception e) {
            System.out.println(e);
            return new ResponseEntity<>(null, HttpStatus.OK);
        }
    }

}
