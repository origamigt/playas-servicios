package com.facturacion.entites.comprobanterespuestasri;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class ComprobanteEntidadSRI {

    private String idemtificacion;
    private String nombres;
    private String nombreComercial;
    private String contribuyenteEspecial;
    private String obligadoContabilidad;
    private String direccion;
    private String direccionMatriz;
    private String direccionSucursal;
    private String telefono;
    private String email;
    private String logo;

    @JsonIgnore
    private String _class;

    public String getIdemtificacion() {
        return idemtificacion;
    }

    public void setIdemtificacion(String idemtificacion) {
        this.idemtificacion = idemtificacion;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getNombreComercial() {
        return nombreComercial;
    }

    public void setNombreComercial(String nombreComercial) {
        this.nombreComercial = nombreComercial;
    }

    public String getContribuyenteEspecial() {
        return contribuyenteEspecial;
    }

    public void setContribuyenteEspecial(String contribuyenteEspecial) {
        this.contribuyenteEspecial = contribuyenteEspecial;
    }

    public String getObligadoContabilidad() {
        return obligadoContabilidad;
    }

    public void setObligadoContabilidad(String obligadoContabilidad) {
        this.obligadoContabilidad = obligadoContabilidad;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getDireccionMatriz() {
        return direccionMatriz;
    }

    public void setDireccionMatriz(String direccionMatriz) {
        this.direccionMatriz = direccionMatriz;
    }

    public String getDireccionSucursal() {
        return direccionSucursal;
    }

    public void setDireccionSucursal(String direccionSucursal) {
        this.direccionSucursal = direccionSucursal;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String get_class() {
        return this.getClass().getCanonicalName();
    }

    public void set_class(String _class) {
        this._class = this.getClass().getCanonicalName();
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }
}
