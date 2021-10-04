/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.ventanilla.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import ec.gob.ventanilla.model.UsuarioRegistro;

import javax.persistence.*;
import java.util.Date;

/**
 *
 * @author ORIGAMI
 */
@Entity
@Table(name = "codigo_correo")
public class CodigoCorreo {

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String codigo;
    private String correo;
    private String celular;
    private Boolean validado;
    @JsonIgnore
    private Date fecha;
    private String persona;
    private String identificacion;
    @Transient
    private UsuarioRegistro usuarioRegistro;

    public CodigoCorreo() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getPersona() {
        return persona;
    }

    public void setPersona(String persona) {
        this.persona = persona;
    }

    public String getIdentificacion() {
        return identificacion;
    }

    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }

    public Boolean getValidado() {
        return validado;
    }

    public void setValidado(Boolean validado) {
        this.validado = validado;
    }

    public String getCelular() {
        return celular;
    }

    public void setCelular(String celular) {
        this.celular = celular;
    }

    public UsuarioRegistro getUsuarioRegistro() {
        return usuarioRegistro;
    }

    public void setUsuarioRegistro(UsuarioRegistro usuarioRegistro) {
        this.usuarioRegistro = usuarioRegistro;
    }
}
