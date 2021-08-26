package com.facturacion.async;

import com.facturacion.entites.MsgFormatoNotificacion;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.logging.Level;
import java.util.logging.Logger;

@Service
public class EmailService {

    @Async
    public void sendMailContribuyente(MsgFormatoNotificacion msgFormatoNotificacion, String pathXML, String pathPDF, String correoContribuyente) {
        try {
            List<File> files;
            File xml = new File(pathXML);
            File ride = new File(pathPDF);
            if (xml.exists() && ride.exists()) {
                files = new ArrayList<>();
                files.add(xml);
                files.add(ride);
                Email correo = new Email(correoContribuyente, msgFormatoNotificacion.getAsunto(), 
                        msgFormatoNotificacion.getHeader() + msgFormatoNotificacion.getFooter(), files);
                ExecutorService executorService = Executors.newSingleThreadExecutor();
                Future<Boolean> future = executorService.submit(() -> {
                    //Thread.sleep(2000);
                    return  correo.sendMail();
                });
                System.out.println("sended mail");
            }
        } catch (Exception e) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, null, e);
        }
    }

}
