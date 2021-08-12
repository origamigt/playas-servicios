package com.facturacion.entites;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "porcentaje_impuesto")
public class Porcentajes implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;
    @Column
    private String impuesto;
    @Column(name = "codigo_impuesto")
    private String codigoImpuesto;
    @Column(name = "codigo_tarifa")
    private String codigoTarifa;
    @Column
    private Double porcentaje;
    @Transient
    private Impuesto impuestos;

    public Porcentajes() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getImpuesto() {
        return impuesto;
    }

    public void setImpuesto(String impuesto) {
        this.impuesto = impuesto;
    }

    public String getCodigoImpuesto() {
        return codigoImpuesto;
    }

    public void setCodigoImpuesto(String codigoImpuesto) {
        this.codigoImpuesto = codigoImpuesto;
    }

    public String getCodigoTarifa() {
        return codigoTarifa;
    }

    public void setCodigoTarifa(String codigoTarifa) {
        this.codigoTarifa = codigoTarifa;
    }

    public Double getPorcentaje() {
        return porcentaje;
    }

    public void setPorcentaje(Double porcentaje) {
        this.porcentaje = porcentaje;
    }

    public Impuesto getImpuestos() {
        return impuestos;
    }

    public void setImpuestos(Impuesto impuestos) {
        this.impuestos = impuestos;
    }

    @Override
    public String toString() {
        return "Porcentajes{" +
                "id=" + id +
                ", impuesto='" + impuesto + '\'' +
                ", codigoImpuesto='" + codigoImpuesto + '\'' +
                ", codigoTarifa='" + codigoTarifa + '\'' +
                ", porcentaje=" + porcentaje +
                '}';
    }
}
