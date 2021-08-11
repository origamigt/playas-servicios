package com.facturacion.sri.logic;

import com.facturacion.entites.RespuestaSolicitud;
import com.facturacion.entites.RespuestaComprobante;
import com.facturacion.sri.util.CertificadosSSL;
import com.facturacion.sri.util.DocumentosUtil;
import com.facturacion.sri.ws.recepcion.offline.RecepcionComprobantesOffline;
import com.facturacion.sri.ws.recepcion.offline.RecepcionComprobantesOfflineService;
import com.facturacion.sri.ws.recepcion.online.RecepcionComprobantes;
import com.facturacion.sri.ws.recepcion.online.RecepcionComprobantesService;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import javax.xml.namespace.QName;

public class EnvioComprobantesWs {

    private static RecepcionComprobantesService service;
    private static RecepcionComprobantesOfflineService serviceOffLine;

    public EnvioComprobantesWs(String wsdlLocation, Boolean isOnline) throws MalformedURLException {

        URL url = new URL(wsdlLocation);
        QName qname = new QName("http://ec.gob.sri.ws.recepcion",
                isOnline ? "RecepcionComprobantesService" : "RecepcionComprobantesOfflineService");
        if (isOnline) {
            service = new RecepcionComprobantesService(url, qname);
        } else {
            serviceOffLine = new RecepcionComprobantesOfflineService(url, qname);
        }
    }

    public RespuestaSolicitud enviarComprobante(File xmlFile, Boolean isOnline) throws Throwable {
        RespuestaSolicitud response = null;
        try {
            if (isOnline) {
                RecepcionComprobantes portOnline = service.getRecepcionComprobantesPort();
                response = portOnline.validarComprobante(DocumentosUtil.convertirArchivoAByteArray(xmlFile));
            } else {
                RecepcionComprobantesOffline portOffLine = serviceOffLine.getRecepcionComprobantesOfflinePort();
                response = portOffLine.validarComprobante(DocumentosUtil.convertirArchivoAByteArray(xmlFile));
            }
        } catch (IOException e) {
            throw e;
        }
        return response;
    }

    public static RespuestaSolicitud enviarArchivoXMLSRI(String xmlfirmado, String Recepcion, Boolean isOnline)
            throws Throwable {
        CertificadosSSL.instalarCertificados();
        // Con la URL del WSDL especificas si se debe conectar a los servicios de
        // pruebas o producción
        EnvioComprobantesWs ec = new EnvioComprobantesWs(Recepcion, isOnline);
        RespuestaSolicitud response;
        response = ec.enviarComprobante(new File(xmlfirmado), isOnline);
        return response;
    }

    public static RespuestaComprobante autorizarArchivoXMLSRI(String claveacceso, String OutAutorizados,
            String OutRechazados, String autorizacionWsdl, Boolean isOnline) throws Exception {
        CertificadosSSL.instalarCertificados();
        System.out.println("claveacceso " + claveacceso);
        System.out.println("OutAutorizados " + OutAutorizados);
        System.out.println("OutRechazados " + OutRechazados);
        System.out.println("autorizacionWsdl " + autorizacionWsdl);
        AutorizacionComprobantesWs ec = new AutorizacionComprobantesWs(autorizacionWsdl, isOnline);
        if (isOnline) {
            System.out.println("isOnline: " + isOnline);
            return ec.autorizarComprobante(claveacceso, OutAutorizados);
        } else {
            return ec.autorizarComprobanteOffline(claveacceso, OutAutorizados);
        }
    }

}
