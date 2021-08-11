/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.ventanilla.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import ec.gob.ventanilla.model.ActoRequisito;


import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "pub_solicitud")
public class PubSolicitud implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Column(name = "sol_tipo_persona")
    private String solTipoPersona;
    @Column(name = "sol_tipo_doc")
    private String solTipoDoc;
    @Column(name = "sol_apellidos")
    private String solApellidos;
    @Column(name = "sol_nombres")
    private String solNombres;
    @Column(name = "sol_cedula")
    private String solCedula;
    @Column(name = "sol_provincia")
    private String solProvincia;
    @Column(name = "sol_ciudad")
    private String solCiudad;
    @Column(name = "sol_parroquia")
    private String solParroquia;
    @Column(name = "sol_calles")
    private String solCalles;
    @Column(name = "sol_numero_casa")
    private String solNumeroCasa;
    @Column(name = "sol_celular")
    private String solCelular;
    @Column(name = "sol_convencional")
    private String solConvencional;
    @Column(name = "sol_correo")
    private String solCorreo;
    @Column(name = "sol_estado_civil")
    private String solEstadoCivil;
    @Column(name = "fecha_solicitud")
    @Temporal(TemporalType.TIMESTAMP)
    @JsonIgnore
    private Date fechaSolicitud;
    //ID ACTO =O
    @Column(name = "tipo_solicitud")
    private Integer tipoSolicitud;
    @Column(name = "motivo_solicitud")
    private Integer motivoSolicitud;
    @Column(name = "otro_motivo")
    private String otroMotivo;
    @Column(name = "numero_ficha")
    private Integer numeroFicha;
    @Column(name = "clave_catastral")
    private String claveCatastral;
    @Column(name = "tipo_inmueble")
    private String tipoInmueble;
    @Column(name = "prop_estado_civil")
    private String propEstadoCivil;
    @Column(name = "prop_tipo_persona")
    private String propTipoPersona;
    @Column(name = "prop_tipo_doc")
    private String propTipoDoc;
    @Column(name = "prop_cedula")
    private String propCedula;
    @Column(name = "prop_nombres")
    private String propNombres;
    @Column(name = "prop_apellidos")
    private String propApellidos;
    @Column(name = "prop_conyugue_cedula")
    private String propConyugueCedula;
    @Column(name = "prop_conyugue_nombres")
    private String propConyugueNombres;
    @Column(name = "prop_conyugue_apellidos")
    private String propConyugueApellidos;
    @Column(name = "observacion")
    private String observacion;
    @Column(name = "ben_tipo_persona")
    private String benTipoPersona;
    @Column(name = "ben_tipo_doc")
    private String benTipoDoc;
    @Column(name = "ben_documento")
    private String benDocumento;
    @Column(name = "ben_nombres")
    private String benNombres;
    @Column(name = "ben_apellidos")
    private String benApellidos;
    @Column(name = "ben_direccion")
    private String benDireccion;
    @Column(name = "ben_telefono")
    private String benTelefono;
    @Column(name = "ben_correo")
    private String benCorreo;
    @Column(name = "installments_type")
    private Short installmentsType;
    @Column(name = "payframe_url")
    private String payframeUrl; //TIPO DE APLICACION WEB O VENTANILLA
    @Column(name = "fecha_entrega")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaEntrega;
    @Column(name = "fecha_ingreso")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaIngreso;
    @Column(name = "fecha_inscripcion")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaInscripcion;
    private Long numeroTramite;
    private Boolean sendEmail;
    @Column(name = "oid_document")
    private Long oidDocument;
    @Column(name = "oid_document2")
    private Long oidDocument2;
    @Column(name = "oid_document3")
    private Long oidDocument3;
    private String image1;
    private String image2;
    private String image3;
    private String lote;
    private Integer numInscripcion;
    @JoinColumn(name = "user_", referencedColumnName = "id")
    @ManyToOne
    //@Expose(serialize = false)
    private AclUser user;
    private Double total;
    private Integer anioInscripcion;
    private String estado;
    private Boolean tipoPago;  //TRUE: VENTANILLA FALSE: PAGO EN LINEA
    private Integer cantidad;
    private Integer anioUltimaTransferencia = 0;
    private Integer anioAntecedenteSolicitado = 0;
    private Boolean ingresado;
    private String tipoFormulario;
    private Boolean tieneNotificacion;
    private String notificacion;
    private String linkPago;
    private String paymentId;
    private String payWithPayPhone;
    private Boolean procesando;  //PARA VALIDAR LA CONFIRMACION DEL PAGO
    private Long numeroTramiteInscripcion;

    @Transient
    private String acto;
    @Transient
    private Double avance = 0.1;
    @Transient
    private List<ActoRequisito> requisitos;
    @Transient
    private Long fechaSolicitudLong;
    @Transient
    private Long fechaInscripcionLong;
    public Integer getAnioUltimaTranferencia() {
        return anioUltimaTransferencia;
    }

    public void setAnioUltimaTransferencia(Integer anioUltimaTransferencia) {
        this.anioUltimaTransferencia = anioUltimaTransferencia;
    }

    public Integer getAnioAntecedenteSolicitado() {
        return anioAntecedenteSolicitado;
    }

    public void setAnioAntecedenteSolicitado(Integer anioAntecedenteSolicitado) {
        this.anioAntecedenteSolicitado = anioAntecedenteSolicitado;
    }

    public PubSolicitud(String propApellidos, String propNombres, String propCedula,
                        Integer tipoSolicitud, Integer motivoSolicitud, String otroMotivo, Long numeroTramite,
                        Date fechaIngreso,
                        Date fechaEntrega) {
        this.propApellidos = propApellidos;
        this.propNombres = propNombres;
        this.propCedula = propCedula;
        this.tipoSolicitud = tipoSolicitud;
        this.motivoSolicitud = motivoSolicitud;
        this.otroMotivo = otroMotivo;
        this.numeroTramite = numeroTramite;
        this.fechaIngreso = fechaIngreso;
        this.fechaEntrega = fechaEntrega;
        //this.avance = this.calculo();
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Long getFechaSolicitudLong() {
        return fechaSolicitudLong;
    }

    public void setFechaSolicitudLong(Long fechaSolicitudLong) {
        this.fechaSolicitudLong = fechaSolicitudLong;
    }

    public Long getFechaInscripcionLong() {
        return fechaInscripcionLong;
    }

    public void setFechaInscripcionLong(Long fechaInscripcionLong) {
        this.fechaInscripcionLong = fechaInscripcionLong;
    }

    public PubSolicitud() {
    }

    public PubSolicitud(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSolTipoPersona() {
        return solTipoPersona;
    }

    public void setSolTipoPersona(String solTipoPersona) {
        this.solTipoPersona = solTipoPersona;
    }

    public String getSolTipoDoc() {
        return solTipoDoc;
    }

    public void setSolTipoDoc(String solTipoDoc) {
        this.solTipoDoc = solTipoDoc;
    }

    public String getSolApellidos() {
        return solApellidos;
    }

    public void setSolApellidos(String solApellidos) {
        this.solApellidos = solApellidos;
    }

    public String getSolNombres() {
        return solNombres;
    }

    public void setSolNombres(String solNombres) {
        this.solNombres = solNombres;
    }

    public String getSolCedula() {
        return solCedula;
    }

    public void setSolCedula(String solCedula) {
        this.solCedula = solCedula;
    }

    public String getSolProvincia() {
        return solProvincia;
    }

    public void setSolProvincia(String solProvincia) {
        this.solProvincia = solProvincia;
    }

    public String getSolCiudad() {
        return solCiudad;
    }

    public void setSolCiudad(String solCiudad) {
        this.solCiudad = solCiudad;
    }

    public String getSolParroquia() {
        return solParroquia;
    }

    public void setSolParroquia(String solParroquia) {
        this.solParroquia = solParroquia;
    }

    public String getSolCalles() {
        return solCalles;
    }

    public void setSolCalles(String solCalles) {
        this.solCalles = solCalles;
    }

    public String getSolNumeroCasa() {
        return solNumeroCasa;
    }

    public void setSolNumeroCasa(String solNumeroCasa) {
        this.solNumeroCasa = solNumeroCasa;
    }

    public String getSolCelular() {
        return solCelular;
    }

    public void setSolCelular(String solCelular) {
        this.solCelular = solCelular;
    }

    public String getSolConvencional() {
        return solConvencional;
    }

    public void setSolConvencional(String solConvencional) {
        this.solConvencional = solConvencional;
    }

    public String getSolCorreo() {
        return solCorreo;
    }

    public void setSolCorreo(String solCorreo) {
        this.solCorreo = solCorreo;
    }

    public Date getFechaSolicitud() {
        return fechaSolicitud;
    }

    public void setFechaSolicitud(Date fechaSolicitud) {
        this.fechaSolicitud = fechaSolicitud;
    }

    public Integer getTipoSolicitud() {
        return tipoSolicitud;
    }

    public void setTipoSolicitud(Integer tipoSolicitud) {
        this.tipoSolicitud = tipoSolicitud;
    }

    public Integer getMotivoSolicitud() {
        return motivoSolicitud;
    }

    public void setMotivoSolicitud(Integer motivoSolicitud) {
        this.motivoSolicitud = motivoSolicitud;
    }

    public String getOtroMotivo() {
        return otroMotivo;
    }

    public void setOtroMotivo(String otroMotivo) {
        this.otroMotivo = otroMotivo;
    }

    public Integer getNumeroFicha() {
        return numeroFicha;
    }

    public void setNumeroFicha(Integer numeroFicha) {
        this.numeroFicha = numeroFicha;
    }

    public String getClaveCatastral() {
        return claveCatastral;
    }

    public void setClaveCatastral(String claveCatastral) {
        this.claveCatastral = claveCatastral;
    }

    public String getTipoInmueble() {
        return tipoInmueble;
    }

    public void setTipoInmueble(String tipoInmueble) {
        this.tipoInmueble = tipoInmueble;
    }

    public String getPropEstadoCivil() {
        return propEstadoCivil;
    }

    public void setPropEstadoCivil(String propEstadoCivil) {
        this.propEstadoCivil = propEstadoCivil;
    }

    public String getPropTipoPersona() {
        return propTipoPersona;
    }

    public void setPropTipoPersona(String propTipoPersona) {
        this.propTipoPersona = propTipoPersona;
    }

    public String getPropTipoDoc() {
        return propTipoDoc;
    }

    public void setPropTipoDoc(String propTipoDoc) {
        this.propTipoDoc = propTipoDoc;
    }

    public String getPropCedula() {
        return propCedula;
    }

    public void setPropCedula(String propCedula) {
        this.propCedula = propCedula;
    }

    public String getPropNombres() {
        return propNombres;
    }

    public void setPropNombres(String propNombres) {
        this.propNombres = propNombres;
    }

    public String getPropApellidos() {
        return propApellidos;
    }

    public void setPropApellidos(String propApellidos) {
        this.propApellidos = propApellidos;
    }

    public String getPropConyugueCedula() {
        return propConyugueCedula;
    }

    public void setPropConyugueCedula(String propConyugueCedula) {
        this.propConyugueCedula = propConyugueCedula;
    }

    public String getPropConyugueNombres() {
        return propConyugueNombres;
    }

    public void setPropConyugueNombres(String propConyugueNombres) {
        this.propConyugueNombres = propConyugueNombres;
    }

    public String getPropConyugueApellidos() {
        return propConyugueApellidos;
    }

    public void setPropConyugueApellidos(String propConyugueApellidos) {
        this.propConyugueApellidos = propConyugueApellidos;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public String getBenTipoPersona() {
        return benTipoPersona;
    }

    public void setBenTipoPersona(String benTipoPersona) {
        this.benTipoPersona = benTipoPersona;
    }

    public String getBenTipoDoc() {
        return benTipoDoc;
    }

    public void setBenTipoDoc(String benTipoDoc) {
        this.benTipoDoc = benTipoDoc;
    }

    public String getBenDocumento() {
        return benDocumento;
    }

    public void setBenDocumento(String benDocumento) {
        this.benDocumento = benDocumento;
    }

    public String getBenNombres() {
        return benNombres;
    }

    public void setBenNombres(String benNombres) {
        this.benNombres = benNombres;
    }

    public String getBenApellidos() {
        return benApellidos;
    }

    public void setBenApellidos(String benApellidos) {
        this.benApellidos = benApellidos;
    }

    public String getBenDireccion() {
        return benDireccion;
    }

    public void setBenDireccion(String benDireccion) {
        this.benDireccion = benDireccion;
    }

    public String getBenTelefono() {
        return benTelefono;
    }

    public void setBenTelefono(String benTelefono) {
        this.benTelefono = benTelefono;
    }

    public String getBenCorreo() {
        return benCorreo;
    }

    public void setBenCorreo(String benCorreo) {
        this.benCorreo = benCorreo;
    }

    public Short getInstallmentsType() {
        return installmentsType;
    }

    public void setInstallmentsType(Short installmentsType) {
        this.installmentsType = installmentsType;
    }

    public String getPayframeUrl() {
        return payframeUrl;
    }

    public void setPayframeUrl(String payframeUrl) {
        this.payframeUrl = payframeUrl;
    }

    public Date getFechaEntrega() {
        return fechaEntrega;
    }

    public void setFechaEntrega(Date fechaEntrega) {
        this.fechaEntrega = fechaEntrega;
    }

    public Date getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(Date fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public Date getFechaInscripcion() {
        return fechaInscripcion;
    }

    public void setFechaInscripcion(Date fechaInscripcion) {
        this.fechaInscripcion = fechaInscripcion;
    }

    public Long getNumeroTramite() {
        return numeroTramite;
    }

    public void setNumeroTramite(Long numeroTramite) {
        this.numeroTramite = numeroTramite;
    }

    public Long getOidDocument() {
        return oidDocument;
    }

    public Boolean getSendEmail() {
        return sendEmail;
    }

    public void setSendEmail(Boolean sendEmail) {
        this.sendEmail = sendEmail;
    }

    public void setOidDocument(Long oidDocument) {
        this.oidDocument = oidDocument;
    }

    public Long getOidDocument2() {
        return oidDocument2;
    }

    public void setOidDocument2(Long oidDocument2) {
        this.oidDocument2 = oidDocument2;
    }

    public Long getOidDocument3() {
        return oidDocument3;
    }

    public void setOidDocument3(Long oidDocument3) {
        this.oidDocument3 = oidDocument3;
    }

    public String getImage1() {
        return image1;
    }

    public void setImage1(String image1) {
        this.image1 = image1;
    }

    public String getImage2() {
        return image2;
    }

    public void setImage2(String image2) {
        this.image2 = image2;
    }

    public String getImage3() {
        return image3;
    }

    public void setImage3(String image3) {
        this.image3 = image3;
    }

    public String getLote() {
        return lote;
    }

    public void setLote(String lote) {
        this.lote = lote;
    }

    public Integer getNumInscripcion() {
        return numInscripcion;
    }

    public void setNumInscripcion(Integer numInscripcion) {
        this.numInscripcion = numInscripcion;
    }

    public AclUser getUser() {
        return user;
    }

    public void setUser(AclUser user) {
        this.user = user;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PubSolicitud)) {
            return false;
        }
        PubSolicitud other = (PubSolicitud) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    public String getSolEstadoCivil() {
        return solEstadoCivil;
    }

    public void setSolEstadoCivil(String solEstadoCivil) {
        this.solEstadoCivil = solEstadoCivil;
    }

    public Integer getAnioInscripcion() {
        return anioInscripcion;
    }

    public void setAnioInscripcion(Integer anioInscripcion) {
        this.anioInscripcion = anioInscripcion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Boolean getTipoPago() {
        return tipoPago;
    }

    public void setTipoPago(Boolean tipoPago) {
        this.tipoPago = tipoPago;
    }

    public Integer getCantidad() {
        return cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }

    public Integer getAnioUltimaTransferencia() {
        return anioUltimaTransferencia;
    }

    public Boolean getIngresado() {
        return ingresado;
    }

    public void setIngresado(Boolean ingresado) {
        this.ingresado = ingresado;
    }

    public String getActo() {
        return acto;
    }

    public void setActo(String acto) {
        this.acto = acto;
    }

    public Double getAvance() {
        return avance;
    }

    public void setAvance(Double avance) {
        this.avance = avance;
    }

    @Override
    public String toString() {
        return "PubSolicitud{"
                + "id=" + id
                + ", solTipoPersona='" + solTipoPersona + '\''
                + ", solTipoDoc='" + solTipoDoc + '\''
                + ", solApellidos='" + solApellidos + '\''
                + ", solNombres='" + solNombres + '\''
                + ", solCedula='" + solCedula + '\''
                + ", solProvincia='" + solProvincia + '\''
                + ", solCiudad='" + solCiudad + '\''
                + ", solParroquia='" + solParroquia + '\''
                + ", solCalles='" + solCalles + '\''
                + ", solNumeroCasa='" + solNumeroCasa + '\''
                + ", solCelular='" + solCelular + '\''
                + ", solConvencional='" + solConvencional + '\''
                + ", solCorreo='" + solCorreo + '\''
                + ", solEstadoCivil='" + solEstadoCivil + '\''
                + ", fechaSolicitud=" + fechaSolicitud
                + ", tipoSolicitud=" + tipoSolicitud
                + ", motivoSolicitud=" + motivoSolicitud
                + ", otroMotivo='" + otroMotivo + '\''
                + ", numeroFicha=" + numeroFicha
                + ", claveCatastral='" + claveCatastral + '\''
                + ", tipoInmueble='" + tipoInmueble + '\''
                + ", propEstadoCivil='" + propEstadoCivil + '\''
                + ", propTipoPersona='" + propTipoPersona + '\''
                + ", propTipoDoc='" + propTipoDoc + '\''
                + ", propCedula='" + propCedula + '\''
                + ", propNombres='" + propNombres + '\''
                + ", propApellidos='" + propApellidos + '\''
                + ", propConyugueCedula='" + propConyugueCedula + '\''
                + ", propConyugueNombres='" + propConyugueNombres + '\''
                + ", propConyugueApellidos='" + propConyugueApellidos + '\''
                + ", observacion='" + observacion + '\''
                + ", benTipoPersona='" + benTipoPersona + '\''
                + ", benTipoDoc='" + benTipoDoc + '\''
                + ", benDocumento='" + benDocumento + '\''
                + ", benNombres='" + benNombres + '\''
                + ", benApellidos='" + benApellidos + '\''
                + ", benDireccion='" + benDireccion + '\''
                + ", benTelefono='" + benTelefono + '\''
                + ", benCorreo='" + benCorreo + '\''
                + ", installmentsType=" + installmentsType
                + ", payframeUrl='" + payframeUrl + '\''
                + ", fechaEntrega=" + fechaEntrega
                + ", fechaIngreso=" + fechaIngreso
                + ", fechaInscripcion=" + fechaInscripcion
                + ", numeroTramite=" + numeroTramite
                + ", sendEmail=" + sendEmail
                + ", oidDocument=" + oidDocument
                + ", oidDocument2=" + oidDocument2
                + ", oidDocument3=" + oidDocument3
                + ", image1='" + image1 + '\''
                + ", image2='" + image2 + '\''
                + ", image3='" + image3 + '\''
                + ", lote='" + lote + '\''
                + ", numInscripcion=" + numInscripcion
                + ", user=" + user
                + ", fechaSolicitudLong=" + fechaSolicitudLong
                + ", fechaInscripcionLong=" + fechaInscripcionLong
                + ", total=" + total
                + ", anioInscripcion=" + anioInscripcion
                + ", estado='" + estado + '\''
                + ", tipoPago=" + tipoPago
                + ", cantidad=" + cantidad
                + ", anioUltimaTransferencia=" + anioUltimaTransferencia
                + ", anioAntecedenteSolicitado=" + anioAntecedenteSolicitado
                + ", ingresado=" + ingresado
                + ", acto='" + acto + '\''
                + ", avance=" + avance
                + '}';
    }

    public String getTipoFormulario() {
        return tipoFormulario;
    }

    public void setTipoFormulario(String tipoFormulario) {
        this.tipoFormulario = tipoFormulario;
    }

    public List<ActoRequisito> getRequisitos() {
        return requisitos;
    }

    public void setRequisitos(List<ActoRequisito> requisitos) {
        this.requisitos = requisitos;
    }

    public Boolean getTieneNotificacion() {
        return tieneNotificacion;
    }

    public void setTieneNotificacion(Boolean tieneNotificacion) {
        this.tieneNotificacion = tieneNotificacion;
    }

    public String getNotificacion() {
        return notificacion;
    }

    public void setNotificacion(String notificacion) {
        this.notificacion = notificacion;
    }

    public String getLinkPago() {
        return linkPago;
    }

    public void setLinkPago(String linkPago) {
        this.linkPago = linkPago;
    }

    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

    public String getPayWithPayPhone() {
        return payWithPayPhone;
    }

    public void setPayWithPayPhone(String payWithPayPhone) {
        this.payWithPayPhone = payWithPayPhone;
    }

    public Boolean getProcesando() {
        return procesando;
    }

    public void setProcesando(Boolean procesando) {
        this.procesando = procesando;
    }

    public Long getNumeroTramiteInscripcion() {
        return numeroTramiteInscripcion;
    }

    public void setNumeroTramiteInscripcion(Long numeroTramiteInscripcion) {
        this.numeroTramiteInscripcion = numeroTramiteInscripcion;
    }

}
