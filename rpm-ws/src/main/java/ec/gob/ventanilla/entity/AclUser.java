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
    @Column(name = "usuario", nullable = false)
    private String username;
    @Column(name = "clave", nullable = false)
    private String pass;
    @Column(name = "habilitado")
    private Boolean habilitado;
    @JsonIgnore
    @ManyToOne(optional = false)
    @JoinColumn(name = "rol", nullable = false)
    private AclRol rol;
    //@JsonIgnore
    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "persona")
    private PubPersona persona;
//    @Column(name = "token")
//    private String token;
    @JsonIgnore
    @OneToMany(mappedBy = "user")
    private List<PubSolicitud> solicitudes;
    @Transient
    private String urlRp;
    @Transient
    private Integer personaID;

    public void fill(String username, String pass, Boolean habilitado, AclRol rol, PubPersona persona) {
        this.setUsername(username);
        this.setPass(pass);
        this.setHabilitado(habilitado);
        this.setRol(rol);
        this.setPersona(persona);
    }

    public AclUser(Integer id, String username, String pass, Boolean habilitado, PubPersona persona) {
        super();
        this.id = id;
        this.username = username;
        this.pass = pass;
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
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

    @Override
    public String toString() {
        return "AclUser{"
                + "id=" + id
                + ", username='" + username + '\''
                + ", pass='" + pass + '\''
                + ", habilitado=" + habilitado
                + ", rol=" + rol
                + ", persona=" + persona
                + '}';
    }

    public String getUrlRp() {
        return urlRp;
    }

    public void setUrlRp(String urlRp) {
        this.urlRp = urlRp;
    }
}
