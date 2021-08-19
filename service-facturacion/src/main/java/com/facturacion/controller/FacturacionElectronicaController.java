package com.facturacion.controller;

import com.facturacion.repository.*;
import com.facturacion.entites.FirmaDocElectronico;
import com.facturacion.entites.Porcentajes;
import com.facturacion.RestAPI;
import com.facturacion.async.EmailService;
import com.facturacion.entites.Ambiente;
import com.facturacion.entites.Cajero;
import com.facturacion.entites.ClaveAcceso;
import com.facturacion.entites.Comprobante;
import com.facturacion.entites.DocElectronico;
import com.facturacion.entites.Entidad;
import com.facturacion.entites.Firma;
import com.facturacion.entites.MsgFormatoNotificacion;
import com.facturacion.entites.RespuestaSolicitud;
import com.facturacion.entites.comprobanterespuestasri.ComprobanteDetalleSRI;
import com.facturacion.entites.comprobanterespuestasri.ComprobantePagoSRI;
import com.facturacion.entites.comprobanterespuestasri.ComprobanteSRI;
import com.facturacion.jdbc.Conexion;
import com.facturacion.modelcomprobante.ComprobanteElectronico;
import com.facturacion.modelcomprobante.Detalle;
import com.facturacion.modelcomprobante.DetallePago;
import com.facturacion.modelcomprobante.ImpuestoComprobanteElectronico;
import com.facturacion.sri.logic.Calculos;
import com.facturacion.sri.logic.ComprobantesCode;
import com.facturacion.sri.model.InfoTributaria;
import com.facturacion.entites.RespuestaComprobante;
import com.facturacion.entites.TipoEmision;
import com.facturacion.sri.model.factura.Factura;
import com.facturacion.sri.model.notacredito.NotaCredito;
import com.facturacion.sri.model.notacredito.TotalConImpuestos;
import com.facturacion.sri.model.notacredito.TotalConImpuestos.TotalImpuesto;
import com.facturacion.sri.model.notadebito.NotaDebito;
import com.facturacion.sri.model.retencion.ComprobanteRetencion;
import com.facturacion.sri.util.Constantes;
import com.facturacion.sri.util.DocumentosUtil;
import com.google.gson.Gson;
import java.io.*;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.util.*;
import javax.validation.Valid;
import javax.xml.datatype.XMLGregorianCalendar;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = RestAPI.facturacionElectronica)
@Service
public class FacturacionElectronicaController {

    //@Autowired
    //private FirmaDocElectronicoRepository firmaDocElectronicoRepository;
    @Autowired
    private TipoIdentificacionRepository tipoIdentificacionRepository;
    @Autowired
    private PorcentajeRepository porcentajeRepository;
    @Autowired
    private DirectoriosRepository directoriosRepository;
    @Autowired
    private ClaveAccesoRepository claveAccesoRepository;
    @Autowired
    private RespuestaSolicitudRepository respuestaSolicitudRepository;
    @Autowired
    private RespuestaComprobanteRepository respuestaComprobanteRepository;
    @Autowired
    private ComprobanteSRIRepository comprobanteSRIRepository;
    @Autowired
    private FormasPagoRepository formasPagoRepository;
    @Autowired
    private ImpuestosAsignadosRetencionRepository impuestosAsignadosRetencionRepository;
    @Autowired
    private MsgFormatoNotificacionRepository msgFormatoNotificacionRepository;
    @Autowired
    private EmailService emailService;
    @Autowired
    private EntidadRepository entidadRepository;
    @Autowired
    private AmbienteRepository ambienteRepository;
    @Autowired
    private ComprobanteRepository comprobanteRepository;
    @Autowired
    private CajeroRepository cajeroRepository;
    @Autowired
    private TipoEmisionRepository tipoEmisionRepository;

    private ComprobanteSRI comprobanteSRI = null;

    private String archivoACrear, claveAcceso, secuencial;

    private Boolean continuar = Boolean.TRUE;

    private Gson gson;

    /*@RequestMapping(value = RestAPI.facturacionElectronicaGET, method = RequestMethod.GET)
    public List<ComprobanteSRI> consultarComprobanteContribuyentes(@PathVariable String identificacion) {
        return comprobanteSRIRepository
                .findByContribuyente_IdemtificacionAndNumAutorizacionIsNotNullOrderByFechaAutorizacionDesc(
                        identificacion);
    }*/
    @Async
    @RequestMapping(value = RestAPI.enviarCorreoFacturacionElectronicaPOST, method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> enviarCorreoFacturaElectronicaSRI(@Valid @RequestBody ComprobanteSRI sri) {
        //emailService.sendMailContribuyente(msgFormatoNotificacionRepository.findTopByAsuntoIsNotNull(),
        emailService.sendMailContribuyente(msgFormatoNotificacionRepository.findByTipo(1L),
                sri.getXmlPath(), sri.getPdfPath(), sri.getContribuyente().getEmail());
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @RequestMapping(value = RestAPI.facturacionElectronicaPOST, method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @Async
    public ResponseEntity<?> enviarFacturaElectronicaSRI(
            @Valid @RequestBody ComprobanteElectronico comprobanteElectronico) {
        System.out.println("// prueba 1");
        FirmaDocElectronico firmaDocElectronico = validarComprobanteRest(comprobanteElectronico);
        if (firmaDocElectronico != null) {
            System.out.println("// prueba 3");
            Factura factura = createXML(firmaDocElectronico, comprobanteElectronico);
            if (factura != null) {
                System.out.println("// factura: " + factura);
                System.out.println("// directorio: " + directoriosRepository.findByCodigo(1).getRuta());
                System.out.println("// claveacceso: " + factura.getInfoTributaria().getClaveAcceso());
                //archivoACrear = directoriosRepository.findByCodigo(1).getRutaDirectorio()
                archivoACrear = directoriosRepository.findByCodigo(1).getRuta() + factura.getInfoTributaria().getClaveAcceso() + ".xml";
                if (DocumentosUtil.crearArchivo(factura, archivoACrear)) {
                    claveAcceso = factura.getInfoTributaria().getClaveAcceso();
                    secuencial = factura.getInfoTributaria().getSecuencial();
                    System.out.println("enviarFacturaElectronicaSRI");
                    enviarSRIAutoriacion(firmaDocElectronico, comprobanteElectronico);
                    return new ResponseEntity<>(HttpStatus.OK);
                } else {
                    return new ResponseEntity<>(HttpStatus.OK);
                }
            }
        }
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @RequestMapping(value = RestAPI.reenviarfacturacionElectronicaPOST, method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<?> reenviarFacturaElectronicaSRI(
            @Valid @RequestBody ComprobanteElectronico comprobanteElectronico) {
        FirmaDocElectronico firmaDocElectronico = validarComprobanteRest(comprobanteElectronico);
        if (firmaDocElectronico != null) {
            Factura factura = createXML(firmaDocElectronico, comprobanteElectronico);
            if (factura != null) {
                //archivoACrear = directoriosRepository.findByCodigo(1).getRutaDirectorio()
                archivoACrear = directoriosRepository.findByCodigo(1).getRuta()
                        + factura.getInfoTributaria().getClaveAcceso() + ".xml";
                if (DocumentosUtil.crearArchivo(factura, archivoACrear)) {

                    claveAcceso = factura.getInfoTributaria().getClaveAcceso();
                    secuencial = factura.getInfoTributaria().getSecuencial();
                    System.out.println("reenviarFacturaElectronicaSRI");
                    enviarSRIAutoriacion(firmaDocElectronico, comprobanteElectronico);
                    return new ResponseEntity<>(HttpStatus.OK);
                } else {
                    return new ResponseEntity<>(HttpStatus.OK);
                }
            }
        }
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @RequestMapping(value = RestAPI.renFacturacionElectronicaPOST, method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @Async
    public ResponseEntity<?> enviarRenFacturaElectronicaSRI(
            @Valid @RequestBody ComprobanteElectronico comprobanteElectronico) {
        FirmaDocElectronico firmaDocElectronico = validarComprobanteRest(comprobanteElectronico);
        if (firmaDocElectronico != null) {
            Factura factura = createXML(firmaDocElectronico, comprobanteElectronico);
            if (factura != null) {
                //archivoACrear = directoriosRepository.findByCodigo(1).getRutaDirectorio()
                archivoACrear = directoriosRepository.findByCodigo(1).getRuta()
                        + factura.getInfoTributaria().getClaveAcceso() + ".xml";
                if (DocumentosUtil.crearArchivo(factura, archivoACrear)) {

                    claveAcceso = factura.getInfoTributaria().getClaveAcceso();
                    secuencial = factura.getInfoTributaria().getSecuencial();
                    System.out.println("enviarRenFacturaElectronicaSRI ");
                    enviarSRIAutoriacion(firmaDocElectronico, comprobanteElectronico);
                    return new ResponseEntity<>(this.comprobanteSRI, HttpStatus.OK);
                } else {
                    return new ResponseEntity<>(null, HttpStatus.OK);
                }
            }
        }
        return new ResponseEntity<>(null, HttpStatus.OK);
    }

    @RequestMapping(value = RestAPI.reenviarRenFacturacionElectronicaPOST, method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<?> reenviarRenFacturaElectronicaSRI(
            @Valid @RequestBody ComprobanteElectronico comprobanteElectronico) {
        FirmaDocElectronico firmaDocElectronico = validarComprobanteRest(comprobanteElectronico);
        if (firmaDocElectronico != null) {
            Factura factura = createXML(firmaDocElectronico, comprobanteElectronico);
            if (factura != null) {
                //archivoACrear = directoriosRepository.findByCodigo(1).getRutaDirectorio()
                archivoACrear = directoriosRepository.findByCodigo(1).getRuta()
                        + factura.getInfoTributaria().getClaveAcceso() + ".xml";
                if (DocumentosUtil.crearArchivo(factura, archivoACrear)) {
                    claveAcceso = factura.getInfoTributaria().getClaveAcceso();
                    secuencial = factura.getInfoTributaria().getSecuencial();
                    enviarSRIAutoriacion(firmaDocElectronico, comprobanteElectronico);
                    return new ResponseEntity<>(this.comprobanteSRI, HttpStatus.OK);
                } else {
                    return new ResponseEntity<>(null, HttpStatus.OK);
                }
            }
        }
        return new ResponseEntity<>(null, HttpStatus.OK);
    }

    @RequestMapping(value = RestAPI.notaCreditoElectronicaPOST, method = RequestMethod.POST)
    @Async
    public ResponseEntity<?> enviarNotaCreditoSRI(@Valid @RequestBody ComprobanteElectronico comprobanteElectronico) {
        FirmaDocElectronico firmaDocElectronico = validarComprobanteRest(comprobanteElectronico);
        System.out.println("firmaDocElectronico " + firmaDocElectronico);
        if (firmaDocElectronico != null) {
            NotaCredito notaCredito = createXMLNotaCredito(firmaDocElectronico, comprobanteElectronico);
            //this.archivoACrear = directoriosRepository.findByCodigo(1).getRutaDirectorio()
            this.archivoACrear = directoriosRepository.findByCodigo(1).getRuta()
                    + notaCredito.getInfoTributaria().getClaveAcceso() + ".xml";
            if (DocumentosUtil.crearArchivo(notaCredito, archivoACrear)) {
                claveAcceso = notaCredito.getInfoTributaria().getClaveAcceso();
                secuencial = notaCredito.getInfoTributaria().getSecuencial();
                enviarSRIAutoriacion(firmaDocElectronico, comprobanteElectronico);
                return new ResponseEntity<>(this.comprobanteSRI, HttpStatus.OK);
            }
        }
        return null;
    }

    @RequestMapping(value = RestAPI.notaDebitoElectronicaPOST, method = RequestMethod.POST)
    public ResponseEntity<?> enviarNotaDebitoSRI(@Valid @RequestBody ComprobanteElectronico comprobanteElectronico) {
        FirmaDocElectronico firmaDocElectronico = validarComprobanteRest(comprobanteElectronico);
        if (firmaDocElectronico != null) {
            NotaDebito notaDebito = crearXMLNotaDebito(firmaDocElectronico, comprobanteElectronico);
            //this.archivoACrear = directoriosRepository.findByCodigo(1).getRutaDirectorio()
            this.archivoACrear = directoriosRepository.findByCodigo(1).getRuta()
                    + notaDebito.getInfoTributaria().getClaveAcceso() + ".xml";
            if (DocumentosUtil.crearArchivo(notaDebito, archivoACrear)) {
                claveAcceso = notaDebito.getInfoTributaria().getClaveAcceso();
                secuencial = notaDebito.getInfoTributaria().getSecuencial();
                enviarSRIAutoriacion(firmaDocElectronico, comprobanteElectronico);
                return new ResponseEntity<>(this.comprobanteSRI, HttpStatus.OK);
            }
        }
        return null;
    }

    @RequestMapping(value = RestAPI.comprobanteRetencionElectronicaPOST, method = RequestMethod.POST)
    public ResponseEntity<?> enviarComprobanteRentencionSRI(
            @Valid @RequestBody ComprobanteElectronico comprobanteElectronico) {
        FirmaDocElectronico firmaDocElectronico = validarComprobanteRest(comprobanteElectronico);
        if (firmaDocElectronico != null) {
            ComprobanteRetencion comprobanteRetencion = crearXMLComprobanteRetencion(firmaDocElectronico,
                    comprobanteElectronico);
            //this.archivoACrear = directoriosRepository.findByCodigo(1).getRutaDirectorio()
            this.archivoACrear = directoriosRepository.findByCodigo(1).getRuta()
                    + comprobanteRetencion.getInfoTributaria().getClaveAcceso() + ".xml";
            if (DocumentosUtil.crearArchivo(comprobanteRetencion, archivoACrear)) {
                claveAcceso = comprobanteRetencion.getInfoTributaria().getClaveAcceso();
                secuencial = comprobanteRetencion.getInfoTributaria().getSecuencial();
                enviarSRIAutoriacion(firmaDocElectronico, comprobanteElectronico);
                return new ResponseEntity<>(HttpStatus.OK);
            }
        }
        return new ResponseEntity<>(HttpStatus.OK);
    }

    private FirmaDocElectronico validarComprobanteRest(ComprobanteElectronico comprobanteElectronico) {
        if (Calculos.validarCamposComprobanteElectronico(comprobanteElectronico)) {
            FirmaDocElectronico firmaDocElectronico = this.getFirmaDocElectronico(comprobanteElectronico);
            System.out.println("// prueba 2");
            if (firmaDocElectronico != null) {
                System.out.println("validacion de comprobante rest: " + DocumentosUtil.validarPasswordCertificado(firmaDocElectronico));
                if (DocumentosUtil.validarPasswordCertificado(firmaDocElectronico)) {
                    return firmaDocElectronico;
                }
            }
        }
        return null;
    }

    private FirmaDocElectronico getFirmaDocElectronico(ComprobanteElectronico comprobanteElectronico) {
        System.out.println("//punto emision --> " + comprobanteElectronico.getPuntoEmision());
        Cajero cajero = cajeroRepository.findByPuntoEmision(comprobanteElectronico.getPuntoEmision());
        Entidad entidad = entidadRepository.findByRucEntidad(comprobanteElectronico.getRucEntidad());
        Comprobante comprobante = comprobanteRepository.findByCodigo(comprobanteElectronico.getComprobanteCodigo());
        Ambiente ambiente = ambienteRepository.findByCodigo(comprobanteElectronico.getAmbiente());
        Firma firma = new Firma(cajero.getArchivo(), cajero.getClave(), "A");
        TipoEmision tipoEmision = tipoEmisionRepository.findByCodigo("1");
        //tipoEmision.setEsOnline(comprobanteElectronico.getIsOnline());
        DocElectronico doc = new DocElectronico(entidad, comprobante, tipoEmision, ambiente, "A");
        return new FirmaDocElectronico(firma, doc, entidad.getEstablecimiento(),
                comprobanteElectronico.getPuntoEmision(), comprobanteElectronico.getIsOnline());
    }

    void enviarSRIAutoriacion(FirmaDocElectronico firmaDocElectronico,
            ComprobanteElectronico comprobanteElectronico) {
        continuar = Boolean.TRUE;
        RespuestaSolicitud rs = getRespuestaSolicitud(firmaDocElectronico, comprobanteElectronico.getTramite());
        System.out.println("rs: " + rs.toString());
        RespuestaComprobante rc = null;
        if (rs != null && rs.getEstado() != null) {
            if (rs.getEstado().equals(Constantes.RECIBIDA)) {
                rc = getRespuestaComprobante(firmaDocElectronico, comprobanteElectronico.getTramite());
                if (comprobanteElectronico.getReenvioVerificacion()) {
                    Conexion.updateReenvioLiquidacion(comprobanteElectronico.getIdLiquidacion(), "REENVIADA");
                }
            } else {
                if (rs != null && rs.getCodigoError() != null) {
                    if (rs.getCodigoError().equals(Constantes.CODE_CLAVE_ACCESO_REGISTRADA)) {
                        if (!comprobanteElectronico.getReenvioVerificacion()) {
                            rs.setEstado("RECIBIDA");
                            rc = getRespuestaComprobante(firmaDocElectronico, comprobanteElectronico.getTramite());
                            continuar = Boolean.TRUE;
                        } else {
                            continuar = Boolean.FALSE;
                            Conexion.updateReenvioLiquidacion(comprobanteElectronico.getIdLiquidacion(), "REVISADA");
                        }
                    }
                }
            }
        }
        System.out.println("continuar: " + continuar);
        if (continuar) {
            facturaSRIRespuest(firmaDocElectronico, rs, rc, comprobanteElectronico);
        }
    }

    private RespuestaSolicitud getRespuestaSolicitud(FirmaDocElectronico firmaDocElectronico, Long tramite) {
        System.out.println("getRespuestaSolicitud ");
        RespuestaSolicitud rsRespuesta = DocumentosUtil.firmarXMLRecepcion(
                directoriosRepository.findByCodigo(-1).getRuta(), archivoACrear,
                directoriosRepository.findByCodigo(2).getRuta(), firmaDocElectronico, claveAcceso,
                firmaDocElectronico.getIsOnline());
        if (rsRespuesta != null) {
            //rsRespuesta.set_id(ObjectId.get());
            rsRespuesta.setTramite(tramite);
            rsRespuesta.setFechaIngreso(new Date());
            respuestaSolicitudRepository.save(rsRespuesta);
        }
        return rsRespuesta;
    }

    private RespuestaComprobante getRespuestaComprobante(FirmaDocElectronico firmaDocElectronico, Long tramite) {

        RespuestaComprobante respuestaComprobante = DocumentosUtil.autorizacionXMLSRI(claveAcceso,
                directoriosRepository.findByCodigo(3).getRuta(),
                directoriosRepository.findByCodigo(6).getRuta(),
                firmaDocElectronico.getDocElectronico().getAmbiente().getWsUrlAutorizacion(),
                firmaDocElectronico.getIsOnline());
        // System.out.println("respuestaComprobante " +
        // respuestaComprobante.toString());
        if (respuestaComprobante != null) {
            //respuestaComprobante.set_id(ObjectId.get());
            respuestaComprobante.setResponse(gson.toJson(respuestaComprobante.getAutorizaciones().getAutorizacion()));
            respuestaComprobante.setTramite(tramite);
            respuestaComprobante.setFechaIngreso(new Date());
            respuestaComprobanteRepository.save(respuestaComprobante);
        }
        return respuestaComprobante;

    }

    private void facturaSRIRespuest(FirmaDocElectronico firmaDocElectronico, RespuestaSolicitud respuestaSolicitud,
            RespuestaComprobante respuestaComprobante, ComprobanteElectronico comprobanteElectronico) {
        this.comprobanteSRI = new ComprobanteSRI();

        this.comprobanteSRI
                .setTipoComprobante(firmaDocElectronico.getDocElectronico().getComprobante().getDescripcion());
        this.comprobanteSRI
                .setCodigoTipoComprobante(firmaDocElectronico.getDocElectronico().getComprobante().getCodigo());
        // this.comprobanteSRI.setRespuestaSolicitudSRI(DocumentosUtil.loadValuesRespuestaSolicitudSRI(respuestaSolicitud));
        if (respuestaSolicitud != null) {
            if (respuestaSolicitud.getEstado() != null
                    && !respuestaSolicitud.getEstado().equals(Constantes.SIN_CONEXION)) {
                this.comprobanteSRI
                        .setRespuestaSolicitudSRI(DocumentosUtil.loadValuesRespuestaSolicitudSRI(respuestaSolicitud));
            }
        }

        if (respuestaComprobante != null) {
            this.comprobanteSRI.setRespuestaAutorizacionSRI(
                    DocumentosUtil.loadValuesRespuestaComprobanteSRI(respuestaComprobante));
        }

        // SETEAR OS DATOS DE LA ENTIDAD QUE EMITE LA FACTURA
        this.comprobanteSRI.getEntidad()
                .setIdemtificacion(firmaDocElectronico.getDocElectronico().getEntidad().getRucEntidad());
        this.comprobanteSRI.getEntidad()
                .setNombres(firmaDocElectronico.getDocElectronico().getEntidad().getNombreEntidad());
        this.comprobanteSRI.getEntidad()
                .setNombreComercial(firmaDocElectronico.getDocElectronico().getEntidad().getNombreComercial());
        this.comprobanteSRI.getEntidad()
                .setObligadoContabilidad(firmaDocElectronico.getDocElectronico().getEntidad().getContabilidad());
        this.comprobanteSRI.getEntidad().setContribuyenteEspecial(
                firmaDocElectronico.getDocElectronico().getEntidad().getContribuyenteEspecial());
        this.comprobanteSRI.getEntidad()
                .setDireccionMatriz(firmaDocElectronico.getDocElectronico().getEntidad().getDireccion());
        this.comprobanteSRI.getEntidad()
                .setDireccionSucursal(firmaDocElectronico.getDocElectronico().getEntidad().getDireccionSucursal());
        this.comprobanteSRI.getEntidad().setLogo(firmaDocElectronico.getDocElectronico().getEntidad().getLogo());

        /// SET DATOS DE LA PERSONA QUE COMPRA
        this.comprobanteSRI.getContribuyente().setIdemtificacion(comprobanteElectronico.getCabecera().getCedulaRuc());
        this.comprobanteSRI.getContribuyente().setNombres(comprobanteElectronico.getCabecera().getPropietario());
        this.comprobanteSRI.getContribuyente().setDireccion(comprobanteElectronico.getCabecera().getDireccion());
        this.comprobanteSRI.getContribuyente().setTelefono(comprobanteElectronico.getCabecera().getTelefono());
        this.comprobanteSRI.getContribuyente().setEmail(comprobanteElectronico.getCabecera().getCorreo());
        this.comprobanteSRI.setDescuentoAdicional(comprobanteElectronico.getDescuentoAdicional());

        // SET DATOS FACTURAS
        // PARA NO REPETIR CODIGO
        if (!comprobanteElectronico.getComprobanteCodigo().equals(ComprobantesCode.NOTADEBITO)
                && !comprobanteElectronico.getComprobanteCodigo().equals(ComprobantesCode.COMPPROBANTERETENCION)) {
            Map<String, Double> totalesFactura = Calculos.totalesFactura(comprobanteElectronico);
            this.comprobanteSRI.setSubTotalNoObjetoIva(new BigDecimal(totalesFactura.get("subTotalNoOnjetoIva")));
            this.comprobanteSRI.setSubTotalSinImpuetos(new BigDecimal(totalesFactura.get("totalSinImpuestos")));
            this.comprobanteSRI.setDescuento(new BigDecimal(totalesFactura.get("totalDescuento"))
                    .subtract(this.comprobanteSRI.getDescuentoAdicional()));
            this.comprobanteSRI.setIva(new BigDecimal(totalesFactura.get("totalIva")));
            this.comprobanteSRI.setValorTotal(new BigDecimal(totalesFactura.get("importeTotalimporteTotal")));
        } else {
            if (comprobanteElectronico.getComprobanteCodigo().equals(ComprobantesCode.NOTADEBITO)) {
                this.comprobanteSRI.setSubTotalNoObjetoIva(Calculos.totalSinImpuestoNotaDebito(comprobanteElectronico));
                this.comprobanteSRI.setIva(comprobanteElectronico.getImpuestoNotaDebito().getValor());
                this.comprobanteSRI
                        .setValorTotal(this.comprobanteSRI.getSubTotalNoObjetoIva().add(this.comprobanteSRI.getIva()));
            }
        }

        this.comprobanteSRI.setNumFactura(
                firmaDocElectronico.getEstablecimiento() + firmaDocElectronico.getPuntoEmision() + secuencial);

        this.comprobanteSRI.setNumFacturaFormato(firmaDocElectronico.getEstablecimiento() + "-"
                + firmaDocElectronico.getPuntoEmision() + "-" + secuencial);

        if (respuestaComprobante != null && !respuestaComprobante.getAutorizaciones().getAutorizacion().isEmpty()) {
            this.comprobanteSRI.setNumAutorizacion(
                    respuestaComprobante.getAutorizaciones().getAutorizacion().get(0).getNumeroAutorizacion());
            XMLGregorianCalendar fechaAutorizacion = respuestaComprobante.getAutorizaciones().getAutorizacion().get(0)
                    .getFechaAutorizacion();
            if (fechaAutorizacion != null) {
                this.comprobanteSRI.setFechaAutorizacion(
                        fechaAutorizacion.getYear() + "-" + String.format("%02d", fechaAutorizacion.getMonth()) + "-"
                        + fechaAutorizacion.getDay() + " " + fechaAutorizacion.getHour() + ":"
                        + fechaAutorizacion.getMinute() + ":" + fechaAutorizacion.getSecond());

                this.comprobanteSRI.setFechaAutorizacion(String.format("%02d", fechaAutorizacion.getDay()) + "-"
                        + String.format("%02d", fechaAutorizacion.getMonth()) + "-" + fechaAutorizacion.getYear() + " "
                        + String.format("%02d", fechaAutorizacion.getHour()) + ":"
                        + String.format("%02d", fechaAutorizacion.getMinute()) + ":"
                        + String.format("%02d", fechaAutorizacion.getSecond()));

            }
        }

        this.comprobanteSRI.setAmbiente(firmaDocElectronico.getDocElectronico().getAmbiente().getDescripcion());
        this.comprobanteSRI.setEmision(firmaDocElectronico.getDocElectronico().getTipoEmision().getDescripcion());
        this.comprobanteSRI.setClaveAcceso(claveAcceso);
        this.comprobanteSRI.setFechaEmision(comprobanteElectronico.getCabecera().getFechaEmision());

        // AL SER ENTIDA PUBLICA SE LE SETEA ZERO
        this.comprobanteSRI.setSubTotal12(BigDecimal.ZERO);
        this.comprobanteSRI.setSubTotalIva(BigDecimal.ZERO);
        this.comprobanteSRI.setSubTotalExcentoIva(BigDecimal.ZERO);
        this.comprobanteSRI.setIce(BigDecimal.ZERO);
        this.comprobanteSRI.setIrbpnr(BigDecimal.ZERO);
        this.comprobanteSRI.setPropina(BigDecimal.ZERO);
        this.comprobanteSRI.setPropina(BigDecimal.ZERO);
        this.comprobanteSRI.setValorSinSubSidio(BigDecimal.ZERO);
        this.comprobanteSRI.setAhorroPorSubSidio(BigDecimal.ZERO);

        // SET DATOS DETALLE FACTURA
        if (!comprobanteElectronico.getComprobanteCodigo().equals(ComprobantesCode.NOTADEBITO)
                && !comprobanteElectronico.getComprobanteCodigo().equals(ComprobantesCode.COMPPROBANTERETENCION)) {
            ComprobanteDetalleSRI comprobanteDetalleSRI;
            for (Detalle detalle : comprobanteElectronico.getDetalles().getDetalle()) {
                comprobanteDetalleSRI = new ComprobanteDetalleSRI();
                comprobanteDetalleSRI.setCodigoPrincipal(detalle.getCodigoPrincipal());
                comprobanteDetalleSRI.setCodigoAuxiliar(detalle.getCodigoAuxiliar());
                comprobanteDetalleSRI.setCantidad(detalle.getCantidad());
                comprobanteDetalleSRI.setDescripcion(detalle.getDescripcion());
                comprobanteDetalleSRI.setPrecioUnitario(new BigDecimal(detalle.getValorUnitario() + detalle.getRecargo()));
                comprobanteDetalleSRI.setSubsidio(BigDecimal.ZERO);
                comprobanteDetalleSRI.setPrecioSinSubsidio(BigDecimal.ZERO);
                comprobanteDetalleSRI.setDescuento(new BigDecimal(detalle.getDescuento()));
                comprobanteDetalleSRI.setPrecioTotal(new BigDecimal(detalle.getValorTotal()));
                this.comprobanteSRI.getDetalleFactura().add(comprobanteDetalleSRI);
            }
            //comprobanteDetalleSRI = null;
        }

        /// SET DATOS PAGOS
        ComprobantePagoSRI comprobantePagoSRI;
        if (comprobanteElectronico.getDetallePagos() != null) {
            for (DetallePago detallePago : comprobanteElectronico.getDetallePagos()) {
                comprobantePagoSRI = new ComprobantePagoSRI();
                comprobantePagoSRI
                        .setDescripcion(formasPagoRepository.findByCodigo(detallePago.getFormaPago()).getDescripcion());
                comprobantePagoSRI.setValor(new BigDecimal(detallePago.getTotal()));
                this.comprobanteSRI.getPagoDetalle().add(comprobantePagoSRI);
            }
            //comprobantePagoSRI = null;
        }

        if (comprobanteElectronico.getComprobanteCodigo().equals(ComprobantesCode.NOTACREDITO)
                || comprobanteElectronico.getComprobanteCodigo().equals(ComprobantesCode.NOTADEBITO)) {
            this.comprobanteSRI.setTipoDocumentoModifica(comprobanteElectronico.getTipoDocumentoModifica());
            this.comprobanteSRI.setNumComprobanteModifica(comprobanteElectronico.getNumComprobanteModifica());
            this.comprobanteSRI.setMotivoNotaCredito(comprobanteElectronico.getMotivoNotaCredito());
            this.comprobanteSRI
                    .setFechaEmisionDocumentoModifica(comprobanteElectronico.getFechaEmisionDocumentoModifica());
            String compModif = "";
            if (comprobanteElectronico.getTipoDocumentoModifica().length() <= 1) {
                compModif = String.format("%02d", comprobanteElectronico.getTipoDocumentoModifica());
            } else {
                compModif = comprobanteElectronico.getTipoDocumentoModifica();
            }
            /*this.comprobanteSRI.setDescripcionComprobanteModifica(
                    firmaDocElectronicoRepository
                            .findByPuntoEmisionAndDocElectronico_Entidad_RucEntidadAndDocElectronico_Comprobante_CodigoAndDocElectronico_Ambiente_CodigoAndFirma_EstadoAndIsOnline(
                                    comprobanteElectronico.getPuntoEmision(), comprobanteElectronico.getRucEntidad(),
                                    compModif, comprobanteElectronico.getAmbiente(), "abierto",
                                    comprobanteElectronico.getIsOnline())
                            .getDocElectronico().getComprobante().getDescripcion());*/
            this.comprobanteSRI.setDescripcionComprobanteModifica("");
        }
        if (comprobanteElectronico.getComprobanteCodigo().equals(ComprobantesCode.NOTADEBITO)) {
            this.comprobanteSRI.setMotivosNotaDebito(comprobanteElectronico.getMotivosNotaDebito());
        }

        if (comprobanteElectronico.getComprobanteCodigo().equals(ComprobantesCode.COMPPROBANTERETENCION)) {

            String mesPeriodoF = "";
            if (comprobanteElectronico.getMes().length() == 1) {
                mesPeriodoF = "0" + comprobanteElectronico.getMes();
            } else {
                mesPeriodoF = comprobanteElectronico.getMes();
            }
            this.comprobanteSRI.setPeriodo(mesPeriodoF + "/" + comprobanteElectronico.getAnio());

            BigDecimal totalRetenido = BigDecimal.ZERO, totalRetenidoAcum = BigDecimal.ZERO;
            for (ImpuestoComprobanteElectronico impuestoComprobanteElectronico : comprobanteElectronico
                    .getImpuestoComprobanteRetencion()) {
                impuestoComprobanteElectronico.setDescripcionDocumentoModificado("");
                /*impuestoComprobanteElectronico.setDescripcionDocumentoModificado(firmaDocElectronicoRepository
                        .findByPuntoEmisionAndDocElectronico_Entidad_RucEntidadAndDocElectronico_Comprobante_CodigoAndDocElectronico_Ambiente_CodigoAndFirma_EstadoAndIsOnline(
                                comprobanteElectronico.getPuntoEmision(), comprobanteElectronico.getRucEntidad(),
                                impuestoComprobanteElectronico.getCodigoDocumento(),
                                impuestoComprobanteElectronico.getAmbiente(), "abierto",
                                comprobanteElectronico.getIsOnline())
                        .getDocElectronico().getComprobante().getDescripcion());*/
                impuestoComprobanteElectronico.setDescripcionImpuestoRetenido(impuestosAsignadosRetencionRepository
                        .findByCodigo(impuestoComprobanteElectronico.getCodigo()).getDescripcion());
                totalRetenido = impuestoComprobanteElectronico.getBaseImponible()
                        .multiply(impuestoComprobanteElectronico.getPorcentajeRetencion())
                        .setScale(2, RoundingMode.HALF_UP);
                totalRetenido = totalRetenido.divide(new BigDecimal("100")).setScale(2, RoundingMode.HALF_UP);
                totalRetenidoAcum = totalRetenidoAcum.add(totalRetenido);
                impuestoComprobanteElectronico.setValor(totalRetenido);
                this.comprobanteSRI.getImpuestoComprobanteRetencion().add(impuestoComprobanteElectronico);
            }
            this.comprobanteSRI.setValorTotal(totalRetenidoAcum);
        }
        this.comprobanteSRI.setTramite(comprobanteElectronico.getTramite());
        this.comprobanteSRI.setFecha(new Date());
        this.comprobanteSRI.setResponse(gson.toJson(respuestaComprobante));
        /// SI EXISTE NUMERO DE AUTORIZACION
        if (this.comprobanteSRI.getNumAutorizacion() != null) {
            //String pathAutorizados = directoriosRepository.findByCodigo(3).getRutaDirectorio();
            String pathAutorizados = directoriosRepository.findByCodigo(3).getRuta();
            /// RNOMBRA EL ARCHIVO XML PORQUE ASI ESTA EN PORTOVIEJO =( </3
            String initNombreReporte, xmlPath;
            if (comprobanteElectronico.getComprobanteCodigo().equals(ComprobantesCode.NOTACREDITO)) {
                initNombreReporte = "notacredito_";
                xmlPath = pathAutorizados + initNombreReporte + this.comprobanteSRI.getNumFactura() + ".xml";
            } else {
                initNombreReporte = "factura_";
                xmlPath = pathAutorizados + initNombreReporte + this.comprobanteSRI.getNumFactura() + ".xml";
            }

            renameFileXMLComprobante(pathAutorizados + claveAcceso + ".xml", xmlPath);
            this.comprobanteSRI.getEntidad().setLogo(firmaDocElectronico.getDocElectronico().getEntidad().getLogo());

            this.comprobanteSRI.setXmlPath(xmlPath);
            this.comprobanteSRI.setPdfPath(pathAutorizados + initNombreReporte + this.comprobanteSRI.getNumFactura() + ".pdf");
            //DocumentosUtil.generarPDFFacturacionElectronica(comprobanteSRI, directoriosRepository.findByCodigo(-2).getRutaDirectorio());
            DocumentosUtil.generarPDFFacturacionElectronica(comprobanteSRI, directoriosRepository.findByCodigo(-2).getRuta());
            // secuenciaComprobanteRepository.save(secuenciaComprobante);
            /// SEND MAILT O USER}
            //  System.out.println("send mail not");
            if (comprobanteElectronico.getCabecera().getCorreo() != null
                    && comprobanteElectronico.getCabecera().getCorreo().length() > 0) {
                //emailService.sendMailContribuyente(msgFormatoNotificacionRepository.findTopByAsuntoIsNotNull(),
                emailService.sendMailContribuyente(msgFormatoNotificacionRepository.findByTipo(1L),
                        this.comprobanteSRI.getXmlPath(), this.comprobanteSRI.getPdfPath(),
                        comprobanteElectronico.getCabecera().getCorreo());
            }
        }
        if (comprobanteElectronico.getNumComprobante() == null) {
            this.comprobanteSRI.setNumComprobante(firmaDocElectronico.getSecuencial());
        } else {
            this.comprobanteSRI.setNumComprobante(new BigInteger(comprobanteElectronico.getNumComprobante()));
        }
        System.out.println("comprobanteElectronico.getIdLiquidacion(): " + comprobanteElectronico.getIdLiquidacion());
        if (comprobanteElectronico.getIdLiquidacion() != null) {
            Conexion.updateAutorizacion(comprobanteElectronico.getTipoLiquidacionSGR(), comprobanteElectronico.getIdLiquidacion(), this.comprobanteSRI);
        }
        comprobanteSRIRepository.save(this.comprobanteSRI);
    }

    private void renameFileXMLComprobante(String fileNameOld, String fileNameNew) {
        File fileOld = new File(fileNameOld);
        File fileNew = new File(fileNameNew);
        fileOld.renameTo(fileNew);
        if (fileOld.exists()) {
            fileOld.delete();
        }
    }

    private Factura createXML(FirmaDocElectronico firmaDocElectronico, ComprobanteElectronico comprobanteElectronico) {
        Factura factura = null;
        String secuencialComprobante;
        /*
         * SI LA SECUENCIA LA GENERA EL SGR SE ACTIVA ESTO SI NO NO =O
         * secuencialComprobante =
         * comprobanteElectronico.getNumComprobante().substring(6);
         */

        secuencialComprobante = secuencialComprobante(firmaDocElectronico, comprobanteElectronico);
        Factura.InfoFactura infoFactura = Calculos.loadInfoFactura(firmaDocElectronico, comprobanteElectronico);
        if (!comprobanteElectronico.getCabecera().getEsPasaporte()) {
            infoFactura.setTipoIdentificacionComprador(tipoIdentificacionRepository
                    .findByTamanio(comprobanteElectronico.getCabecera().getCedulaRuc().length()).getCodigo());
        } else {
            infoFactura.setTipoIdentificacionComprador("06");
        }
        infoFactura.setTotalConImpuestos(generaTotalesImpuesto(comprobanteElectronico));
        // GENERA EL DETALLE DE LA FACTURA
        Factura.Detalles detalles = generarDetalleFactura(comprobanteElectronico);
        Factura.InfoAdicional informacion = Calculos.generarInformacionAdicionalFactura(comprobanteElectronico);
        factura = new Factura();
        factura.setInfoTributaria(this.getInfoTributaria(secuencialComprobante, firmaDocElectronico, comprobanteElectronico));
        factura.setInfoFactura(infoFactura);
        if (detalles != null) {
            factura.setDetalles(detalles);
        }
        if (informacion.getCampoAdicional().size() > 0) {
            factura.setInfoAdicional(informacion);
        }
        factura.setVersion(Constantes.VERSION);
        factura.setId(Constantes.ID);
        return factura;

    }

    private NotaCredito createXMLNotaCredito(FirmaDocElectronico firmaDocElectronico,
            ComprobanteElectronico comprobanteElectronico) {
        NotaCredito notaCredito = new NotaCredito();

        String secuencialComprobante = secuencialComprobante(firmaDocElectronico, comprobanteElectronico);
        //secuencialComprobante = comprobanteElectronico.getNumComprobanteModifica().substring(6);

        NotaCredito.Detalles detalles = generarDetalleNotaCredito(comprobanteElectronico);
        NotaCredito.InfoNotaCredito infoNotaCredito = Calculos.loadInfoNotaCredito(firmaDocElectronico,
                comprobanteElectronico);
        if (!comprobanteElectronico.getCabecera().getEsPasaporte()) {
            infoNotaCredito.setTipoIdentificacionComprador(tipoIdentificacionRepository
                    .findByTamanio(comprobanteElectronico.getCabecera().getCedulaRuc().length()).getCodigo());
        } else {
            infoNotaCredito.setTipoIdentificacionComprador("06");
        }

        NotaCredito.InfoAdicional infoAdicional = Calculos
                .generarInformacionAdicionalNotaCredito(comprobanteElectronico);
        infoNotaCredito.setTipoIdentificacionComprador(tipoIdentificacionRepository
                .findByTamanio(comprobanteElectronico.getCabecera().getCedulaRuc().length()).getCodigo());
        infoNotaCredito.setTotalConImpuestos(generaTotalesImpuestoNotaCredito(comprobanteElectronico));
        notaCredito.setInfoNotaCredito(infoNotaCredito);
        notaCredito.setInfoTributaria(
                getInfoTributaria(secuencialComprobante, firmaDocElectronico, comprobanteElectronico));
        notaCredito.setInfoAdicional(infoAdicional);
        notaCredito.setDetalles(detalles);
        notaCredito.setVersion(Constantes.VERSION);
        notaCredito.setId(Constantes.ID);
        return notaCredito;
    }

    private NotaDebito crearXMLNotaDebito(FirmaDocElectronico firmaDocElectronico,
            ComprobanteElectronico comprobanteElectronico) {
        NotaDebito notaDebito = new NotaDebito();
        notaDebito.setVersion(Constantes.VERSION);
        notaDebito.setId(Constantes.ID);

        String secuencialComprobante = secuencialComprobante(firmaDocElectronico, comprobanteElectronico);
        notaDebito.setInfoTributaria(
                getInfoTributaria(secuencialComprobante, firmaDocElectronico, comprobanteElectronico));

        NotaDebito.InfoNotaDebito infoNotaDebito = Calculos.loadInfoNotaDebito(firmaDocElectronico,
                comprobanteElectronico);
        infoNotaDebito.setTipoIdentificacionComprador(tipoIdentificacionRepository
                .findByTamanio(comprobanteElectronico.getCabecera().getCedulaRuc().length()).getCodigo());
        NotaDebito.InfoAdicional infoAdicional = Calculos.generarInformacionAdicionalNotaDebito(comprobanteElectronico);
        NotaDebito.InfoNotaDebito.Impuestos impuestos = new NotaDebito.InfoNotaDebito.Impuestos();
        impuestos.getImpuesto().add(Calculos.impuestoNotaDebito(comprobanteElectronico));
        infoNotaDebito.setImpuestos(impuestos);
        notaDebito.setMotivos(Calculos.obtenerMotivos(comprobanteElectronico));
        notaDebito.setInfoAdicional(infoAdicional);
        notaDebito.setInfoNotaDebito(infoNotaDebito);

        return notaDebito;
    }

    private ComprobanteRetencion crearXMLComprobanteRetencion(FirmaDocElectronico firmaDocElectronico,
            ComprobanteElectronico comprobanteElectronico) {
        ComprobanteRetencion comprobanteRetencion = new ComprobanteRetencion();
        comprobanteRetencion.setVersion(Constantes.VERSION);
        comprobanteRetencion.setId(Constantes.ID);

        String secuencialComprobante = secuencialComprobante(firmaDocElectronico, comprobanteElectronico);

        ComprobanteRetencion.InfoCompRetencion infoCompRetencion = Calculos.infoCompRetencion(firmaDocElectronico,
                comprobanteElectronico);
        infoCompRetencion.setTipoIdentificacionSujetoRetenido(tipoIdentificacionRepository
                .findByTamanio(comprobanteElectronico.getCabecera().getCedulaRuc().length()).getCodigo());
        System.out.println("infoCompRetencion.setIdentificacionSujetoRetenido "
                + infoCompRetencion.getIdentificacionSujetoRetenido());
        comprobanteRetencion.setInfoTributaria(
                getInfoTributaria(secuencialComprobante, firmaDocElectronico, comprobanteElectronico));
        comprobanteRetencion.setInfoCompRetencion(infoCompRetencion);
        comprobanteRetencion.setImpuestos(Calculos.obtenerImpuestoComprobanteRetencion(comprobanteElectronico));
        comprobanteRetencion
                .setInfoAdicional(Calculos.generarInformacionAdicionalCompobanteRetencion(comprobanteElectronico));
        return comprobanteRetencion;
    }

    private String secuencialComprobante(FirmaDocElectronico firmaDocElectronico, ComprobanteElectronico comprobanteElectronico) {
        // SET VALUES SECUENCIA <secuencial>000000005</secuencial>
         /*secuenciaComprobante = secuenciaComprobanteRepository.findFirstByComprobante_CodigoOrderBySecuenciaDesc
                 (firmaDocElectronico.getDocElectronico().getComprobante().getCodigo());
         System.out.println("secuenciaComprobante " + secuenciaComprobante.toString());*/

        if (comprobanteElectronico.getNumComprobante() != null && !comprobanteElectronico.getNumComprobante().isEmpty()) {
            return String.format("%09d", new BigInteger(comprobanteElectronico.getNumComprobante()).longValue());
        } else {
            firmaDocElectronico.setSecuencial(firmaDocElectronico.getSecuencial().add(BigInteger.ONE));
            return String.format("%09d", firmaDocElectronico.getSecuencial().longValue());
        }

    }

    private InfoTributaria getInfoTributaria(String secuencialComprobante, FirmaDocElectronico firmaDocElectronico,
            ComprobanteElectronico comprobanteElectronico) {
        InfoTributaria infoTributaria = Calculos.loadInfoTributaria(secuencialComprobante, firmaDocElectronico);
        System.out.println("// infotributaria: " + infoTributaria);
        if (comprobanteElectronico.getClaveAcceso() != null) {
            System.out.println("comprobanteElectronico.getClaveAcceso() " + comprobanteElectronico.getClaveAcceso());
            infoTributaria.setClaveAcceso(comprobanteElectronico.getClaveAcceso());
        } else {
            infoTributaria.setClaveAcceso(this.claveAcceso(firmaDocElectronico, comprobanteElectronico, secuencialComprobante));
            if (infoTributaria.getClaveAcceso() == null) {
                return null;
            } else {
                if (comprobanteElectronico.getIdLiquidacion() != null && comprobanteElectronico.getTipoLiquidacionSGR() != null) {
                    System.out.println("comprobanteElectronico.getIdLiquidacion(): " + comprobanteElectronico.getIdLiquidacion()
                            + " comprobanteElectronico.getTipoLiquidacionSGR(): " + comprobanteElectronico.getTipoLiquidacionSGR()
                            + " infoTributaria.getClaveAcceso(): " + infoTributaria.getClaveAcceso());
                    Conexion.updateClaveAcceso(comprobanteElectronico.getIdLiquidacion(),
                            comprobanteElectronico.getTipoLiquidacionSGR(), infoTributaria.getClaveAcceso());
                }
            }
        }
        return infoTributaria;
    }

    private String claveAcceso(FirmaDocElectronico firmaDocElectronico, ComprobanteElectronico comprobanteElectronico, String secuencialComprobante) {
        gson = new Gson();
        String claveAcceso = DocumentosUtil.generarClaveAcceso(firmaDocElectronico, comprobanteElectronico, secuencialComprobante);
        System.out.println("// claveAcceso: " + claveAcceso);
        if (claveAcceso != null) {
            ClaveAcceso comprobanteElectronicoJsonClaveAcceso = claveAccesoRepository.findByClaveAcceso(claveAcceso);
            do {
                if (comprobanteElectronicoJsonClaveAcceso == null) {
                    comprobanteElectronicoJsonClaveAcceso = new ClaveAcceso();
                    //comprobanteElectronicoJsonClaveAcceso.setComprobanteElectronico(comprobanteElectronico);
                    comprobanteElectronicoJsonClaveAcceso.setDataModel(gson.toJson(comprobanteElectronico));
                    comprobanteElectronicoJsonClaveAcceso.setClaveAcceso(claveAcceso);
                    comprobanteElectronicoJsonClaveAcceso.setEstado(Constantes.ESTADO_ACTIVO);
                    comprobanteElectronicoJsonClaveAcceso.setFecha(new Date());
                    claveAccesoRepository.save(comprobanteElectronicoJsonClaveAcceso);
                    /// break;
                } else {
                    claveAcceso = DocumentosUtil.generarClaveAcceso(firmaDocElectronico, comprobanteElectronico,
                            secuencialComprobante);
                    comprobanteElectronicoJsonClaveAcceso = claveAccesoRepository.findByClaveAcceso(claveAcceso);
                }
            } while (comprobanteElectronicoJsonClaveAcceso == null);
            return comprobanteElectronicoJsonClaveAcceso.getClaveAcceso();
        } else {
            return null;
        }
    }

    private Factura.Detalles generarDetalleFactura(ComprobanteElectronico comprobanteElectronico) {
        Factura.Detalles detalles = new Factura.Detalles();
        Factura.Detalles.Detalle detalle;
        /*
         * Marca Chevrolet = cHEVROLET - Modelo = 2012 etc --detalles
         * adicionalesFactura.Detalles.Detalle.DetallesAdicionales detallesAdicionales =
         * new Factura.Detalles.Detalle.DetallesAdicionales();Factura.Detalles.Detalle.
         * DetallesAdicionales.DetAdicional detAdicional;
         */

        for (Detalle d : comprobanteElectronico.getDetalles().getDetalle()) {
            detalle = new Factura.Detalles.Detalle();
            detalle.setCantidad(new BigDecimal(d.getCantidad()));
            if (d.getCodigoAuxiliar() != null) {
                detalle.setCodigoAuxiliar(d.getCodigoAuxiliar());
            }
            if (d.getCodigoPrincipal() != null) {
                detalle.setCodigoPrincipal(d.getCodigoPrincipal());
            }
            if (d.getDescripcion() != null) {
                detalle.setDescripcion(d.getDescripcion());
            }

            detalle.setPrecioUnitario(new BigDecimal(d.getValorUnitario() + d.getRecargo()).setScale(2,
                    RoundingMode.HALF_UP));
            detalle.setDescuento(new BigDecimal(d.getDescuento()).setScale(2, RoundingMode.HALF_UP));

            detalle.setPrecioTotalSinImpuesto(
                    new BigDecimal(((d.getValorUnitario() + d.getRecargo())
                            * d.getCantidad().doubleValue()) - d.getDescuento()).setScale(2,
                            RoundingMode.HALF_UP));
            detalle.setImpuestos(Calculos.obtenerImpuestosFactura(d,
                    porcentajeRepository.findByCodigoTarifaAndPorcentaje(d.getCodigoTarifa(), d.getIva())));
            /*
             * detAdicional = new
             * Factura.Detalles.Detalle.DetallesAdicionales.DetAdicional();detalle.
             * setDetallesAdicionales(detallesAdicionales);
             */
            detalles.getDetalle().add(detalle);
        }
        return detalles;
    }

    private NotaCredito.Detalles generarDetalleNotaCredito(ComprobanteElectronico comprobanteElectronico) {
        NotaCredito.Detalles detalles = new NotaCredito.Detalles();
        NotaCredito.Detalles.Detalle detalle;
        /*
         * Marca Chevrolet = cHEVROLET - Modelo = 2012 etc --detalles
         * adicionalesFactura.Detalles.Detalle.DetallesAdicionales detallesAdicionales =
         * new Factura.Detalles.Detalle.DetallesAdicionales();Factura.Detalles.Detalle.
         * DetallesAdicionales.DetAdicional detAdicional;
         */

        for (Detalle d : comprobanteElectronico.getDetalles().getDetalle()) {
            detalle = new NotaCredito.Detalles.Detalle();
            detalle.setCantidad(new BigDecimal(d.getCantidad()));
            if (d.getCodigoAuxiliar() != null) {
                detalle.setCodigoAdicional(d.getCodigoAuxiliar());
            }
            if (d.getCodigoPrincipal() != null) {
                detalle.setCodigoInterno(d.getCodigoPrincipal());
            }
            if (d.getDescripcion() != null) {
                detalle.setDescripcion(d.getDescripcion());
            }
            detalle.setPrecioUnitario(new BigDecimal(d.getValorUnitario()).setScale(2, RoundingMode.HALF_UP));
            detalle.setDescuento(new BigDecimal(d.getDescuento()));
            detalle.setPrecioTotalSinImpuesto(
                    new BigDecimal(d.getValorTotal() - d.getDescuento()).setScale(2, RoundingMode.HALF_UP));
            detalle.setImpuestos(Calculos.obtenerImpuestosNotaCredito(d,
                    porcentajeRepository.findByCodigoTarifaAndPorcentaje(d.getCodigoTarifa(), d.getIva())));
            /*
             * detAdicional = new
             * Factura.Detalles.Detalle.DetallesAdicionales.DetAdicional();detalle.
             * setDetallesAdicionales(detallesAdicionales);
             */
            detalles.getDetalle().add(detalle);
        }
        return detalles;
    }

    private Factura.InfoFactura.TotalConImpuestos generaTotalesImpuesto(ComprobanteElectronico comprobanteElectronico) {

        System.out.println("comprobanteElectronico.getDetalles().getDetalle().size ");

        Porcentajes porcentajes;

        List<Factura.InfoFactura.TotalConImpuestos.TotalImpuesto> totalImpuestoList = new ArrayList<Factura.InfoFactura.TotalConImpuestos.TotalImpuesto>();

        System.out.println("comprobanteElectronico.getDetalles().getDetalle().size "
                + comprobanteElectronico.getDetalles().getDetalle().size());

        /// MODIFICAR PAARA CUANDO EL IVVA EXISTA O EXISTA ALGUN TIPO DE ICE
        for (Detalle d : comprobanteElectronico.getDetalles().getDetalle()) {
            porcentajes = porcentajeRepository.findByCodigoTarifaAndPorcentaje(d.getCodigoTarifa(), d.getIva());
            totalImpuestoList.add(Calculos.generaTotalImpuesto(d, porcentajes));
        }

        String codigo = "";
        String codigoPorcentaje = "";
        BigDecimal tarifa = BigDecimal.ZERO;
        BigDecimal baseImponible = BigDecimal.ZERO;
        BigDecimal valor = BigDecimal.ZERO;
        for (Factura.InfoFactura.TotalConImpuestos.TotalImpuesto t : totalImpuestoList) {
            codigo = t.getCodigo();
            codigoPorcentaje = t.getCodigoPorcentaje();
            baseImponible = baseImponible.add(t.getBaseImponible());
            valor = valor.add(t.getValor());
            tarifa = tarifa.add(t.getTarifa());
        }
        Factura.InfoFactura.TotalConImpuestos.TotalImpuesto t = new Factura.InfoFactura.TotalConImpuestos.TotalImpuesto();
        t.setBaseImponible(baseImponible);
        t.setValor(valor);
        t.setTarifa(tarifa);
        t.setCodigo(codigo);
        t.setCodigoPorcentaje(codigoPorcentaje);

        totalImpuestoList.clear();
        // totalImpuestoList.add(t);
        Factura.InfoFactura.TotalConImpuestos totalConImpuestos = new Factura.InfoFactura.TotalConImpuestos();
        totalConImpuestos.getTotalImpuesto().add(t);
        System.out.println("size " + totalConImpuestos.getTotalImpuesto().size());
        return totalConImpuestos;
    }

    private TotalConImpuestos generaTotalesImpuestoNotaCredito(ComprobanteElectronico comprobanteElectronico) {
        Porcentajes porcentajes;
        TotalConImpuestos totalConImpuestos = new TotalConImpuestos();

        List<TotalImpuesto> totalImpuestoList = new ArrayList();

        String codigo = "";
        String codigoPorcentaje = "";

        BigDecimal baseImponible = BigDecimal.ZERO;
        BigDecimal valor = BigDecimal.ZERO;

        /// MODIFICAR PAARA CUANDO EL IVVA EXISTA O EXISTA ALGUN TIPO DE ICE
        for (Detalle d : comprobanteElectronico.getDetalles().getDetalle()) {
            porcentajes = porcentajeRepository.findByCodigoTarifaAndPorcentaje(d.getCodigoTarifa(), d.getIva());
            totalImpuestoList.add(Calculos.generaTotalImpuestoNotaCredito(d, porcentajes));
            // totalConImpuestos.getTotalImpuesto().add(Calculos.generaTotalImpuestoNotaCredito(d,
            // porcentajes));
        }

        for (TotalImpuesto t : totalImpuestoList) {
            codigo = t.getCodigo();
            codigoPorcentaje = t.getCodigoPorcentaje();
            baseImponible = baseImponible.add(t.getBaseImponible());
            valor = valor.add(t.getValor());
        }
        TotalImpuesto t = new TotalImpuesto();
        t.setBaseImponible(baseImponible);
        t.setValor(valor);
        t.setCodigo(codigo);
        t.setCodigoPorcentaje(codigoPorcentaje);

        totalImpuestoList.clear();
        // totalImpuestoList.add(t);

        totalConImpuestos.getTotalImpuesto().add(t);

        return totalConImpuestos;
    }

}
