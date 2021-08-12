package com.facturacion.entites;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "comprobante")
public class Comprobante implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    private String descripcion;
    private String codigo;
    private Boolean retiene = false;

    public Comprobante() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public Boolean getRetiene() {
        return retiene;
    }

    public void setRetiene(Boolean retiene) {
        this.retiene = retiene;
    }

    @Override
    public String toString() {
        return "Comprobante{" + "id=" + id + ", descripcion=" + descripcion + ", codigo=" + codigo + ", retiene=" + retiene + '}';
    }

}
