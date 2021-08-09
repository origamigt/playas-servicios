package ec.gob.ventanilla.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;
import java.util.List;

public class DatosProforma implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long numerotramite;
    private Integer repertorio;
    private String doc_solicitante;
    private String nombre_solicitante;
    private String correo_solicitante;
    private String doc_beneficiario;
    private String nombre_beneficiario;
    private String correo_beneficiario;
    private String revisor;
    private String numerofactura;
    private String claveacceso;
    private String numeroautorizacion;
    private String estadotramite;
    private String mensaje;
    private Long fechaingreso;
    private Long fechaentrega;
    private BigDecimal subtotal;
    private BigDecimal descuento;
    private BigDecimal dscto_limitcobro;
    private BigDecimal descuento_porc;
    private BigDecimal gastos_generales;
    private BigDecimal totalPagar;
    private List<ec.gob.ventanilla.model.DatosDetalleProforma> detalle;
    private BigDecimal avance;
    private String detalleAvance;
    private String detalleSolicitud;
    private String acto;
    private String tareaActual;
    private String fichas;
    private Boolean procedePago;

    public String getActo() {
        if (detalle != null) {
            if (!detalle.isEmpty()) {
                acto = "";
                for (ec.gob.ventanilla.model.DatosDetalleProforma ddp : detalle) {
                    acto = ddp.getActo() + "\n" + acto;
                }
                return acto;
            }
        }
        return "";
    }

    public void setActo(String acto) {
        this.acto = acto;
    }

    public String getDetalleSolicitud() {
        return detalleSolicitud;
    }

    public BigDecimal getAvance() {
        avance = calculo();
        return avance;
    }

    public void setDetalleSolicitud(String detalleSolicitud) {
        this.detalleSolicitud = detalleSolicitud;
    }

    public String getDetalleAvance() {
        BigDecimal result = getAvance().multiply(new BigDecimal("100")).setScale(2, RoundingMode.HALF_UP);
        detalleAvance = result.toString();
        return detalleAvance;
    }

    public void setDetalleAvance(String detalleAvance) {
        this.detalleAvance = detalleAvance;
    }

    public void setAvance(BigDecimal avance) {
        this.avance = avance;
    }

    public BigDecimal calculo() {
        if (fechaentrega != null) {
            if (new Date().after(new Date(fechaentrega))) {
                return new BigDecimal("1.00");
            } else {
                BigDecimal hoy = BigDecimal.valueOf(new Date().getTime() - fechaingreso);
                BigDecimal resta = BigDecimal.valueOf(fechaentrega - fechaingreso);
                return hoy.divide(resta, 2, RoundingMode.HALF_UP);
            }
        }
        return new BigDecimal("0.1");
    }

    public DatosProforma() {
    }

    public Date getFechaIngresoToDate() {
        if (fechaingreso != null) {
            return new Date(fechaingreso);
        } else {
            return null;
        }
    }

    public Date getFechaEntregaToDate() {
        if (fechaentrega != null) {
            return new Date(fechaentrega);
        } else {
            return null;
        }
    }

    public Long getNumerotramite() {
        return numerotramite;
    }

    public void setNumerotramite(Long numerotramite) {
        this.numerotramite = numerotramite;
    }

    public Integer getRepertorio() {
        return repertorio;
    }

    public void setRepertorio(Integer repertorio) {
        this.repertorio = repertorio;
    }

    public String getDoc_solicitante() {
        return doc_solicitante;
    }

    public void setDoc_solicitante(String doc_solicitante) {
        this.doc_solicitante = doc_solicitante;
    }

    public String getNombre_solicitante() {
        return nombre_solicitante;
    }

    public void setNombre_solicitante(String nombre_solicitante) {
        this.nombre_solicitante = nombre_solicitante;
    }

    public String getCorreo_solicitante() {
        return correo_solicitante;
    }

    public void setCorreo_solicitante(String correo_solicitante) {
        this.correo_solicitante = correo_solicitante;
    }

    public String getDoc_beneficiario() {
        return doc_beneficiario;
    }

    public void setDoc_beneficiario(String doc_beneficiario) {
        this.doc_beneficiario = doc_beneficiario;
    }

    public String getNombre_beneficiario() {
        return nombre_beneficiario;
    }

    public void setNombre_beneficiario(String nombre_beneficiario) {
        this.nombre_beneficiario = nombre_beneficiario;
    }

    public String getCorreo_beneficiario() {
        return correo_beneficiario;
    }

    public void setCorreo_beneficiario(String correo_beneficiario) {
        this.correo_beneficiario = correo_beneficiario;
    }

    public String getRevisor() {
        return revisor;
    }

    public void setRevisor(String revisor) {
        this.revisor = revisor;
    }

    public String getNumerofactura() {
        return numerofactura;
    }

    public void setNumerofactura(String numerofactura) {
        this.numerofactura = numerofactura;
    }

    public String getClaveacceso() {
        return claveacceso;
    }

    public void setClaveacceso(String claveacceso) {
        this.claveacceso = claveacceso;
    }

    public String getNumeroautorizacion() {
        return numeroautorizacion;
    }

    public void setNumeroautorizacion(String numeroautorizacion) {
        this.numeroautorizacion = numeroautorizacion;
    }

    public String getEstadotramite() {
        return estadotramite;
    }

    public void setEstadotramite(String estadotramite) {
        this.estadotramite = estadotramite;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public Long getFechaingreso() {
        return fechaingreso;
    }

    public void setFechaingreso(Long fechaingreso) {
        this.fechaingreso = fechaingreso;
    }

    public Long getFechaentrega() {
        return fechaentrega;
    }

    public void setFechaentrega(Long fechaentrega) {
        this.fechaentrega = fechaentrega;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public BigDecimal getDescuento() {
        return descuento;
    }

    public void setDescuento(BigDecimal descuento) {
        this.descuento = descuento;
    }

    public BigDecimal getDscto_limitcobro() {
        return dscto_limitcobro;
    }

    public void setDscto_limitcobro(BigDecimal dscto_limitcobro) {
        this.dscto_limitcobro = dscto_limitcobro;
    }

    public BigDecimal getDescuento_porc() {
        return descuento_porc;
    }

    public void setDescuento_porc(BigDecimal descuento_porc) {
        this.descuento_porc = descuento_porc;
    }

    public BigDecimal getGastos_generales() {
        return gastos_generales;
    }

    public void setGastos_generales(BigDecimal gastos_generales) {
        this.gastos_generales = gastos_generales;
    }

    public BigDecimal getTotalPagar() {
        return totalPagar;
    }

    public void setTotalPagar(BigDecimal totalPagar) {
        this.totalPagar = totalPagar;
    }

    public List<DatosDetalleProforma> getDetalle() {
        return detalle;
    }

    public void setDetalle(List<DatosDetalleProforma> detalle) {
        this.detalle = detalle;
    }

    public String getTareaActual() {
        return tareaActual;
    }

    public void setTareaActual(String tareaActual) {
        this.tareaActual = tareaActual;
    }

    @Override
    public String toString() {
        return "DatosProforma [numerotramite=" + numerotramite + ", repertorio=" + repertorio + ", doc_solicitante="
                + doc_solicitante + ", nombre_solicitante=" + nombre_solicitante + ", correo_solicitante="
                + correo_solicitante + ", doc_beneficiario=" + doc_beneficiario + ", nombre_beneficiario="
                + nombre_beneficiario + ", correo_beneficiario=" + correo_beneficiario + ", revisor=" + revisor
                + ", numerofactura=" + numerofactura + ", claveacceso=" + claveacceso + ", numeroautorizacion="
                + numeroautorizacion + ", estadotramite=" + estadotramite + ", mensaje=" + mensaje + ", fechaingreso="
                + fechaingreso + ", fechaentrega=" + fechaentrega + ", subtotal=" + subtotal + ", descuento="
                + descuento + ", dscto_limitcobro=" + dscto_limitcobro + ", descuento_porc=" + descuento_porc
                + ", gastos_generales=" + gastos_generales + ", totalPagar=" + totalPagar + ", detalle=" + detalle
                + "]";
    }

    public String getFichas() {
        return fichas;
    }

    public void setFichas(String fichas) {
        this.fichas = fichas;
    }

    public Boolean getProcedePago() {
        return procedePago;
    }

    public void setProcedePago(Boolean procedePago) {
        this.procedePago = procedePago;
    }

}
