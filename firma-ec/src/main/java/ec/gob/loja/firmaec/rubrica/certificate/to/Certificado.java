/*
 * Copyright (C) 2020 
 * Authors: Ricardo Arguello, Misael Fernández
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.*
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */
package ec.gob.loja.firmaec.rubrica.certificate.to;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Calendar;
import java.util.Date;

/**
 * Objeto para acceder informacion legible del certificado digital
 * 
 * @author mfernandez
 */
public class Certificado {

    private String informacionFirmante;//DInformación del firmante
    private String informacionEntidadCertificadora;//Información de la entidad certificadora
    @JsonFormat(shape = JsonFormat.Shape.NUMBER)
    private Calendar validoDesde;//certificado digital válido desde
    @JsonFormat(shape = JsonFormat.Shape.NUMBER)
    private Calendar validoHasta;//certificado digital válido hasta
    @JsonFormat(shape = JsonFormat.Shape.NUMBER)
    private Calendar generado;//fecha de firmar del documento
    private Calendar revocado;//fecha de revocado del certificado digital
    private Boolean validado;//validación del certificado en las fecha de vigencia
    private String clavesUso;//llaves de uso
    private DatosUsuario datosUsuario;
    private Boolean firmaVerificada;//Integridad Firma
    @JsonFormat(shape = JsonFormat.Shape.NUMBER)
    private Date docTimeStamp;//Estampa de tiempo
    private String motivoDocumento;//Razón del documento
    private String localizacionDocumento;//Localización del documento

    public Certificado() {
    }

    public Certificado(String informacionFirmante, String informacionEntidadCertificadora, Calendar validoDesde, Calendar validoHasta,
                       Calendar generado, Calendar revocado, Boolean validado, DatosUsuario datosUsuario) {
        this.informacionFirmante = informacionFirmante;
        this.informacionEntidadCertificadora = informacionEntidadCertificadora;
        this.validoDesde = validoDesde;
        this.validoHasta = validoHasta;
        this.generado = generado;
        this.revocado = revocado;
        this.validado = validado;
        this.datosUsuario = datosUsuario;
    }

    public String getInformacionFirmante() {
        return informacionFirmante;
    }

    public void setInformacionFirmante(String informacionFirmante) {
        this.informacionFirmante = informacionFirmante;
    }

    public String getInformacionEntidadCertificadora() {
        return informacionEntidadCertificadora;
    }

    public void setInformacionEntidadCertificadora(String informacionEntidadCertificadora) {
        this.informacionEntidadCertificadora = informacionEntidadCertificadora;
    }

    public Calendar getValidoDesde() {
        return validoDesde;
    }

    public void setValidoDesde(Calendar validoDesde) {
        this.validoDesde = validoDesde;
    }

    public Calendar getValidoHasta() {
        return validoHasta;
    }

    public void setValidoHasta(Calendar validoHasta) {
        this.validoHasta = validoHasta;
    }

    public Calendar getGenerado() {
        return generado;
    }

    public void setGenerado(Calendar generado) {
        this.generado = generado;
    }

    public Calendar getRevocado() {
        return revocado;
    }

    public void setRevocado(Calendar revocado) {
        this.revocado = revocado;
    }

    public Boolean getValidado() {
        return validado;
    }

    public void setValidado(Boolean validado) {
        this.validado = validado;
    }

    public String getClavesUso() {
        return clavesUso;
    }

    public void setClavesUso(String clavesUso) {
        this.clavesUso = clavesUso;
    }

    public DatosUsuario getDatosUsuario() {
        return datosUsuario;
    }

    public void setDatosUsuario(DatosUsuario datosUsuario) {
        this.datosUsuario = datosUsuario;
    }

    public Boolean getFirmaVerificada() {
        return firmaVerificada;
    }

    public void setFirmaVerificada(Boolean firmaVerificada) {
        this.firmaVerificada = firmaVerificada;
    }

    public Date getDocTimeStamp() {
        return docTimeStamp;
    }

    public void setDocTimeStamp(Date docTimeStamp) {
        this.docTimeStamp = docTimeStamp;
    }

    public String getMotivoDocumento() {
        return motivoDocumento;
    }

    public void setMotivoDocumento(String motivoDocumento) {
        this.motivoDocumento = motivoDocumento;
    }

    public String getLocalizacionDocumento() {
        return localizacionDocumento;
    }

    public void setLocalizacionDocumento(String localizacionDocumento) {
        this.localizacionDocumento = localizacionDocumento;
    }
}
