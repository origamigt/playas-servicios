/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.facturacion.entites;

import java.util.Date;

/**
 *
 * @author Administrator
 */
public class Firma {
    
    private Date fechaEmision;
    private Date fechaCaducidad;
    private String archivo;
    private String password;
    private String estado;
    private Date deleteAt;

    public Firma() {

}
    
    public Date getFechaEmision() {
        return fechaEmision;
    }

    public void setFechaEmision(Date fechaEmision) {
        this.fechaEmision = fechaEmision;
    }

    public Date getFechaCaducidad() {
        return fechaCaducidad;
    }

    public void setFechaCaducidad(Date fechaCaducidad) {
        this.fechaCaducidad = fechaCaducidad;
    }

    public String getArchivo() {
        return archivo;
    }

    public void setArchivo(String archivo) {
        this.archivo = archivo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Date getDeleteAt() {
        return deleteAt;
    }

  /*  public Date getCreatedAt() {return createdAt;}public void setCreatedAt(Date createdAt) {this.createdAt = createdAt;}public Date getUpdatedAt() {return updatedAt;}public void setUpdatedAt(Date updatedAt) {this.updatedAt = updatedAt;}*/

    public void setDeleteAt(Date deleteAt) {
        this.deleteAt = deleteAt;
    }
}
