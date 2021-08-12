package com.facturacion.entites;

import java.math.BigInteger;

public class SecuenciaComprobante {

    private Comprobante comprobante;
    private BigInteger secuencia;

    public SecuenciaComprobante() {
    }

    public Comprobante getComprobante() {
        return comprobante;
    }

    public void setComprobante(Comprobante comprobante) {
        this.comprobante = comprobante;
    }

    public BigInteger getSecuencia() {
        return secuencia;
    }

    public void setSecuencia(BigInteger secuencia) {
        this.secuencia = secuencia;
    }

    @Override
    public String toString() {
        return "SecuenciaComprobante{" +
                "comprobante=" + comprobante +
                ", secuencia=" + secuencia +
                '}';
    }
}
