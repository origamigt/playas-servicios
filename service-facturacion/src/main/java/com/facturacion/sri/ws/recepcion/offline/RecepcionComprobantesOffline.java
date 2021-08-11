package com.facturacion.sri.ws.recepcion.offline;

import com.facturacion.entites.RespuestaSolicitud;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.ws.RequestWrapper;
import javax.xml.ws.ResponseWrapper;
import com.facturacion.sri.ws.recepcion.ObjectFactory;

@WebService(name="RecepcionComprobantesOffline", targetNamespace="http://ec.gob.sri.ws.recepcion")
@XmlSeeAlso({ObjectFactory.class})
public abstract interface RecepcionComprobantesOffline
{
  @WebMethod
  @WebResult(name="RespuestaRecepcionComprobante", targetNamespace="")
  @RequestWrapper(localName="validarComprobante", targetNamespace="http://ec.gob.sri.ws.recepcion", className="com.facturacion.sri.model.ws.ValidarComprobante")
  @ResponseWrapper(localName="validarComprobanteResponse", targetNamespace="http://ec.gob.sri.ws.recepcion", className="com..facturacion.sri.model.ws.ValidarComprobanteResponse")
  public abstract RespuestaSolicitud validarComprobante(@WebParam(name="xml", targetNamespace="") byte[] paramArrayOfByte);
}
