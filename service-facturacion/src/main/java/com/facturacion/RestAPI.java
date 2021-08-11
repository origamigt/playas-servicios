package com.facturacion;

public class RestAPI {

    public final static String baseURL = "/api/";

    /*Ambiente Controller*/
    public final static String ambienteFacturacion = baseURL + "ambienteFacturacion/";
    public final static String ambienteFacturacionGET = "ambientesFacturacionRegistrados/";
    public final static String ambienteFacturacionPOST = "guardarAmbienteFacturacion/";

    /*Comprobante Controller*/
    public final static String comprobanteFacturacion = baseURL + "comprobanteFacturacion/";
    public final static String comprobanteFacturacionGET = "comprobanteFacturacionRegistrados/";
    public final static String comprobanteFacturacionPOST = "guardarComprobanteFacturacion/";

    /*EntidadController*/
    public final static String entidadFacturacion = baseURL + "entidadFacturacion/";
    public final static String entidadFacturacionGET = "entidadFacturacionRegistrados/";
    public final static String entidadFacturacionPOST = "guardarEntidadFacturacion/";

    /*DocElectronicoController*/
    public final static String docElectronicoFacturacion = baseURL + "docElectronicoFacturacion/";
    public final static String docElectronicoFacturacionGET = "docElectronicoFacturacionRegistrados/";
    public final static String docElectronicoFacturacionPOST = "guardarDocElectronicoFacturacion/";

    /*FirmaController*/
    public final static String firmaFacturacion = baseURL + "firmaFacturacion/";
    public final static String firmaFacturacionGET = "firmaFacturacionRegistrados/";
    public final static String firmaFacturacionPOST = "guardarFirmaFacturacion/";

    /*FirmaDocElectronicoController*/
    public final static String firmaDocElectronicoFacturacion = baseURL + "firmaDocElectronicoFacturacion/";
    public final static String firmaDocElectronicoFacturacionGET = "firmaDocElectronicoFacturacionRegistrados/";
    public final static String firmaDocElectronicoFacturacionPOST = "guardarFirmaDocElectronicoFacturacion/";

    /*TipoEmisionController*/
    public final static String tipoEmisionFacturacion = baseURL + "tipoEmisionFacturacion/";
    public final static String tipoEmisionFacturacionGET = "tipoEmisionFacturacionRegistrados/";
    public final static String tipoEmisionFacturacionPOST = "guardarTipoEmisionFacturacion/";

    /*SecuenciaComprobanteController*/
    public final static String secuenciaComprobanteControllerFacturacion = baseURL + "secuenciaComprobanteFacturacion/";
    public final static String secuenciaComprobanteFacturacionGET = "secuenciaComprobanteFacturacionRegistrados/";
    public final static String secuenciaComprobanteFacturacionPOST = "guardarSecuenciaComprobanteControllerFacturacion/";

    /*TipoEmisionController*/
    public final static String tipoIdentificacionFacturacion = baseURL + "tipoIdentificacionFacturacion/";
    public final static String tipoIdentificacionFacturacionGET = "tipoIdentificacionFacturacionRegistrados/";
    public final static String tipoIdentificacionFacturacionPOST = "guardarTipoIdentificacionFacturacion/";

    /*FormasPagoController*/
    public final static String formasPagoControllerFacturacion = baseURL + "formasPagoFacturacion/";
    public final static String formasPagoControllerFacturacionGET = "formasPagFacturacionRegistrados/";
    public final static String formasPagoControllerFacturacionPOST = "guardarFormasPagoFacturacion/";

    /*PorcentajeIVAController*/
    public final static String porcentajeIVAFacturacion = baseURL + "porcentajeIVAFacturacion/";
    public final static String porcentajeIVAFacturacionGET = "porcentajeIVAFacturacionRegistrados/";
    public final static String porcentajeIVAFacturacionPOST = "guardarPorcentajeIVAFacturacion/";

    /*ImpuestoController*/
    public final static String impuestoFacturacion = baseURL + "impuestoFacturacion/";
    public final static String impuestoFacturacionGET = "impuestoFacturacionRegistrados/";
    public final static String impuestoFacturacionPOST = "guardarImpuestoFacturacion/";

    /*ArchivoController*/
    public final static String archivoFacturacion = baseURL + "archivoFacturacion/";
    public final static String archivoFacturacionGET = "archivoFacturacionRegistrados/";
    public final static String archivoFacturacionPOST = "guardarArchivoFacturacion/";
    /*DirectoriosController*/
    public final static String directorioFacturacion = baseURL + "directorioFacturacion/";
    public final static String directorioFacturacionGET = "directorioFacturacionRegistrados/";
    public final static String directorioFacturacionPOST = "guardarDirectorioFacturacion/";

    /*ProxyController*/
    public final static String proxyFacturacion = baseURL + "proxyFacturacion/";
    public final static String proxyFacturacionGET = "proxyFacturacionRegistrados/";
    public final static String proxyFacturacionPOST = "guardarProxyFacturacion/";

    /*ImpuestosAsignadosRetencionController     */
    public final static String impuestosAsignadosRetencionFacturacion = baseURL + "impuestosAsignadosRetencionFacturacion/";
    public final static String impuestosAsignadosRetencionFacturacionPOST = "guardarImpuestosAsignadosRetencionFacturacion/";

    /*Facturacion Electronica Controller*/
    public final static String facturacionElectronica = baseURL + "facturacionElectronica/";
    public final static String facturacionElectronicaGET = "consultaFacturasContribuyente/{identificacion}";
    public final static String facturacionElectronicaPOST = "enviarFacturacionElectronica/";
    public final static String reenviarfacturacionElectronicaPOST = "reenviarFacturacionElectronica/";
    public final static String renFacturacionElectronicaPOST = "enviarRenFacturacionElectronica/";
    public final static String reenviarRenFacturacionElectronicaPOST = "reenviarRenFacturacionElectronica/";
    public final static String enviarCorreoFacturacionElectronicaPOST = "enviarCorreoFacturacionElectronica/";

    public final static String notaCreditoElectronica = baseURL + "notaCreditoElectronica/";
    public final static String notaCreditoElectronicaGET = "{puntoEmision}/{rucEntidad}/{comprobanteCodigo}/{xml}";
    public final static String notaCreditoElectronicaPOST = "enviarNotaCreditoElectronica/";

    public final static String notaDebitoElectronicaPOST = "enviarNotaDebitoElectronica/";
    public final static String comprobanteRetencionElectronicaPOST = "enviarComprobanteRetencionElectronica/";

}
