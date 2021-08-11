package com.facturacion.entites.comprobanterespuestasri;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class ComprobantePagoSRI {

    private String descripcion;
    private BigDecimal valor;
    @JsonIgnore
    private String _class;

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public BigDecimal getValor() {
        return valor;
    }

    public void setValor(BigDecimal valor) {
        this.valor = valor.setScale(2, RoundingMode.HALF_UP);
    }

    public String get_class() {
        return this.getClass().getCanonicalName();
    }

    public void set_class(String _class) {
        this._class = this.getClass().getCanonicalName();;
    }
}
