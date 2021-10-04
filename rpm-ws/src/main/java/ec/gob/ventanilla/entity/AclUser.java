package ec.gob.ventanilla.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "pub_usuario")
public class AclUser implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Basic(optional = false)
    private String usuario;
    private String clave;
    private String observacion;
    private Boolean habilitado;
    private Long documento;
    @JsonIgnore
    @ManyToOne(optional = false)
    @JoinColumn(name = "rol", nullable = false)
    private AclRol rol;
    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "persona")
    private PubPersona persona;
    @JsonIgnore
    @OneToMany(mappedBy = "user")
    private List<PubSolicitud> solicitudes;
    @Transient
    private Integer personaID;

    public AclUser(Integer id, String usuario, String clave, Boolean habilitado, PubPersona persona) {
        super();
        this.id = id;
        this.usuario = usuario;
        this.clave = clave;
        this.habilitado = habilitado;
        this.persona = persona;
    }

    public AclUser(String token) {
        super();
    }

    public AclUser() {
    }

    public AclUser(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public AclRol getRol() {
        return rol;
    }

    public void setRol(AclRol rol) {
        this.rol = rol;
    }

    public Boolean getHabilitado() {
        return habilitado;
    }

    public void setHabilitado(Boolean habilitado) {
        this.habilitado = habilitado;
    }

    public PubPersona getPersona() {
        return persona;
    }

    public void setPersona(PubPersona persona) {
        this.persona = persona;
    }

    //    public String getToken() {
//        return token;
//    }
//
//    public void setToken(String token) {
//        this.token = token;
//    }
    public Integer getPersonaID() {
        return personaID;
    }

    public void setPersonaID(Integer personaID) {
        this.personaID = personaID;
    }

    public List<PubSolicitud> getSolicitudes() {
        return solicitudes;
    }

    public void setSolicitudes(List<PubSolicitud> solicitudes) {
        this.solicitudes = solicitudes;
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
        AclUser other = (AclUser) obj;
        if (id == null) {
            if (other.id != null) {
                return false;
            }
        } else if (!id.equals(other.id)) {
            return false;
        }
        return true;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public Long getDocumento() {
        return documento;
    }

    public void setDocumento(Long documento) {
        this.documento = documento;
    }
}
