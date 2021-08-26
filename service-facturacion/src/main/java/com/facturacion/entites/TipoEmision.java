package com.facturacion.entites;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "tipo_emision")
public class TipoEmision implements Serializable{

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Column
    private String descripcion;
    @Column
    private String codigo;
    @Column(name = "es_online")
    private Boolean esOnline;
    
    public TipoEmision() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Boolean getEsOnline() {
        return esOnline;
    }

    public void setEsOnline(Boolean esOnline) {
        this.esOnline = esOnline;
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

    @Override
    public String toString() {
        return "TipoEmision{" + "id=" + id + ", descripcion=" + descripcion + ", codigo=" + codigo + ", esOnline=" + esOnline + '}';
    }

}
