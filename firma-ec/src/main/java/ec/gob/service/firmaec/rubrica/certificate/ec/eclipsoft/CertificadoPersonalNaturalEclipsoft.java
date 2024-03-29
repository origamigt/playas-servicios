/* 
 * AppsHandler © 2021
 * development@appshandler.com
 * http://www.appshandler.com
 */
package ec.gob.service.firmaec.rubrica.certificate.ec.eclipsoft;

import java.security.cert.X509Certificate;

import ec.gob.service.firmaec.rubrica.certificate.ec.CertificadoPersonaNatural;

/**
 * @author Edison Lomas Almeida
 */
public class CertificadoPersonalNaturalEclipsoft extends CertificadoEclipsoft implements CertificadoPersonaNatural {

	public CertificadoPersonalNaturalEclipsoft(X509Certificate certificado) {
		super(certificado);
	}

	@Override
	public String getCedulaPasaporte() {
		return obtenerExtension(OID_CEDULA_PASAPORTE);
	}

	@Override
	public String getNombres() {
		return obtenerExtension(OID_NOMBRES);
	}

	@Override
	public String getPrimerApellido() {
		return obtenerExtension(OID_APELLIDO_1);
	}

	@Override
	public String getSegundoApellido() {
		return obtenerExtension(OID_APELLIDO_2);
	}

	@Override
	public String getDireccion() {
		return obtenerExtension(OID_DIRECCION);
	}

	@Override
	public String getTelefono() {
		return obtenerExtension(OID_TELEFONO);
	}

	@Override
	public String getCiudad() {
		return obtenerExtension(OID_CIUDAD);
	}

	@Override
	public String getPais() {
		return obtenerExtension(OID_PAIS);
	}

	@Override
	public String getRuc() {
		return obtenerExtension(OID_RUC);
	}

}
