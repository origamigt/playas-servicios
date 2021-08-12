package com.facturacion.entites;

import com.facturacion.sri.model.autorizacion.Autorizacion;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlTransient;
import javax.xml.bind.annotation.XmlType;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "respuestaComprobante", propOrder = {"claveAccesoConsultada", "numeroComprobantes", "autorizaciones"})
@Entity
@Table(name = "respuesta_comprobante")
public class RespuestaComprobante implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    @XmlTransient
    private Long id;
    @XmlTransient
    private Long tramite;
    @XmlTransient
    private String response;
    @XmlTransient
    @Column(name = "fecha_ingreso")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaIngreso;
    @Transient
    protected String claveAccesoConsultada;
    @Transient
    protected String numeroComprobantes;
    @Transient
    protected Autorizaciones autorizaciones;

    public RespuestaComprobante() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getTramite() {
        return tramite;
    }

    public void setTramite(Long tramite) {
        this.tramite = tramite;
    }

    public String getResponse() {
        return response;
    }

    public void setResponse(String response) {
        this.response = response;
    }

    public Date getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(Date fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public String getClaveAccesoConsultada() {
        return claveAccesoConsultada;
    }

    public void setClaveAccesoConsultada(String claveAccesoConsultada) {
        this.claveAccesoConsultada = claveAccesoConsultada;
    }

    public String getNumeroComprobantes() {
        return numeroComprobantes;
    }

    public void setNumeroComprobantes(String numeroComprobantes) {
        this.numeroComprobantes = numeroComprobantes;
    }

    public Autorizaciones getAutorizaciones() {
        return autorizaciones;
    }

    public void setAutorizaciones(Autorizaciones autorizaciones) {
        this.autorizaciones = autorizaciones;
    }

    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {"autorizacion"})
    public static class Autorizaciones {
        protected List<Autorizacion> autorizacion;
        public List<Autorizacion> getAutorizacion() {
            if (this.autorizacion == null) {
                this.autorizacion = new ArrayList();
            }
            return this.autorizacion;
        }

        @Override
        public String toString() {
            return "Autorizaciones{" +
                    "autorizacion=" + autorizacion +
                    '}';
        }
    }

}