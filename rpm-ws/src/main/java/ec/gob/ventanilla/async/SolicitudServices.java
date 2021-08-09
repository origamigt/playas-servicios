/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.ventanilla.async;

import ec.gob.ventanilla.entity.PubSolicitud;
import ec.gob.ventanilla.entity.SolicitudActo;
import ec.gob.ventanilla.entity.SolicitudRequisito;
import ec.gob.ventanilla.model.ActoRequisito;
import ec.gob.ventanilla.model.payphone.CreateBtn;
import ec.gob.ventanilla.repository.PubSolicitudRepository;
import ec.gob.ventanilla.repository.SolicitudActoRepository;
import ec.gob.ventanilla.repository.SolicitudRequisitoRepository;
import ec.gob.ventanilla.util.SisVars;
import ec.gob.ventanilla.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author ORIGAMI
 */
@Service
public class SolicitudServices {

    @Autowired
    private PubSolicitudRepository pubSolicitudRepository;
    @Autowired
    private SolicitudRequisitoRepository requisitoRepository;
    @Autowired
    private SolicitudActoRepository actoRepository;
    @Autowired
    private SGRService sgrService;
    @Autowired
    private PayPhoneService payPhoneService;

    public PubSolicitud registrarSolicitudCertificados(PubSolicitud pubSolicitud) {
        pubSolicitud.setIngresado(Boolean.FALSE);
        pubSolicitud.setTieneNotificacion(Boolean.FALSE);
        if (pubSolicitud.getFechaInscripcionLong() != null) {
            pubSolicitud.setFechaInscripcion(new Date(pubSolicitud.getFechaInscripcionLong()));
        }
        pubSolicitud.setFechaSolicitud(new Date());
        if (pubSolicitud.getEstado() == null) {
            pubSolicitud.setEstado("I");
        }
        pubSolicitud = pubSolicitudRepository.save(pubSolicitud);
        if (pubSolicitud.getEstado().equals("V")) {
            sgrService.iniciarTramite(pubSolicitud);
        }
        return pubSolicitud;
    }

    public PubSolicitud registrarSolicitudInscripciones(PubSolicitud pubSolicitud) {
        List<ActoRequisito> requisitos = pubSolicitud.getRequisitos();

        pubSolicitud.setRequisitos(null);
        pubSolicitud.setIngresado(Boolean.FALSE);
        pubSolicitud.setTieneNotificacion(Boolean.FALSE);
        pubSolicitud.setFechaSolicitud(new Date());
        pubSolicitud.setEstado("INSCRIPCION");
        pubSolicitud = pubSolicitudRepository.save(pubSolicitud);
        pubSolicitud.setRequisitos(requisitos);
        for (ActoRequisito r : requisitos) {
            SolicitudRequisito sr = new SolicitudRequisito();
            sr.setSolicitud(pubSolicitud);
            sr.setDocumento(r.getDocumento());
            sr.setRequisitoActo(r.getRequisitoActo());
            sr.setIdActo(r.getIdActo());
            sr.setActo(r.getActo());
            sr.setIdRequisito(r.getIdRequisito());
            sr.setRequisito(r.getRequisito());
            sr.setFecha(new Date());
            sr.setTipo(SisVars.TIPO_REQUISITO);
            requisitoRepository.save(sr);
        }
        List<ActoRequisito> actosFiltered = requisitos.stream()
                .filter(Util.distinctByKey(p -> p.getIdActo()))
                .collect(Collectors.toList());

        for (ActoRequisito r : actosFiltered) {
            SolicitudActo sa = new SolicitudActo();
            sa.setSolicitud(pubSolicitud);
            sa.setIdActo(r.getIdActo());
            sa.setActo(r.getActo());
            actoRepository.save(sa);
        }
        sgrService.iniciarTramiteSolicitudInscripcion(pubSolicitud);
        return pubSolicitud;
    }

    public PubSolicitud actualizarSolicitudObservacion(PubSolicitud pubSolicitud) {
        PubSolicitud solicitudBD = pubSolicitudRepository.findByNumeroTramite(pubSolicitud.getNumeroTramite());
        solicitudBD.setTieneNotificacion(Boolean.TRUE);
        solicitudBD.setNotificacion(pubSolicitud.getNotificacion());
        pubSolicitudRepository.save(solicitudBD);

        List<SolicitudRequisito> solicitudRequisitos = requisitoRepository.findAllBySolicitud_IdAndTipo(solicitudBD.getId(), SisVars.TIPO_REQUISITO_NOTIFICAR);
        for (SolicitudRequisito sr : solicitudRequisitos) {
            sr.setTipo(SisVars.TIPO_REQUISITO_NOTIFICADO);
            requisitoRepository.save(sr);
        }
        for (ActoRequisito r : pubSolicitud.getRequisitos()) {
            SolicitudRequisito sr = new SolicitudRequisito();
            sr.setSolicitud(solicitudBD);
            sr.setDocumento(r.getDocumento());
            sr.setRequisitoActo(r.getRequisitoActo());
            sr.setIdActo(r.getIdActo());
            sr.setActo(r.getActo());
            sr.setIdRequisito(r.getIdRequisito());
            sr.setRequisito(r.getRequisito());
            sr.setFecha(new Date());
            sr.setTipo(SisVars.TIPO_REQUISITO_NOTIFICAR);
            requisitoRepository.save(sr);
        }
        return solicitudBD;
    }

    public PubSolicitud buscarTramite(PubSolicitud pubSolicitud) {
        List<ActoRequisito> requisitos = new ArrayList();
        PubSolicitud solicitudBD = pubSolicitudRepository.findByNumeroTramite(pubSolicitud.getNumeroTramite());
        List<SolicitudRequisito> solicitudRequisitos = requisitoRepository.findAllBySolicitud_IdAndTipo(solicitudBD.getId(), SisVars.TIPO_REQUISITO_NOTIFICAR);
        for (SolicitudRequisito r : solicitudRequisitos) {
            ActoRequisito ar = new ActoRequisito();
            ar.setActo(r.getActo());
            ar.setIdActo(r.getIdActo());
            ar.setRequerido(Boolean.TRUE);
            ar.setIdRequisito(r.getIdRequisito());
            ar.setRequisito(r.getRequisito());
            ar.setRequisitoActo(r.getRequisitoActo());
            ar.setId(Long.MIN_VALUE);
            requisitos.add(ar);
        }
        solicitudBD.setFechaEntrega(null);
        solicitudBD.setFechaIngreso(null);
        solicitudBD.setFechaSolicitud(null);
        solicitudBD.setRequisitos(requisitos);
        return solicitudBD;
    }

    public PubSolicitud actualizarRequisitos(PubSolicitud pubSolicitud) {
        List<ActoRequisito> requisitos = pubSolicitud.getRequisitos();
        PubSolicitud solicitudBD = pubSolicitudRepository.findById(pubSolicitud.getId()).get();
        solicitudBD.setTieneNotificacion(Boolean.FALSE);
        pubSolicitudRepository.save(solicitudBD);

        for (ActoRequisito r : requisitos) {
            SolicitudRequisito sr = new SolicitudRequisito();
            sr.setSolicitud(solicitudBD);
            sr.setDocumento(r.getDocumento());
            sr.setRequisitoActo(r.getRequisitoActo());
            sr.setIdActo(r.getIdActo());
            sr.setActo(r.getActo());
            sr.setIdRequisito(r.getIdRequisito());
            sr.setRequisito(r.getRequisito());
            sr.setFecha(new Date());
            sr.setTipo(SisVars.TIPO_REQUISITO);
            requisitoRepository.save(sr);
        }

        sgrService.actualizarRequisitosInscripcion(pubSolicitud);
        return pubSolicitud;
    }

    public PubSolicitud registrarSolicitudCertificadosPagoEnLinea(PubSolicitud pubSolicitud) {
        pubSolicitud.setIngresado(Boolean.FALSE);
        pubSolicitud.setProcesando(Boolean.FALSE);
        pubSolicitud.setTieneNotificacion(Boolean.FALSE);
        if (pubSolicitud.getFechaInscripcionLong() != null) {
            pubSolicitud.setFechaInscripcion(new Date(pubSolicitud.getFechaInscripcionLong()));
        }
        pubSolicitud.setFechaSolicitud(new Date());
        pubSolicitud = pubSolicitudRepository.save(pubSolicitud);
        CreateBtn response = payPhoneService.linkPagoPayPhone(pubSolicitud);
        if (response != null && response.getPaymentId() != null) {
            pubSolicitud.setLinkPago(response.getPayWithCard());
            pubSolicitud.setPayWithPayPhone(response.getPayWithPayPhone());
            pubSolicitud.setPaymentId(response.getPaymentId());
        } else {
            pubSolicitud.setLinkPago("");
        }
        pubSolicitud = pubSolicitudRepository.save(pubSolicitud);
        return pubSolicitud;
    }

    public PubSolicitud registrarSolicitudInscripcionesPagoEnLinea(PubSolicitud pubSolicitud) {
        pubSolicitud.setIngresado(Boolean.FALSE);
        pubSolicitud.setProcesando(Boolean.FALSE);
        pubSolicitud.setTieneNotificacion(Boolean.FALSE);
        pubSolicitud.setFechaSolicitud(new Date());
        pubSolicitud = pubSolicitudRepository.save(pubSolicitud);
        CreateBtn response = payPhoneService.linkPagoPayPhone(pubSolicitud);
        if (response != null && response.getPaymentId() != null) {
            pubSolicitud.setLinkPago(response.getPayWithCard());
            pubSolicitud.setPayWithPayPhone(response.getPayWithPayPhone());
            pubSolicitud.setPaymentId(response.getPaymentId());
        } else {
            pubSolicitud.setLinkPago("");
        }
        pubSolicitud = pubSolicitudRepository.save(pubSolicitud);
        return pubSolicitud;
    }

}
