package com.facturacion.modelcomprobante;

public class Cabecera {

    private String fechaEmision;
    private String cedulaRuc;
    private String propietario;
    private String direccion;
    private String correo;
    private String telefono;
    private Boolean esPasaporte;

    public Cabecera() {
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getFechaEmision() {
        return fechaEmision;
    }

    public void setFechaEmision(String fechaEmision) {
        this.fechaEmision = fechaEmision;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getPropietario() {
        return propietario;
    }

    public void setPropietario(String propietario) {
        this.propietario = propietario;
    }

    public String getCedulaRuc() {
        return cedulaRuc;
    }

    public void setCedulaRuc(String cedulaRuc) {
        this.cedulaRuc = cedulaRuc;
    }

    public Boolean getEsPasaporte() {
        return esPasaporte;
    }

    public void setEsPasaporte(Boolean esPasaporte) {
        this.esPasaporte = esPasaporte;
    }

    @Override
    public String toString() {
        return "Cabecera{" +
                "direccion='" + direccion + '\'' +
             //   ", entidadTributaria='" + entidadTributaria + '\'' +
                ", fechaEmision='" + fechaEmision + '\'' +
                ", correo='" + correo + '\'' +
                ", telefono='" + telefono + '\'' +
                ", propietario='" + propietario + '\'' +
                ", cedulaRuc='" + cedulaRuc + '\'' +
                '}';
    }
}
