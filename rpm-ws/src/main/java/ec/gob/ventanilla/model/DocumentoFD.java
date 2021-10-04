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
package ec.gob.ventanilla.model;

import java.util.List;

/**
 * Objeto para acceder informacion legible del certificado digital
 *
 * @author mfernandez
 */
public class DocumentoFD {
    private Boolean firmaValida;//validez de todas las firmas
    private Boolean documentoValido;//validez de todo el documento
    private List<Certificado> certificados;//si la lista de certificados se encuentra en null, el documento no contiene firmas
    private String error;

    public DocumentoFD() {
    }

    public DocumentoFD(Boolean firmaValida, Boolean documentoValido, List<Certificado> certificados, String error) {
        this.firmaValida = firmaValida;
        this.documentoValido = documentoValido;
        this.certificados = certificados;
        this.error = error;
    }

    public Boolean getFirmaValida() {
        return firmaValida;
    }

    public void setFirmaValida(Boolean firmaValida) {
        this.firmaValida = firmaValida;
    }

    public Boolean getDocumentoValido() {
        return documentoValido;
    }

    public void setDocumentoValido(Boolean documentoValido) {
        this.documentoValido = documentoValido;
    }

    public List<Certificado> getCertificados() {
        return certificados;
    }

    public void setCertificados(List<Certificado> certificados) {
        this.certificados = certificados;
    }

    public String getError() { return error; }

    public void setProcess(String error) { this.error = error; }


    @Override
    public String toString() {
        return "\tDocumento\n"
                + "\t[signValidate=" + firmaValida + "\n"
                + "\tdocValidate=" + documentoValido + "\n"
                + "\terror=" + error + "\n"
                + "\t]"
                + "\n----------";
    }

}
