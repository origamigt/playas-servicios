package com.facturacion.entites;

import java.util.Date;

public class DocElectronico {

    private Entidad entidad;
    private Comprobante comprobante;
    private TipoEmision tipoEmision;
    private Ambiente ambiente;
    private String estado;
    private Date deleteAt;

    public DocElectronico() {
    }

    public DocElectronico(Entidad entidad, Comprobante comprobante, TipoEmision tipoEmision, 
            Ambiente ambiente, String estado) {
        this.entidad = entidad;
        this.comprobante = comprobante;
        this.tipoEmision = tipoEmision;
        this.ambiente = ambiente;
        this.estado = estado;
    }

    public Entidad getEntidad() {
        return entidad;
    }

    public void setEntidad(Entidad entidad) {
        this.entidad = entidad;
    }

    public Comprobante getComprobante() {
        return comprobante;
    }

    public void setComprobante(Comprobante comprobante) {
        this.comprobante = comprobante;
    }

    public TipoEmision getTipoEmision() {
        return tipoEmision;
    }

    public void setTipoEmision(TipoEmision tipoEmision) {
        this.tipoEmision = tipoEmision;
    }

    public Ambiente getAmbiente() {
        return ambiente;
    }

    public void setAmbiente(Ambiente ambiente) {
        this.ambiente = ambiente;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Date getDeleteAt() {
        return deleteAt;
    }

    public void setDeleteAt(Date deleteAt) {
        this.deleteAt = deleteAt;
    }
}
