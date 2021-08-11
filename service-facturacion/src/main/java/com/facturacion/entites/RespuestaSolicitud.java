package com.facturacion.entites;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import javax.xml.bind.annotation.XmlType;

@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "respuestaSolicitud", propOrder = {"estado", "comprobantes"})
@Entity
@Table(name = "respuesta_solicitud")
public class RespuestaSolicitud implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    @XmlTransient
    private Long id;
    @XmlTransient
    @Column
    private Long tramite;
    @Column
    @XmlTransient
    private String response;
    @XmlTransient
    @Column(name = "fecha_ingreso")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaIngreso;
    @XmlTransient
    @Column(name = "codigo_error")
    private String codigoError;
    @Column
    protected String estado;
    @Transient
    private Comprobantes comprobantes;

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

    public String getCodigoError() {
        return codigoError;
    }

    public void setCodigoError(String codigoError) {
        this.codigoError = codigoError;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Comprobantes getComprobantes() {
        return comprobantes;
    }

    public void setComprobantes(Comprobantes comprobantes) {
        this.comprobantes = comprobantes;
    }

    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {"comprobante"})
    public static class Comprobantes {

        protected List<com.facturacion.sri.model.ws.Comprobante> comprobante;

        public List<com.facturacion.sri.model.ws.Comprobante> getComprobante() {
            if (this.comprobante == null) {
                this.comprobante = new ArrayList<>();
            }
            return this.comprobante;
        }

        @Override
        public String toString() {
            return "Comprobantes{" + "comprobante=" + comprobante + '}';
        }
    }

    @Override
    public String toString() {
        return "RespuestaSolicitud{" + "id=" + id + ", tramite=" + tramite + ", response=" + response + ", fechaIngreso=" + fechaIngreso + ", codigoError=" + codigoError + ", estado=" + estado + ", comprobantes=" + comprobantes + '}';
    }

}
