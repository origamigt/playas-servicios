package ec.gob.ventanilla.entity;

import javax.persistence.*;
import java.util.Date;

/**
 *
 * @author Willian_EnriqueZzz
 */
@Entity
@Table(name = "app_logs")
public class AppLogs {


    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "fecha")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fecha;
    @Column(name = "text_log")
    private String textLog;
    @Column(name = "token")
    private String token;
    @Column(name = "metodo")
    private String metodo;
    @Column(name = "ip")
    private String ip;

    public AppLogs() {

    }

    public AppLogs(Date fecha, String textLog, String token, String metodo, String ip) {
        super();
        this.fecha = fecha;
        this.textLog = textLog;
        this.token = token;
        this.metodo = metodo;
        this.ip = ip;

    }
    

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getTextLog() {
        return textLog;
    }

    public void setTextLog(String textLog) {
        this.textLog = textLog;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getMetodo() {
        return metodo;
    }

    public void setMetodo(String metodo) {
        this.metodo = metodo;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

//    @Override
//    public int hashCode() {
//        final int prime = 31;
//        int result = 1;
//        result = prime * result + ((id == null) ? 0 : id.hashCode());
//        return result;
//    }
//
//    @Override
//    public boolean equals(Object obj) {
//        if (this == obj) {
//            return true;
//        }
//        if (obj == null) {
//            return false;
//        }
//        if (getClass() != obj.getClass()) {
//            return false;
//        }
//        AppLogs other = (AppLogs) obj;
//        if (id == null) {
//            if (other.id != null) {
//                return false;
//            }
//        } else if (!id.equals(other.id)) {
//            return false;
//        }
//        return true;
//    }
    @Override
    public String toString() {
        return "AppLogs{"
                + "id=" + id
                + ",fecha=" + fecha
                + ",text_log" + textLog
                + ",metodo" + metodo
                + ", ip=" + ip + "}";
    }

}
