package com.facturacion.sri.model.ws;

public class RespuestaSolicitudSRI {

    private String estado;
    private String identificador;
    private String mensaje;
    private String informacionAdicional;
    private String tipo;
    private String numeroComprobantes;

    public RespuestaSolicitudSRI() {
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getIdentificador() {
        return identificador;
    }

    public void setIdentificador(String identificador) {
        this.identificador = identificador;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getInformacionAdicional() {
        return informacionAdicional;
    }

    public void setInformacionAdicional(String informacionAdicional) {
        this.informacionAdicional = informacionAdicional;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getNumeroComprobantes() {
        return numeroComprobantes;
    }

    public void setNumeroComprobantes(String numeroComprobantes) {
        this.numeroComprobantes = numeroComprobantes;
    }

    @Override
    public String toString() {
        return "RespuestaSolicitudSRI{" +
                "estado='" + estado + '\'' +
                ", identificador='" + identificador + '\'' +
                ", mensaje='" + mensaje + '\'' +
                ", informacionAdicional='" + informacionAdicional + '\'' +
                ", tipo='" + tipo + '\'' +
                ", numeroComprobantes='" + numeroComprobantes + '\'' +
                '}';
    }
}
