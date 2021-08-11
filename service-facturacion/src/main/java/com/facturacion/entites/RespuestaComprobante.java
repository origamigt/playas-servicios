package com.facturacion.entites;

import com.facturacion.CollectionsNames;
import com.facturacion.sri.model.autorizacion.Autorizacion;
import com.facturacion.sri.model.autorizacion.Autorizacion;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlTransient;
import javax.xml.bind.annotation.XmlType;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "respuestaComprobante", propOrder = {"claveAccesoConsultada", "numeroComprobantes", "autorizaciones"})
@Document(collection = CollectionsNames.RESPUESTA_COMPROBANTE_SRI)
public class RespuestaComprobante {
    @Id
    @XmlTransient
    public ObjectId _id;
    protected String claveAccesoConsultada;
    protected String numeroComprobantes;
    protected Autorizaciones autorizaciones;

    public String get_id() {
        return _id.toHexString();
    }

    public void set_id(ObjectId _id) {
        this._id = _id;
    }

    public String getClaveAccesoConsultada() {
        return this.claveAccesoConsultada;
    }

    public void setClaveAccesoConsultada(String value) {
        this.claveAccesoConsultada = value;
    }

    public String getNumeroComprobantes() {
        return this.numeroComprobantes;
    }

    public void setNumeroComprobantes(String value) {
        this.numeroComprobantes = value;
    }

    public Autorizaciones getAutorizaciones() {
        return this.autorizaciones;
    }

    public void setAutorizaciones(Autorizaciones value) {
        this.autorizaciones = value;
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

    @Override
    public String toString() {
        return "RespuestaComprobante{" +
                "_id=" + _id +
                ", claveAccesoConsultada='" + claveAccesoConsultada + '\'' +
                ", numeroComprobantes='" + numeroComprobantes + '\'' +
                ", autorizaciones=" + autorizaciones +
                '}';
    }
}