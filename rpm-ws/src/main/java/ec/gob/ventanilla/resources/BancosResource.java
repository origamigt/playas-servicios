package ec.gob.ventanilla.resources;

import com.google.common.collect.Lists;
import ec.gob.ventanilla.entity.AppLogs;
import ec.gob.ventanilla.entity.Bancos;
import ec.gob.ventanilla.repository.AppLogsRepository;
import ec.gob.ventanilla.repository.BancosRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/rpm-ventanilla/api/")
public class BancosResource {
    
    @Autowired
    private AppLogsRepository appLogsRepository;

    private AppLogs appLogs;

    @Autowired
    private BancosRepository bancosRepository;

    @RequestMapping(value = "bancos", method = RequestMethod.GET)
    public ResponseEntity<List<Bancos>> findAllBancos() {
         HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest();
        appLogs = new AppLogs(new Date(), "/api/bancos/", null, " findAllBancos", request.getRemoteAddr());
        appLogsRepository.save(appLogs);
        ArrayList<Bancos> _bancos = Lists.newArrayList(bancosRepository.findAll());
        return new ResponseEntity<>(_bancos, HttpStatus.OK);
    }

}
