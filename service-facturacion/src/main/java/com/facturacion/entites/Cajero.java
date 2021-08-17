/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.facturacion.entites;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author Administrator
 */
@Entity
@Table(name = "cajero")
public class Cajero implements Serializable{
    
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @JoinColumn(name = "entidad", referencedColumnName = "id")
    @ManyToOne(fetch = javax.persistence.FetchType.LAZY)
    private Entidad entidad;
    private String usuario;
    @Column(name = "punto_emision")
    private String puntoEmision;
    private String archivo;
    private String clave;
    @Column(name = "fecha_caducidad")
    @Temporal(TemporalType.DATE)
    private Date fechaCaducidad;
    @Column(name = "variable_secuencia_facturas")
    private String variableSecuenciaFacturas;
    @Column(name = "variable_secuencia_nota_credito")
    private String variableSecuenciaNotaCredito;
    @Column(name = "variable_secuencia_nota_debito")
    private String variableSecuenciaNotaDebito;
    @Column(name = "variable_secuencia_retencion")
    private String variableSecuenciaRetencion;
    @Column(name = "variable_secuencia_guia_remision")
    private String variableSecuenciaGuiaRemision;
    private Boolean estado;
    @Column(name = "fecha_creacion")
    @Temporal(TemporalType.DATE)
    private Date fechaCreacion;

    public Cajero() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Entidad getEntidad() {
        return entidad;
    }

    public void setEntidad(Entidad entidad) {
        this.entidad = entidad;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getPuntoEmision() {
        return puntoEmision;
    }

    public void setPuntoEmision(String puntoEmision) {
        this.puntoEmision = puntoEmision;
    }

    public String getArchivo() {
        return archivo;
    }

    public void setArchivo(String archivo) {
        this.archivo = archivo;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public Date getFechaCaducidad() {
        return fechaCaducidad;
    }

    public void setFechaCaducidad(Date fechaCaducidad) {
        this.fechaCaducidad = fechaCaducidad;
    }

    public String getVariableSecuenciaFacturas() {
        return variableSecuenciaFacturas;
    }

    public void setVariableSecuenciaFacturas(String variableSecuenciaFacturas) {
        this.variableSecuenciaFacturas = variableSecuenciaFacturas;
    }

    public String getVariableSecuenciaNotaCredito() {
        return variableSecuenciaNotaCredito;
    }

    public void setVariableSecuenciaNotaCredito(String variableSecuenciaNotaCredito) {
        this.variableSecuenciaNotaCredito = variableSecuenciaNotaCredito;
    }

    public String getVariableSecuenciaNotaDebito() {
        return variableSecuenciaNotaDebito;
    }

    public void setVariableSecuenciaNotaDebito(String variableSecuenciaNotaDebito) {
        this.variableSecuenciaNotaDebito = variableSecuenciaNotaDebito;
    }

    public String getVariableSecuenciaRetencion() {
        return variableSecuenciaRetencion;
    }

    public void setVariableSecuenciaRetencion(String variableSecuenciaRetencion) {
        this.variableSecuenciaRetencion = variableSecuenciaRetencion;
    }

    public String getVariableSecuenciaGuiaRemision() {
        return variableSecuenciaGuiaRemision;
    }

    public void setVariableSecuenciaGuiaRemision(String variableSecuenciaGuiaRemision) {
        this.variableSecuenciaGuiaRemision = variableSecuenciaGuiaRemision;
    }

    public Boolean getEstado() {
        return estado;
    }

    public void setEstado(Boolean estado) {
        this.estado = estado;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    @Override
    public String toString() {
        return "Cajero{" + "id=" + id + ", entidad=" + entidad + ", usuario=" + usuario + ", puntoEmision=" + puntoEmision + ", archivo=" + archivo + ", clave=" + clave + ", fechaCaducidad=" + fechaCaducidad + ", variableSecuenciaFacturas=" + variableSecuenciaFacturas + ", variableSecuenciaNotaCredito=" + variableSecuenciaNotaCredito + ", variableSecuenciaNotaDebito=" + variableSecuenciaNotaDebito + ", variableSecuenciaRetencion=" + variableSecuenciaRetencion + ", variableSecuenciaGuiaRemision=" + variableSecuenciaGuiaRemision + ", estado=" + estado + ", fechaCreacion=" + fechaCreacion + '}';
    }
    
}
