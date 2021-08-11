package com.facturacion.entites.comprobanterespuestasri;

import com.facturacion.sri.model.ws.RespuestaSolicitudSRI;
import com.facturacion.modelcomprobante.ImpuestoComprobanteElectronico;
import com.facturacion.modelcomprobante.MotivoNotaDebito;
import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
@Table(name = "comprobante_sri")
public class ComprobanteSRI implements Serializable {

    
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Column(name = "id_orden_pago")
    private Long idOrdenPago;
    @Column
    private Long tramite;
    @Column
    private String response;
    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date fecha;
    
    @Transient
    private ComprobanteEntidadSRI entidad;
    @Transient
    private ComprobanteEntidadSRI contribuyente;
    @Transient
    private String tipoComprobante;
    @Transient
    private String codigoTipoComprobante;
    @Transient
    private String numFactura;
    @Transient
    private String numFacturaFormato;
    @Transient
    private BigInteger numComprobante;
    @Transient
    private String numAutorizacion;
    @Transient
    private String fechaAutorizacion;
    @Transient
    private String ambiente;
    @Transient
    private String emision;
    @Transient
    private String claveAcceso;
    @Transient
    private String fechaEmision;
    @Transient
    private BigDecimal subTotal12;
    @Transient
    private BigDecimal subTotalIva;
    @Transient
    private BigDecimal subTotalNoObjetoIva;
    @Transient
    private BigDecimal subTotalExcentoIva;
    @Transient
    private BigDecimal subTotalSinImpuetos;
    @Transient
    private BigDecimal descuento;
    @Transient
    private BigDecimal ice;
    @Transient
    private BigDecimal iva;
    @Transient
    private BigDecimal irbpnr;
    @Transient
    private BigDecimal propina;
    @Transient
    private BigDecimal valorTotal;
    @Transient
    private BigDecimal valorSinSubSidio;
    @Transient
    private BigDecimal ahorroPorSubSidio;
    @Transient
    private BigDecimal descuentoAdicional;
    @Transient
    private List<RespuestaSolicitudSRI> respuestaSolicitudSRI;
    @Transient
    private List<RespuestaSolicitudSRI> respuestaAutorizacionSRI;
    @Transient
    private List<ComprobanteDetalleSRI> detalleFactura;
    @Transient
    private List<ComprobantePagoSRI> pagoDetalle;

    //NOTA DEBTO - NOTA CREDITO
    @Transient
    private String numComprobanteModifica;
    @Transient
    private String motivoNotaCredito;
    @Transient
    private String fechaEmisionDocumentoModifica;
    @Transient
    private String tipoDocumentoModifica;
    @Transient
    private String descripcionComprobanteModifica;

    ///NOTA DEBITO
    @Transient
    private List<MotivoNotaDebito> motivosNotaDebito;

    ///PARA COMPROBANTE DE RETENCION
    @Transient
    private String periodo;
    @Transient
    private List<ImpuestoComprobanteElectronico> impuestoComprobanteRetencion;

    //XML
    @Transient
    private String xmlPath;

    //PDF
    @Transient
    private String pdfPath;

    public ComprobanteSRI() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdOrdenPago() {
        return idOrdenPago;
    }

    public void setIdOrdenPago(Long idOrdenPago) {
        this.idOrdenPago = idOrdenPago;
    }

    public String getResponse() {
        return response;
    }

    public void setResponse(String response) {
        this.response = response;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getClaveAcceso() {
        return claveAcceso;
    }

    public void setClaveAcceso(String claveAcceso) {
        this.claveAcceso = claveAcceso;
    }

    public String getNumFactura() {
        return numFactura;
    }

    public void setNumFactura(String numFactura) {
        this.numFactura = numFactura;
    }

    public String getFechaAutorizacion() {
        return fechaAutorizacion;
    }

    public void setFechaAutorizacion(String fechaAutorizacion) {
        this.fechaAutorizacion = fechaAutorizacion;
    }

    public String getNumAutorizacion() {
        return numAutorizacion;
    }

    public void setNumAutorizacion(String numAutorizacion) {
        this.numAutorizacion = numAutorizacion;
    }

    public List<RespuestaSolicitudSRI> getRespuestaSolicitudSRI() {
        return respuestaSolicitudSRI;
    }

    public void setRespuestaSolicitudSRI(List<RespuestaSolicitudSRI> respuestaSolicitudSRI) {
        this.respuestaSolicitudSRI = respuestaSolicitudSRI;
    }

    public List<RespuestaSolicitudSRI> getRespuestaAutorizacionSRI() {
        return respuestaAutorizacionSRI;
    }

    public void setRespuestaAutorizacionSRI(List<RespuestaSolicitudSRI> respuestaAutorizacionSRI) {
        this.respuestaAutorizacionSRI = respuestaAutorizacionSRI;
    }

    public String getNumFacturaFormato() {
        return numFacturaFormato;
    }

    public void setNumFacturaFormato(String numFacturaFormato) {
        this.numFacturaFormato = numFacturaFormato;
    }

    public String getTipoComprobante() {
        return tipoComprobante;
    }

    public void setTipoComprobante(String tipoComprobante) {
        this.tipoComprobante = tipoComprobante;
    }

    public String getCodigoTipoComprobante() {
        return codigoTipoComprobante;
    }

    public void setCodigoTipoComprobante(String codigoTipoComprobante) {
        this.codigoTipoComprobante = codigoTipoComprobante;
    }

    public ComprobanteEntidadSRI getEntidad() {
        if (entidad == null) {
            entidad = new ComprobanteEntidadSRI();
        }
        return entidad;
    }

    public void setEntidad(ComprobanteEntidadSRI entidad) {
        this.entidad = entidad;
    }

    public ComprobanteEntidadSRI getContribuyente() {
        if (contribuyente == null) {
            contribuyente = new ComprobanteEntidadSRI();
        }
        return contribuyente;
    }

    public void setContribuyente(ComprobanteEntidadSRI contribuyente) {
        this.contribuyente = contribuyente;
    }

    public String getFechaEmision() {
        return fechaEmision;
    }

    public void setFechaEmision(String fechaEmision) {
        this.fechaEmision = fechaEmision;
    }

    public String getAmbiente() {
        return ambiente;
    }

    public void setAmbiente(String ambiente) {
        this.ambiente = ambiente;
    }

    public String getEmision() {
        return emision;
    }

    public void setEmision(String emision) {
        this.emision = emision;
    }

    public BigDecimal getSubTotal12() {
        return subTotal12;
    }

    public void setSubTotal12(BigDecimal subTotal12) {
        this.subTotal12 = subTotal12.setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getSubTotalIva() {
        return subTotalIva;
    }

    public void setSubTotalIva(BigDecimal subTotalIva) {
        this.subTotalIva = subTotalIva.setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getSubTotalNoObjetoIva() {
        return subTotalNoObjetoIva;
    }

    public void setSubTotalNoObjetoIva(BigDecimal subTotalNoObjetoIva) {
        this.subTotalNoObjetoIva = subTotalNoObjetoIva.setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getSubTotalExcentoIva() {
        return subTotalExcentoIva;
    }

    public void setSubTotalExcentoIva(BigDecimal subTotalExcentoIva) {
        this.subTotalExcentoIva = subTotalExcentoIva.setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getSubTotalSinImpuetos() {
        return subTotalSinImpuetos;
    }

    public void setSubTotalSinImpuetos(BigDecimal subTotalSinImpuetos) {
        this.subTotalSinImpuetos = subTotalSinImpuetos.setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getDescuento() {
        return descuento;
    }

    public void setDescuento(BigDecimal descuento) {
        this.descuento = descuento.setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getIce() {
        return ice;
    }

    public void setIce(BigDecimal ice) {
        this.ice = ice.setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getIva() {
        return iva;
    }

    public void setIva(BigDecimal iva) {
        this.iva = iva.setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getIrbpnr() {
        return irbpnr;
    }

    public void setIrbpnr(BigDecimal irbpnr) {
        this.irbpnr = irbpnr.setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getPropina() {
        return propina;
    }

    public void setPropina(BigDecimal propina) {
        this.propina = propina.setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(BigDecimal valorTotal) {
        this.valorTotal = valorTotal.setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getValorSinSubSidio() {
        return valorSinSubSidio;
    }

    public void setValorSinSubSidio(BigDecimal valorSinSubSidio) {
        this.valorSinSubSidio = valorSinSubSidio.setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal getAhorroPorSubSidio() {
        return ahorroPorSubSidio;
    }

    public void setAhorroPorSubSidio(BigDecimal ahorroPorSubSidio) {
        this.ahorroPorSubSidio = ahorroPorSubSidio.setScale(2, RoundingMode.HALF_UP);
    }

    public List<ComprobanteDetalleSRI> getDetalleFactura() {
        if (detalleFactura == null) {
            detalleFactura = new ArrayList<>();
        }
        return detalleFactura;
    }

    public void setDetalleFactura(List<ComprobanteDetalleSRI> detalleFactura) {
        this.detalleFactura = detalleFactura;
    }

    public List<ComprobantePagoSRI> getPagoDetalle() {
        if (pagoDetalle == null) {
            pagoDetalle = new ArrayList<>();
        }
        return pagoDetalle;
    }

    public void setPagoDetalle(List<ComprobantePagoSRI> pagoDetalle) {
        this.pagoDetalle = pagoDetalle;
    }

    public String getNumComprobanteModifica() {
        return numComprobanteModifica;
    }

    public void setNumComprobanteModifica(String numComprobanteModifica) {
        this.numComprobanteModifica = numComprobanteModifica;
    }

    public String getMotivoNotaCredito() {
        return motivoNotaCredito;
    }

    public void setMotivoNotaCredito(String motivoNotaCredito) {
        this.motivoNotaCredito = motivoNotaCredito;
    }

    public String getTipoDocumentoModifica() {
        return tipoDocumentoModifica;
    }

    public void setTipoDocumentoModifica(String tipoDocumentoModifica) {
        this.tipoDocumentoModifica = tipoDocumentoModifica;
    }

    public String getFechaEmisionDocumentoModifica() {
        return fechaEmisionDocumentoModifica;
    }

    public void setFechaEmisionDocumentoModifica(String fechaEmisionDocumentoModifica) {
        this.fechaEmisionDocumentoModifica = fechaEmisionDocumentoModifica;
    }

    public String getDescripcionComprobanteModifica() {
        return descripcionComprobanteModifica;
    }

    public void setDescripcionComprobanteModifica(String descripcionComprobanteModifica) {
        this.descripcionComprobanteModifica = descripcionComprobanteModifica;
    }

    public List<MotivoNotaDebito> getMotivosNotaDebito() {
        return motivosNotaDebito;
    }

    public void setMotivosNotaDebito(List<MotivoNotaDebito> motivosNotaDebito) {
        this.motivosNotaDebito = motivosNotaDebito;
    }

    public List<ImpuestoComprobanteElectronico> getImpuestoComprobanteRetencion() {
        if (impuestoComprobanteRetencion == null) {
            impuestoComprobanteRetencion = new ArrayList<>();
        }
        return impuestoComprobanteRetencion;
    }

    public void setImpuestoComprobanteRetencion(List<ImpuestoComprobanteElectronico> impuestoComprobanteRetencion) {
        this.impuestoComprobanteRetencion = impuestoComprobanteRetencion;
    }

    public String getPeriodo() {
        return periodo;
    }

    public void setPeriodo(String periodo) {
        this.periodo = periodo;
    }

    public String getXmlPath() {
        return xmlPath;
    }

    public void setXmlPath(String xmlPath) {
        this.xmlPath = xmlPath;
    }

    public String getPdfPath() {
        return pdfPath;
    }

    public void setPdfPath(String pdfPath) {
        this.pdfPath = pdfPath;
    }

    public BigDecimal getDescuentoAdicional() {
        if (descuentoAdicional == null) {
            descuentoAdicional = BigDecimal.ZERO;
        }
        return descuentoAdicional;
    }

    public void setDescuentoAdicional(BigDecimal descuentoAdicional) {
        this.descuentoAdicional = descuentoAdicional;
    }

	public BigInteger getNumComprobante() {
		return numComprobante;
	}

	public void setNumComprobante(BigInteger numComprobante) {
		this.numComprobante = numComprobante;
	}

    public Long getTramite() {
        return tramite;
    }

    public void setTramite(Long tramite) {
        this.tramite = tramite;
    }
    
    public ComprobanteSRI(String aux) {
        RespuestaSolicitudSRI respuesta = new RespuestaSolicitudSRI();
        respuesta.setEstado(aux);
        respuesta.setIdentificador("-1");
        respuesta.setInformacionAdicional("NO HAY RESPUESTA POR PARTE DEL SRI");
        respuesta.setMensaje("NO SE PUDO PROCESAR LA FACTURA");
        respuesta.setTipo(aux);
        List<RespuestaSolicitudSRI> result = new ArrayList<>();
        result.add(respuesta);
        this.respuestaSolicitudSRI = result;
    }

    public List<RespuestaSolicitudSRI> getAviso(String aux) {
        RespuestaSolicitudSRI respuesta = new RespuestaSolicitudSRI();
        respuesta.setEstado(aux);
        respuesta.setIdentificador("3");
        respuesta.setMensaje("LOS DATOS DE LA FACTURA A ENVIAR YA SE ENCUENTRA REGISTRADO EN EL SISTEMA");
        List<RespuestaSolicitudSRI> result = new ArrayList<>();
        result.add(respuesta);
        return result;
    }
}
