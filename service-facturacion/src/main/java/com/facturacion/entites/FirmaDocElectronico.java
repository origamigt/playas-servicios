package com.facturacion.entites;

import java.math.BigInteger;
import java.util.Date;

public class FirmaDocElectronico {

    private Firma firma;
    private DocElectronico docElectronico;
    private String establecimiento;
    private String puntoEmision;
    private BigInteger secuencial;
    private Date deleteAt;
    private Boolean isOnline;

    public FirmaDocElectronico() {

    }

    public FirmaDocElectronico(Firma firma, DocElectronico docElectronico, String establecimiento, 
            String puntoEmision, Boolean isOnline) {
        this.firma = firma;
        this.docElectronico = docElectronico;
        this.establecimiento = establecimiento;
        this.puntoEmision = puntoEmision;
        this.isOnline = isOnline;
    }

    public Firma getFirma() {
        return firma;
    }

    public void setFirma(Firma firma) {
        this.firma = firma;
    }

    public DocElectronico getDocElectronico() {
        return docElectronico;
    }

    public void setDocElectronico(DocElectronico docElectronico) {
        this.docElectronico = docElectronico;
    }

    public String getEstablecimiento() {
        return establecimiento;
    }

    public void setEstablecimiento(String establecimiento) {
        this.establecimiento = establecimiento;
    }

    public String getPuntoEmision() {
        return puntoEmision;
    }

    public void setPuntoEmision(String puntoEmision) {
        this.puntoEmision = puntoEmision;
    }

    public BigInteger getSecuencial() {
        return secuencial;
    }

    public void setSecuencial(BigInteger secuencial) {
        this.secuencial = secuencial;
    }

    public Date getDeleteAt() {
        return deleteAt;
    }

    public void setDeleteAt(Date deleteAt) {
        this.deleteAt = deleteAt;
    }

    public Boolean getIsOnline() {
        return isOnline;
    }

    public void setIsOnline(Boolean isOnline) {
        this.isOnline = isOnline;
    }

    @Override
    public String toString() {
        return "FirmaDocElectronico{"
                //+ ", firma=" + firma
                + ", docElectronico=" + docElectronico
                + ", establecimiento='" + establecimiento + '\''
                + ", puntoEmision='" + puntoEmision + '\''
                + ", secuencial='" + secuencial + '\''
                + ", deleteAt=" + deleteAt
                + '}';
    }
}
