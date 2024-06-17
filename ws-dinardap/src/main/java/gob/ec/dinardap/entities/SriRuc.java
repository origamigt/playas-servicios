/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package gob.ec.dinardap.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.io.Serializable;
import java.util.Date;
import java.util.Objects;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author eduar
 */
@Entity
@Table(name = "sri_ruc_guayas", schema = "temp")
public class SriRuc implements Serializable{
    
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id", nullable = false)
    @JsonIgnore
    private Long id;
    private String numeroRuc;
    private String razonSocial;
    private String provinciaJurisdiccion;
    private String nombreComercial;
    private String estadoContribuyente;
    private String claseContribuyente;
    @Temporal(TemporalType.DATE)
    private Date fechaInicioActividades;
    @Temporal(TemporalType.DATE)
    private Date fechaActualizacion;
    @Temporal(TemporalType.DATE)
    private Date fechaSuspencionDefinitiva;
    @Temporal(TemporalType.DATE)
    private Date fechaReinicioActividades;
    private String obligado;
    private String tipoContribuyente;
    private String numeroEstablecimiento;
    private String nombreFantasiaComercial;
    private String estadoEstablecimiento;
    private String descripcionProvinciaEst;
    private String descripcionCantonEst;
    private String descripcionParroquiaEst;
    private String codigoCiiu;
    private String actividadEconomica;
    private Boolean verificado;
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaVerificacion;
    private String correo;
    private String cargoRepresentante;
    private String identificacionRepresentante;
    private String nombreRepresentante;

    public SriRuc() {
    }

    public SriRuc(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNumeroRuc() {
        return numeroRuc;
    }

    public void setNumeroRuc(String numeroRuc) {
        this.numeroRuc = numeroRuc;
    }

    public String getRazonSocial() {
        return razonSocial;
    }

    public void setRazonSocial(String razonSocial) {
        this.razonSocial = razonSocial;
    }

    public String getProvinciaJurisdiccion() {
        return provinciaJurisdiccion;
    }

    public void setProvinciaJurisdiccion(String provinciaJurisdiccion) {
        this.provinciaJurisdiccion = provinciaJurisdiccion;
    }

    public String getNombreComercial() {
        return nombreComercial;
    }

    public void setNombreComercial(String nombreComercial) {
        this.nombreComercial = nombreComercial;
    }

    public String getEstadoContribuyente() {
        return estadoContribuyente;
    }

    public void setEstadoContribuyente(String estadoContribuyente) {
        this.estadoContribuyente = estadoContribuyente;
    }

    public String getClaseContribuyente() {
        return claseContribuyente;
    }

    public void setClaseContribuyente(String claseContribuyente) {
        this.claseContribuyente = claseContribuyente;
    }

    public Date getFechaInicioActividades() {
        return fechaInicioActividades;
    }

    public void setFechaInicioActividades(Date fechaInicioActividades) {
        this.fechaInicioActividades = fechaInicioActividades;
    }

    public Date getFechaActualizacion() {
        return fechaActualizacion;
    }

    public void setFechaActualizacion(Date fechaActualizacion) {
        this.fechaActualizacion = fechaActualizacion;
    }

    public Date getFechaSuspencionDefinitiva() {
        return fechaSuspencionDefinitiva;
    }

    public void setFechaSuspencionDefinitiva(Date fechaSuspencionDefinitiva) {
        this.fechaSuspencionDefinitiva = fechaSuspencionDefinitiva;
    }

    public Date getFechaReinicioActividades() {
        return fechaReinicioActividades;
    }

    public void setFechaReinicioActividades(Date fechaReinicioActividades) {
        this.fechaReinicioActividades = fechaReinicioActividades;
    }

    public String getObligado() {
        return obligado;
    }

    public void setObligado(String obligado) {
        this.obligado = obligado;
    }

    public String getTipoContribuyente() {
        return tipoContribuyente;
    }

    public void setTipoContribuyente(String tipoContribuyente) {
        this.tipoContribuyente = tipoContribuyente;
    }

    public String getNumeroEstablecimiento() {
        return numeroEstablecimiento;
    }

    public void setNumeroEstablecimiento(String numeroEstablecimiento) {
        this.numeroEstablecimiento = numeroEstablecimiento;
    }

    public String getNombreFantasiaComercial() {
        return nombreFantasiaComercial;
    }

    public void setNombreFantasiaComercial(String nombreFantasiaComercial) {
        this.nombreFantasiaComercial = nombreFantasiaComercial;
    }

    public String getEstadoEstablecimiento() {
        return estadoEstablecimiento;
    }

    public void setEstadoEstablecimiento(String estadoEstablecimiento) {
        this.estadoEstablecimiento = estadoEstablecimiento;
    }

    public String getDescripcionProvinciaEst() {
        return descripcionProvinciaEst;
    }

    public void setDescripcionProvinciaEst(String descripcionProvinciaEst) {
        this.descripcionProvinciaEst = descripcionProvinciaEst;
    }

    public String getDescripcionCantonEst() {
        return descripcionCantonEst;
    }

    public void setDescripcionCantonEst(String descripcionCantonEst) {
        this.descripcionCantonEst = descripcionCantonEst;
    }

    public String getDescripcionParroquiaEst() {
        return descripcionParroquiaEst;
    }

    public void setDescripcionParroquiaEst(String descripcionParroquiaEst) {
        this.descripcionParroquiaEst = descripcionParroquiaEst;
    }

    public String getCodigoCiiu() {
        return codigoCiiu;
    }

    public void setCodigoCiiu(String codigoCiiu) {
        this.codigoCiiu = codigoCiiu;
    }

    public String getActividadEconomica() {
        return actividadEconomica;
    }

    public void setActividadEconomica(String actividadEconomica) {
        this.actividadEconomica = actividadEconomica;
    }

    public Boolean getVerificado() {
        return verificado;
    }

    public void setVerificado(Boolean verificado) {
        this.verificado = verificado;
    }

    public Date getFechaVerificacion() {
        return fechaVerificacion;
    }

    public void setFechaVerificacion(Date fechaVerificacion) {
        this.fechaVerificacion = fechaVerificacion;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getCargoRepresentante() {
        return cargoRepresentante;
    }

    public void setCargoRepresentante(String cargoRepresentante) {
        this.cargoRepresentante = cargoRepresentante;
    }

    public String getIdentificacionRepresentante() {
        return identificacionRepresentante;
    }

    public void setIdentificacionRepresentante(String identificacionRepresentante) {
        this.identificacionRepresentante = identificacionRepresentante;
    }

    public String getNombreRepresentante() {
        return nombreRepresentante;
    }

    public void setNombreRepresentante(String nombreRepresentante) {
        this.nombreRepresentante = nombreRepresentante;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 79 * hash + Objects.hashCode(this.id);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final SriRuc other = (SriRuc) obj;
        return Objects.equals(this.id, other.id);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("SriRuc{");
        sb.append("id=").append(id);
        sb.append(", numeroRuc=").append(numeroRuc);
        sb.append(", razonSocial=").append(razonSocial);
        sb.append(", provinciaJurisdiccion=").append(provinciaJurisdiccion);
        sb.append(", nombreComercial=").append(nombreComercial);
        sb.append(", estadoContribuyente=").append(estadoContribuyente);
        sb.append(", claseContribuyente=").append(claseContribuyente);
        sb.append(", fechaInicioActividades=").append(fechaInicioActividades);
        sb.append(", fechaActualizacion=").append(fechaActualizacion);
        sb.append(", fechaSuspencionDefinitiva=").append(fechaSuspencionDefinitiva);
        sb.append(", fechaReinicioActividades=").append(fechaReinicioActividades);
        sb.append(", obligado=").append(obligado);
        sb.append(", tipoContribuyente=").append(tipoContribuyente);
        sb.append(", numeroEstablecimiento=").append(numeroEstablecimiento);
        sb.append(", nombreFantasiaComercial=").append(nombreFantasiaComercial);
        sb.append(", estadoEstablecimiento=").append(estadoEstablecimiento);
        sb.append(", descripcionProvinciaEst=").append(descripcionProvinciaEst);
        sb.append(", descripcionCantonEst=").append(descripcionCantonEst);
        sb.append(", descripcionParroquiaEst=").append(descripcionParroquiaEst);
        sb.append(", codigoCiiu=").append(codigoCiiu);
        sb.append(", actividadEconomica=").append(actividadEconomica);
        sb.append('}');
        return sb.toString();
    }

}
