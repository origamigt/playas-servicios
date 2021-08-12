package com.facturacion.sri.ws.aut;

import com.facturacion.entites.RespuestaComprobante;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "autorizacionComprobanteResponse", propOrder = {"respuestaAutorizacionComprobante"})
public class AutorizacionComprobanteResponse {
    @XmlElement(name = "RespuestaAutorizacionComprobante")
    protected RespuestaComprobante respuestaAutorizacionComprobante;

    public RespuestaComprobante getRespuestaAutorizacionComprobante() {
        return this.respuestaAutorizacionComprobante;
    }


    public void setRespuestaAutorizacionComprobante(RespuestaComprobante value) {
        this.respuestaAutorizacionComprobante = value;
    }
}