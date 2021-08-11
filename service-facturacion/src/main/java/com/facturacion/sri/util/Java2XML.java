package com.facturacion.sri.util;


import com.facturacion.sri.model.factura.Factura;
import com.facturacion.sri.model.notacredito.NotaCredito;
import com.facturacion.sri.model.notadebito.NotaDebito;
import com.facturacion.sri.model.retencion.ComprobanteRetencion;

import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

public class Java2XML {


    public static Boolean xmlArchivoFactura(Factura comprobante, String pathArchivoSalida) {

        try {
            JAXBContext context = JAXBContext.newInstance(Factura.class);
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty("jaxb.encoding", "UTF-8");
            marshaller.setProperty(Marshaller.JAXB_FRAGMENT, Boolean.FALSE);
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            OutputStreamWriter out = new OutputStreamWriter(byteArrayOutputStream, StandardCharsets.UTF_8);
            marshaller.marshal(comprobante, out);
            OutputStream outputStream = new FileOutputStream(pathArchivoSalida);
            byteArrayOutputStream.writeTo(outputStream);
            byteArrayOutputStream.close();
            outputStream.close();
        } catch (Exception ex) {
            Logger.getLogger(Java2XML.class.getName()).log(Level.SEVERE, null, ex);
            return Boolean.FALSE;
        }
        return Boolean.TRUE;
    }

    public static Boolean xmlArchivoNotaDeCredito(NotaCredito comprobante, String pathArchivoSalida) {
        try {
            JAXBContext context = JAXBContext.newInstance(NotaCredito.class);
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty("jaxb.encoding", "UTF-8");
            marshaller.setProperty(Marshaller.JAXB_FRAGMENT, Boolean.FALSE);
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            OutputStreamWriter out = new OutputStreamWriter(new FileOutputStream(pathArchivoSalida), StandardCharsets.UTF_8);
            marshaller.marshal(comprobante, out);
        } catch (Exception ex) {
            Logger.getLogger(Java2XML.class.getName()).log(Level.SEVERE, null, ex);
            return Boolean.FALSE;
        }
        return Boolean.TRUE;
    }


    public static Boolean xmlArchivoNotaDebito(NotaDebito comprobante, String pathArchivoSalida) {
        try {
            JAXBContext context = JAXBContext.newInstance(NotaDebito.class);
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty("jaxb.encoding", "UTF-8");
            marshaller.setProperty(Marshaller.JAXB_FRAGMENT, Boolean.FALSE);
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            OutputStreamWriter out = new OutputStreamWriter(new FileOutputStream(pathArchivoSalida), StandardCharsets.UTF_8);
            marshaller.marshal(comprobante, out);
        } catch (Exception ex) {
            Logger.getLogger(Java2XML.class.getName()).log(Level.SEVERE, null, ex);
            return Boolean.FALSE;
        }
        return Boolean.TRUE;
    }

    public static Boolean xmlArchivoComprobanteRetencion(ComprobanteRetencion comprobante, String pathArchivoSalida) {
        String respuesta = null;
        try {
            JAXBContext context = JAXBContext.newInstance(ComprobanteRetencion.class);
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty("jaxb.encoding", "UTF-8");
            marshaller.setProperty(Marshaller.JAXB_FRAGMENT, Boolean.FALSE);
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            OutputStreamWriter out = new OutputStreamWriter(new FileOutputStream(pathArchivoSalida), StandardCharsets.UTF_8);
            marshaller.marshal(comprobante, out);
        } catch (Exception ex) {
            Logger.getLogger(Java2XML.class.getName()).log(Level.SEVERE, null, ex);
            return Boolean.FALSE;
        }
        return Boolean.TRUE;
    }


}
