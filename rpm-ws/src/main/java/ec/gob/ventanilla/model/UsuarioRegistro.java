package ec.gob.ventanilla.model;

import java.util.Arrays;

public class UsuarioRegistro {

    private Long personaId;
    private String identificacion;
    private Boolean creado;
    private String fechaExpedicion;
    private String nombresCompletos;
    private String direccion;
    private String celular;
    private String clave;
    private String correo;
    private String correoCodificado;
    private String tipo;
    private byte[] archivo;

    public String getIdentificacion() {
        return identificacion;
    }

    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }

    public String getFechaExpedicion() {
        return fechaExpedicion;
    }

    public void setFechaExpedicion(String fechaExpedicion) {
        this.fechaExpedicion = fechaExpedicion;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getNombresCompletos() {
        return nombresCompletos;
    }

    public void setNombresCompletos(String nombresCompletos) {
        this.nombresCompletos = nombresCompletos;
    }

    public String getCelular() {
        return celular;
    }

    public void setCelular(String celular) {
        this.celular = celular;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public Long getPersonaId() {
        return personaId;
    }

    public void setPersonaId(Long personaId) {
        this.personaId = personaId;
    }

    public Boolean getCreado() {
        return creado;
    }

    public void setCreado(Boolean creado) {
        this.creado = creado;
    }

    public String getCorreoCodificado() {
        return correoCodificado;
    }

    public void setCorreoCodificado(String correoCodificado) {
        this.correoCodificado = correoCodificado;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public byte[] getArchivo() {
        return archivo;
    }

    public void setArchivo(byte[] archivo) {
        this.archivo = archivo;
    }

    @Override
    public String toString() {
        return "UsuarioRegistro{" +
                "personaId=" + personaId +
                ", identificacion='" + identificacion + '\'' +
                ", creado=" + creado +
                ", fechaExpedicion='" + fechaExpedicion + '\'' +
                ", nombresCompletos='" + nombresCompletos + '\'' +
                ", direccion='" + direccion + '\'' +
                ", celular='" + celular + '\'' +
                ", clave='" + clave + '\'' +
                ", correo='" + correo + '\'' +
                ", correoCodificado='" + correoCodificado + '\'' +
                ", tipo='" + tipo + '\'' +
                ", multipartFile=" + Arrays.toString(archivo) +
                '}';
    }
}
