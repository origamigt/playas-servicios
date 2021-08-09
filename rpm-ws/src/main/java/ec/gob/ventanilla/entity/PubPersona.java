package ec.gob.ventanilla.entity;


import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.gson.annotations.Expose;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "pub_persona")
public class PubPersona {

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "ced_ruc")
    private String cedRuc;
    @Column(name = "nombres")
    private String nombres;
    @Column(name = "apellidos")
    private String apellidos;
    @Column(name = "tipo_documento", length = 1)
    private String tipoDocumento;
    @Column(name = "tipo_persona", length = 1)
    private String tipoPersona;
    @Column(name = "fecha_creacion", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @JsonIgnore
    private Date fechaCreacion;
    @Column(name = "fecha_nacimiento")
    @Expose(deserialize = false, serialize = false)
    @JsonIgnore
    private Date fechaNacimiento;
    @Column(name = "direccion")
    private String direccion;
    @Column(name = "telefono1")
    private String telefono1;
    @Column(name = "telefono2")
    private String telefono2;
    @Column(name = "correo1")
    private String correo1;

    @Column(name = "correo2")
    private String correo2;
    @Column(name = "estado")
    private Boolean estado = true;
    @JsonIgnore
    @OneToOne(mappedBy = "persona")
    private AclUser usuario;

    @Column(name = "estado_civil")
    private String estadoCivil;
    @Column(name = "genero", length = 1)
    private String genero;
    @Column(name = "discapacidad")
    private Short discapacidad;
    @Column(name = "derecho")
    private Short derecho;
    @Column(name = "alcance")
    private Short alcance;
    @Column(name = "tipo_persona_ws")
    private Short tipoPersonaWs;
    @Column(name = "numero_casa", length = 100)
    private String numeroCasa;
    @Column
    private String nombreConyuge;
    @Column
    private String apellidoConyuge;
    @Transient
    private Long fechaNacimientoLong;
//CAMPO PARA LA EXPEDICION DE LA CEDULA E INICIO DE ACTIVIDADES
    @Transient
    private Long fechaExpedicionLong;
    @Column(name = "fecha_expedicion")
    @Expose(deserialize = false, serialize = false)
    @Temporal(TemporalType.DATE)
    @JsonIgnore
    private Date fechaExpedicion;
    @Transient
    private String correoCodificado;
    
    public PubPersona() {
    }

    

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCedRuc() {
        return cedRuc;
    }

    public void setCedRuc(String cedRuc) {
        this.cedRuc = cedRuc;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getTipoDocumento() {
        return tipoDocumento;
    }

    public void setTipoDocumento(String tipoDocumento) {
        this.tipoDocumento = tipoDocumento;
    }

    public String getTipoPersona() {
        return tipoPersona;
    }

    public void setTipoPersona(String tipoPersona) {
        this.tipoPersona = tipoPersona;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public Date getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono1() {
        return telefono1;
    }

    public void setTelefono1(String telefono1) {
        this.telefono1 = telefono1;
    }

    public String getTelefono2() {
        return telefono2;
    }

    public void setTelefono2(String telefono2) {
        this.telefono2 = telefono2;
    }

    public String getCorreo1() {
        return correo1;
    }

    public void setCorreo1(String correo1) {
        this.correo1 = correo1;
    }

    public String getCorreo2() {
        return correo2;
    }

    public void setCorreo2(String correo2) {
        this.correo2 = correo2;
    }

    public Boolean getEstado() {
        return estado;
    }

    public void setEstado(Boolean estado) {
        this.estado = estado;
    }

    public AclUser getUsuario() {
        return usuario;
    }

    public void setUsuario(AclUser usuario) {
        this.usuario = usuario;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getEstadoCivil() {
        return estadoCivil;
    }

    public void setEstadoCivil(String estadoCivil) {
        this.estadoCivil = estadoCivil;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public Short getDiscapacidad() {
        return discapacidad;
    }

    public void setDiscapacidad(Short discapacidad) {
        this.discapacidad = discapacidad;
    }

    public Short getDerecho() {
        return derecho;
    }

    public void setDerecho(Short derecho) {
        this.derecho = derecho;
    }

    public Short getAlcance() {
        return alcance;
    }

    public void setAlcance(Short alcance) {
        this.alcance = alcance;
    }

    public Short getTipoPersonaWs() {
        return tipoPersonaWs;
    }

    public void setTipoPersonaWs(Short tipoPersonaWs) {
        this.tipoPersonaWs = tipoPersonaWs;
    }

    public String getNumeroCasa() {
        return numeroCasa;
    }

    public void setNumeroCasa(String numeroCasa) {
        this.numeroCasa = numeroCasa;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((id == null) ? 0 : id.hashCode());
        return result;
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
        PubPersona other = (PubPersona) obj;
        if (id == null) {
            if (other.id != null) {
                return false;
            }
        } else if (!id.equals(other.id)) {
            return false;
        }
        return true;
    }

    public String getNombreConyuge() {
        return nombreConyuge;
    }

    public void setNombreConyuge(String nombreConyuge) {
        this.nombreConyuge = nombreConyuge;
    }

    public String getApellidoConyuge() {
        return apellidoConyuge;
    }

    public void setApellidoConyuge(String apellidoConyuge) {
        this.apellidoConyuge = apellidoConyuge;
    }

    @Override
    public String
    toString() {
        return "PubPersona{" +
                "id=" + id +
                ", cedRuc='" + cedRuc + '\'' +
                ", nombres='" + nombres + '\'' +
                ", apellidos='" + apellidos + '\'' +
                ", tipoDocumento='" + tipoDocumento + '\'' +
                ", tipoPersona='" + tipoPersona + '\'' +
                ", fechaCreacion=" + fechaCreacion +
                ", fechaNacimiento=" + fechaNacimiento +
                ", direccion='" + direccion + '\'' +
                ", telefono1='" + telefono1 + '\'' +
                ", telefono2='" + telefono2 + '\'' +
                ", correo1='" + correo1 + '\'' +
                ", correo2='" + correo2 + '\'' +
                ", estado=" + estado +
                //", usuario=" + usuario +
                ", estadoCivil='" + estadoCivil + '\'' +
                ", genero='" + genero + '\'' +
                ", discapacidad=" + discapacidad +
                ", derecho=" + derecho +
                ", alcance=" + alcance +
                ", tipoPersonaWs=" + tipoPersonaWs +
                ", numeroCasa='" + numeroCasa + '\'' +
                ", nombreConyuge='" + nombreConyuge + '\'' +
                ", apellidoConyuge='" + apellidoConyuge + '\'' +
                '}';
    }

    public Long getFechaNacimientoLong() {
        return fechaNacimientoLong;
    }

    public void setFechaNacimientoLong(Long fechaNacimientoLong) {
        this.fechaNacimientoLong = fechaNacimientoLong;
    }

    public Long getFechaExpedicionLong() {
        return fechaExpedicionLong;
    }

    public void setFechaExpedicionLong(Long fechaExpedicionLong) {
        this.fechaExpedicionLong = fechaExpedicionLong;
    }

    public Date getFechaExpedicion() {
        return fechaExpedicion;
    }

    public void setFechaExpedicion(Date fechaExpedicion) {
        this.fechaExpedicion = fechaExpedicion;
    }

    public String getCorreoCodificado() {
        return correoCodificado;
    }

    public void setCorreoCodificado(String correoCodificado) {
        this.correoCodificado = correoCodificado;
    }
}
