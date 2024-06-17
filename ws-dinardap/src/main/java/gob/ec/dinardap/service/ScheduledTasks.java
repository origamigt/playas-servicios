/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package gob.ec.dinardap.service;

import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 *
 * @author eduar
 */
@Component
public class ScheduledTasks {

    private static final Logger logger = Logger.getLogger(ScheduledTasks.class.getName());

    @Autowired
    private ConsultaSri servicio;

    @Scheduled(cron = "*/10 * * * * *")
    public void taskAutoGenerate() {
        try {
            servicio.consultarEntidades();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error: {0}", e.getMessage());
        }
    }

}
