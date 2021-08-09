package ec.gob.ventanilla.entity;

import javax.persistence.*;

@Entity
@Table(name = "acto")
public class Acto {

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String acto;
    private String descripcionBreve;
    private String descripcion;
    private String urlImage;
    private Integer orden;
    private Double valor;
    private String tiempoEntrega;
    private String requisito;
    private String urlRp;
    private Boolean certificado;
    private Boolean tramiteBanca;
    @Transient
    private Boolean certificadoNoPoseerBien = Boolean.FALSE;

    public Acto() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getActo() {
        return acto;
    }

    public void setActo(String acto) {
        this.acto = acto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getDescripcionBreve() {
        return descripcionBreve;
    }

    public void setDescripcionBreve(String descripcionBreve) {
        this.descripcionBreve = descripcionBreve;
    }

    public String getUrlImage() {
        return urlImage;
    }

    public void setUrlImage(String urlImage) {
        this.urlImage = urlImage;
    }

    public Double getValor() {
        return valor;
    }

    public void setValor(Double valor) {
        this.valor = valor;
    }

    public String getTiempoEntrega() {
        return tiempoEntrega;
    }

    public void setTiempoEntrega(String tiempoEntrega) {
        this.tiempoEntrega = tiempoEntrega;
    }

    public Integer getOrden() {
        return orden;
    }

    public void setOrden(Integer orden) {
        this.orden = orden;
    }

    public String getRequisito() {
        return requisito;
    }

    public void setRequisito(String requisito) {
        this.requisito = requisito;
    }

    public String getUrlRp() {
        return urlRp;
    }

    public void setUrlRp(String urlRp) {
        this.urlRp = urlRp;
    }

    public Boolean getCertificadoNoPoseerBien() {
        return certificadoNoPoseerBien;
    }

    public void setCertificadoNoPoseerBien(Boolean certificadoNoPoseerBien) {
        this.certificadoNoPoseerBien = certificadoNoPoseerBien;
    }

    public Boolean getCertificado() {
        return certificado;
    }

    public void setCertificado(Boolean certificado) {
        this.certificado = certificado;
    }

    public Boolean getTramiteBanca() {
        return tramiteBanca;
    }

    public void setTramiteBanca(Boolean tramiteBanca) {
        this.tramiteBanca = tramiteBanca;
    }
    
}
