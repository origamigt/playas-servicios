package com.facturacion.entites;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(schema = "conf", name = "msg_formato_notificacion")
public class MsgFormatoNotificacion implements Serializable{

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Column
    private String header;
    @Column
    private String footer;
    @Column
    private String asunto;
    @Column
    private Integer estado;
    @Column
    private Long tipo;

    public MsgFormatoNotificacion() {
    }

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
    }

    public String getFooter() {
        return footer;
    }

    public void setFooter(String footer) {
        this.footer = footer;
    }

    public String getAsunto() {
        return asunto;
    }

    public void setAsunto(String asunto) {
        this.asunto = asunto;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getEstado() {
        return estado;
    }

    public void setEstado(Integer estado) {
        this.estado = estado;
    }

    public Long getTipo() {
        return tipo;
    }

    public void setTipo(Long tipo) {
        this.tipo = tipo;
    }

    @Override
    public String toString() {
        return "MsgFormatoNotificacion{" + "id=" + id + ", header=" + header + ", footer=" + footer + ", asunto=" + asunto + ", estado=" + estado + ", tipo=" + tipo + '}';
    }

}
