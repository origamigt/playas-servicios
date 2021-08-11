package com.facturacion.modelcomprobante;

public class Detalle {

    private String descripcion;
    private Double valorUnitario;
    private Double valorTotal;
    private Double recargo;
    private Double descuento;
    private Integer cantidad;
    private Double iva;
    private String codigoAuxiliar;
    private String codigoPrincipal;
    ///SEGUN TABLA  17 TARIFA DEL IVA - ICE
    private String codigoTarifa;

    public Detalle() {
    }

    public Integer getCantidad() {
        return cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }

    public Double getIva() {
        return iva;
    }

    public void setIva(Double iva) {
        this.iva = iva;
    }

    public String getCodigoAuxiliar() {
        return codigoAuxiliar;
    }

    public void setCodigoAuxiliar(String codigoAuxiliar) {
        this.codigoAuxiliar = codigoAuxiliar;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getCodigoPrincipal() {
        return codigoPrincipal;
    }

    public void setCodigoPrincipal(String codigoPrincipal) {
        this.codigoPrincipal = codigoPrincipal;
    }

    public Double getDescuento() {
        return descuento;
    }

    public void setDescuento(Double descuento) {
        this.descuento = descuento;
    }

    public Double getValorUnitario() {
        return valorUnitario;
    }

    public void setValorUnitario(Double valorUnitario) {
        this.valorUnitario = valorUnitario;
    }

    public Double getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(Double valorTotal) {
        this.valorTotal = valorTotal;
    }

    public String getCodigoTarifa() {
        return codigoTarifa;
    }

    public void setCodigoTarifa(String codigoTarifa) {
        this.codigoTarifa = codigoTarifa;
    }

    public Double getRecargo() {
        if (recargo == null) {
            recargo = 0.0;
        }
        return recargo;
    }

    public void setRecargo(Double recargo) {
        this.recargo = recargo;
    }

    @Override
    public String toString() {
        return "Detalle{" +
                "descripcion='" + descripcion + '\'' +
                ", valorUnitario=" + valorUnitario +
                ", valorTotal=" + valorTotal +
                ", recargo=" + recargo +
                ", descuento=" + descuento +
                ", cantidad=" + cantidad +
                ", iva=" + iva +
                ", codigoAuxiliar='" + codigoAuxiliar + '\'' +
                ", codigoPrincipal='" + codigoPrincipal + '\'' +
                ", codigoTarifa='" + codigoTarifa + '\'' +
                '}';
    }
}
