package com.facturacion.sri.ws.aut.offline;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.ws.RequestWrapper;
import javax.xml.ws.ResponseWrapper;

import com.facturacion.entites.RespuestaComprobante;
import com.facturacion.sri.model.autorizacion.RespuestaLote;
import com.facturacion.sri.ws.aut.ObjectFactory;

@WebService(name = "AutorizacionComprobantesOffline", targetNamespace = "http://ec.gob.sri.ws.autorizacion")
@XmlSeeAlso({ ObjectFactory.class })
public abstract interface AutorizacionComprobantesOffline {
	@WebMethod
	@WebResult(name = "RespuestaAutorizacionComprobante", targetNamespace = "")
	@RequestWrapper(localName = "autorizacionComprobante", targetNamespace = "http://ec.gob.sri.ws.autorizacion", className = "com.facturacion.sri.model.autorizacion.AutorizacionComprobante")
	@ResponseWrapper(localName = "autorizacionComprobanteResponse", targetNamespace = "http://ec.gob.sri.ws.autorizacion", className = "com.facturacion.sri.ws.aut.AutorizacionComprobanteResponse")
	public abstract RespuestaComprobante autorizacionComprobante(
			@WebParam(name = "claveAccesoComprobante", targetNamespace = "") String paramString);

	@WebMethod
	@WebResult(name = "RespuestaAutorizacionLote", targetNamespace = "")
	@RequestWrapper(localName = "autorizacionComprobanteLote", targetNamespace = "http://ec.gob.sri.ws.autorizacion", className = "com.facturacion.sri.model.autorizacion.AutorizacionComprobanteLote")
	@ResponseWrapper(localName = "autorizacionComprobanteLoteResponse", targetNamespace = "http://ec.gob.sri.ws.autorizacion", className = "com.facturacion.sri.ws.aut.AutorizacionComprobanteLoteResponse")
	public abstract RespuestaLote autorizacionComprobanteLote(
			@WebParam(name = "claveAccesoLote", targetNamespace = "") String paramString);
}
