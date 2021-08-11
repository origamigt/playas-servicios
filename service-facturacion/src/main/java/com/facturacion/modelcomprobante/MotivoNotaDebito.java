package com.facturacion.modelcomprobante;

import java.math.BigDecimal;

public class MotivoNotaDebito {

    protected String razon;
    protected BigDecimal valor;

    public String getRazon() {
        return this.razon;
    }

    public void setRazon(String value) {
        this.razon = value;
    }

    public BigDecimal getValor() {
        return this.valor;
    }

    public void setValor(BigDecimal value) {
        this.valor = value;
    }

}
