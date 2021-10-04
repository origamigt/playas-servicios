/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.ventanilla.model;

import javax.persistence.Transient;

/**
 *
 * @author ORIGAMI
 */
public class ActoRequisito {

    private Long id;
    private Long requisitoActo;
    private Integer idActo;
    private String acto;
    private Integer idRequisito;
    private String requisito;
    private Long documento;
    private Boolean requerido;
    private String nombreArchivo;
    private String fecha;
    private byte[] archivo;


    public ActoRequisito() {
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

    public Boolean getRequerido() {
        return requerido;
    }

    public void setRequerido(Boolean requerido) {
        this.requerido = requerido;
    }

    public String getNombreArchivo() {
        return nombreArchivo;
    }

    public void setNombreArchivo(String nombreArchivo) {
        this.nombreArchivo = nombreArchivo;
    }

    public byte[] getArchivo() {
        return archivo;
    }

    public void setArchivo(byte[] archivo) {
        this.archivo = archivo;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }
}
