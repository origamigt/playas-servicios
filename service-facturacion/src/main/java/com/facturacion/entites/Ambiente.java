package com.facturacion.entites;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ambiente")
public class Ambiente implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    private String descripcion;
    private String codigo;
    private Boolean activo = Boolean.FALSE;
    @Column(name = "ws_url_recepcion")
    private String wsUrlRecepcion;
    @Column(name = "ws_url_autorizacion")
    private String wsUrlAutorizacion;

    public Ambiente() {
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

    public Boolean getActivo() {
        return activo;
    }

    public void setActivo(Boolean activo) {
        this.activo = activo;
    }

    public String getWsUrlRecepcion() {
        return wsUrlRecepcion;
    }

    public void setWsUrlRecepcion(String wsUrlRecepcion) {
        this.wsUrlRecepcion = wsUrlRecepcion;
    }

    public String getWsUrlAutorizacion() {
        return wsUrlAutorizacion;
    }

    public void setWsUrlAutorizacion(String wsUrlAutorizacion) {
        this.wsUrlAutorizacion = wsUrlAutorizacion;
    }

    @Override
    public String toString() {
        return "Ambiente{" + "id=" + id + ", descripcion=" + descripcion + ", codigo=" + codigo + ", activo=" + activo + ", wsUrlRecepcion=" + wsUrlRecepcion + ", wsUrlAutorizacion=" + wsUrlAutorizacion + '}';
    }

}
