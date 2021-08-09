/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.ventanilla.entity;

import javax.persistence.*;
import java.util.Date;

/**
 *
 * @author ORIGAMI
 */
@Entity
@Table(name = "solicitud_requisitos")
public class SolicitudRequisito {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "solicitud")
    private PubSolicitud solicitud;
    private Long requisitoActo;
    private Integer idActo;
    private String acto;
    private Integer idRequisito;
    private String requisito;
    private Long documento;
    private String tipo;
    private Date fecha;

    public SolicitudRequisito() {
    }

    public Long getRequisitoActo() {
        return requisitoActo;
    }

    public void setRequisitoActo(Long requisitoActo) {
        this.requisitoActo = requisitoActo;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public PubSolicitud getSolicitud() {
        return solicitud;
    }

    public void setSolicitud(PubSolicitud solicitud) {
        this.solicitud = solicitud;
    }

    public Integer getIdActo() {
        return idActo;
    }

    public void setIdActo(Integer idActo) {
        this.idActo = idActo;
    }

    public String getActo() {
        return acto;
    }

    public void setActo(String acto) {
        this.acto = acto;
    }

    public Integer getIdRequisito() {
        return idRequisito;
    }

    public void setIdRequisito(Integer idRequisito) {
        this.idRequisito = idRequisito;
    }

    public String getRequisito() {
        return requisito;
    }

    public void setRequisito(String requisito) {
        this.requisito = requisito;
    }

    public Long getDocumento() {
        return documento;
    }

    public void setDocumento(Long documento) {
        this.documento = documento;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

}
