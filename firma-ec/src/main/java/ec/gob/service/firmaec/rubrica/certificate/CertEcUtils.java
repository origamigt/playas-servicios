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
package ec.gob.service.firmaec.rubrica.certificate;

import ec.gob.service.firmaec.rubrica.certificate.ec.bce.BceSubCaCert20112021;
import ec.gob.service.firmaec.rubrica.certificate.ec.bce.BceSubCaCert20192029;
import ec.gob.service.firmaec.rubrica.certificate.ec.bce.CertificadoBancoCentral;
import ec.gob.service.firmaec.rubrica.certificate.ec.bce.CertificadoBancoCentralFactory;
import ec.gob.service.firmaec.rubrica.exceptions.EntidadCertificadoraNoValidaException;
import ec.gob.service.firmaec.rubrica.certificate.ec.CertificadoFuncionarioPublico;
import ec.gob.service.firmaec.rubrica.certificate.ec.CertificadoMiembroEmpresa;
import ec.gob.service.firmaec.rubrica.certificate.ec.CertificadoPersonaJuridica;
import ec.gob.service.firmaec.rubrica.certificate.ec.CertificadoPersonaNatural;
import ec.gob.service.firmaec.rubrica.certificate.ec.CertificadoRepresentanteLegal;
import ec.gob.service.firmaec.rubrica.certificate.ec.CertificadoSelladoTiempo;
import ec.gob.service.firmaec.rubrica.certificate.ec.anfac.AnfAc18332SubCaCert20162032;
import ec.gob.service.firmaec.rubrica.certificate.ec.anfac.AnfAc37442SubCaCert20192029;
import ec.gob.service.firmaec.rubrica.certificate.ec.anfac.CertificadoAnfAc18332;
import ec.gob.service.firmaec.rubrica.certificate.ec.anfac.CertificadoAnfAc18332Factory;
import ec.gob.service.firmaec.rubrica.certificate.ec.anfac.CertificadoAnfAc37442;
import ec.gob.service.firmaec.rubrica.certificate.ec.anfac.CertificadoAnfAc37442Factory;
import ec.gob.service.firmaec.rubrica.certificate.ec.cj.CertificadoConsejoJudicatura;
import ec.gob.service.firmaec.rubrica.certificate.ec.cj.CertificadoConsejoJudicaturaDataFactory;
import ec.gob.service.firmaec.rubrica.certificate.ec.cj.CertificadoDepartamentoEmpresaConsejoJudicatura;
import ec.gob.service.firmaec.rubrica.certificate.ec.cj.CertificadoEmpresaConsejoJudicatura;
import ec.gob.service.firmaec.rubrica.certificate.ec.cj.CertificadoMiembroEmpresaConsejoJudicatura;
import ec.gob.service.firmaec.rubrica.certificate.ec.cj.CertificadoPersonaJuridicaPrivadaConsejoJudicatura;
import ec.gob.service.firmaec.rubrica.certificate.ec.cj.CertificadoPersonaJuridicaPublicaConsejoJudicatura;
import ec.gob.service.firmaec.rubrica.certificate.ec.cj.CertificadoPersonaNaturalConsejoJudicatura;
import ec.gob.service.firmaec.rubrica.certificate.ec.cj.ConsejoJudicaturaSubCaCert;
import ec.gob.service.firmaec.rubrica.certificate.ec.digercic.CertificadoDigercic;
import ec.gob.service.firmaec.rubrica.certificate.ec.digercic.CertificadoDigercicFactory;
import ec.gob.service.firmaec.rubrica.certificate.ec.digercic.DigercicSubCaCert20212031;
import ec.gob.service.firmaec.rubrica.certificate.ec.eclipsoft.CertificadoEclipsoft;
import ec.gob.service.firmaec.rubrica.certificate.ec.eclipsoft.CertificadoEclipsoftDataFactory;
import ec.gob.service.firmaec.rubrica.certificate.ec.eclipsoft.CertificadoMiembroEmpresaEclipsoft;
import ec.gob.service.firmaec.rubrica.certificate.ec.eclipsoft.CertificadoPersonaJuridicaPrivadaEclipsoft;
import ec.gob.service.firmaec.rubrica.certificate.ec.eclipsoft.CertificadoPersonalNaturalEclipsoft;
import ec.gob.service.firmaec.rubrica.certificate.ec.eclipsoft.CertificadoRepresentanteLegalEclipsoft;
import ec.gob.service.firmaec.rubrica.certificate.ec.securitydata.CertificadoSecurityData;
import ec.gob.service.firmaec.rubrica.certificate.ec.securitydata.CertificadoSecurityDataFactory;
import ec.gob.service.firmaec.rubrica.certificate.ec.securitydata.SecurityDataSubCaCert20112026;
import ec.gob.service.firmaec.rubrica.certificate.ec.securitydata.SecurityDataSubCaCert20192031;
import ec.gob.service.firmaec.rubrica.certificate.ec.securitydata.SecurityDataSubCaCert20202039;
import ec.gob.service.firmaec.rubrica.certificate.ec.uanataca.CertificadoMiembroEmpresaUanataca;
import ec.gob.service.firmaec.rubrica.certificate.ec.uanataca.CertificadoPersonaJuridicaPrivadaUanataca;
import ec.gob.service.firmaec.rubrica.certificate.ec.uanataca.CertificadoPersonaNaturalUanataca;
import ec.gob.service.firmaec.rubrica.certificate.ec.uanataca.CertificadoRepresentanteLegalUanataca;
import ec.gob.service.firmaec.rubrica.certificate.ec.uanataca.CertificadoUanataca;
import ec.gob.service.firmaec.rubrica.certificate.ec.uanataca.CertificadoUanatacaDataFactory;
import ec.gob.service.firmaec.rubrica.certificate.ec.uanataca.UanatacaSubCaCert0120162029;
import ec.gob.service.firmaec.rubrica.certificate.ec.uanataca.UanatacaSubCaCert0220162029;
import ec.gob.service.firmaec.rubrica.certificate.to.DatosUsuario;
import ec.gob.service.firmaec.rubrica.utils.Utils;

import java.security.cert.X509Certificate;

/**
 * Validar diferentes certificados digitales acreditados por ARCOTEL
 *
 * @author mfernandez
 */
public class CertEcUtils {

    private static final String UANATACA_NAME = "UANATACA S.A.";

    public static X509Certificate getRootCertificate(X509Certificate certificado) throws EntidadCertificadoraNoValidaException {
        String entidadCertStr = getNombreCA(certificado);

        switch (entidadCertStr) {
            case "Banco Central del Ecuador": {
                try {
                    if (Utils.verifySignature(certificado, new BceSubCaCert20112021())) {
                        System.out.println("BceSubCaCert 2011-2021");
                        return new BceSubCaCert20112021();
                    }
                    if (Utils.verifySignature(certificado, new BceSubCaCert20192029())) {
                        System.out.println("BceSubCaCert 2019-2029");
                        return new BceSubCaCert20192029();
                    }
                    return null;
                } catch (java.security.InvalidKeyException ex) {
                    //TODO
                }
            }
            case "Security Data": {
                try {
                    if (Utils.verifySignature(certificado, new SecurityDataSubCaCert20112026())) {
                        System.out.println("SecurityDataSubCaCert");
                        return new SecurityDataSubCaCert20112026();
                    }
                    if (Utils.verifySignature(certificado, new SecurityDataSubCaCert20192031())) {
                        System.out.println("SecurityDataSubCaCert 2019-2031");
                        return new SecurityDataSubCaCert20192031();
                    }
                    if (Utils.verifySignature(certificado, new SecurityDataSubCaCert20202039())) {
                        System.out.println("SecurityDataSubCaCert 2020-2032");
                        return new SecurityDataSubCaCert20202039();
                    }
                    return null;
                } catch (java.security.InvalidKeyException ex) {
                    //TODO
                }
            }
            case "Consejo de la Judicatura":
                return new ConsejoJudicaturaSubCaCert();
            case "Anf AC":
                try {
                if (Utils.verifySignature(certificado, new AnfAc18332SubCaCert20162032())) {
                    System.out.println("Anf 2016-2032");
                    return new AnfAc18332SubCaCert20162032();
                }
                if (Utils.verifySignature(certificado, new AnfAc37442SubCaCert20192029())) {
                    System.out.println("Anf 2019-2029");
                    return new AnfAc37442SubCaCert20192029();
                }
                return null;
            } catch (java.security.InvalidKeyException ex) {
                //TODO
            }
            case "Dirección General de Registro Civil, Identificación y Cedulación": {
                return new DigercicSubCaCert20212031();
            }
            case UANATACA_NAME:
                try {
                if (Utils.verifySignature(certificado, new UanatacaSubCaCert0120162029())) {
                    System.out.println("Uanataca 2016-2029");
                    return new UanatacaSubCaCert0120162029();
                }
                if (Utils.verifySignature(certificado, new UanatacaSubCaCert0220162029())) {
                    System.out.println("Uanataca 2016-2029");
                    return new UanatacaSubCaCert0220162029();
                }
                return null;
            } catch (java.security.InvalidKeyException ex) {
                //TODO
            }
            default:
                throw new EntidadCertificadoraNoValidaException("Entidad Certificadora no reconocida");
        }
    }

    //TODO poner los nombres como constantes
    public static String getNombreCA(X509Certificate certificado) {
        if (certificado.getIssuerX500Principal().getName().toUpperCase().contains("BANCO CENTRAL DEL ECUADOR")) {
            return "Banco Central del Ecuador";
        }
        if (certificado.getIssuerX500Principal().getName().toUpperCase().contains("SECURITY DATA")) {
            return "Security Data";
        }
        if (certificado.getIssuerX500Principal().getName().toUpperCase().contains("CONSEJO DE LA JUDICATURA")) {
            return "Consejo de la Judicatura";
        }
        if (certificado.getIssuerX500Principal().getName().toUpperCase().contains("ANF")) {
            return "Anf AC";
        }
        if (certificado.getIssuerX500Principal().getName().toUpperCase().contains("DIRECCIÓN GENERAL DE REGISTRO CIVIL")) {
            return "Dirección General de Registro Civil, Identificación y Cedulación";
        }
        if (certificado.getIssuerX500Principal().getName().toUpperCase().contains(UANATACA_NAME)) {
            return UANATACA_NAME;
        }
        return "Entidad no reconocidad " + certificado.getIssuerX500Principal().getName();
    }

    //TODO poner los nombres como constantes
    public static DatosUsuario getDatosUsuarios(X509Certificate certificado) {
        DatosUsuario datosUsuario = new DatosUsuario();
        datosUsuario.setSelladoTiempo(false);
        if (CertificadoBancoCentralFactory.esCertificadoDelBancoCentral(certificado)) {
            CertificadoBancoCentral certificadoBancoCentral = CertificadoBancoCentralFactory.construir(certificado);
            if (certificadoBancoCentral instanceof CertificadoFuncionarioPublico) {
                CertificadoFuncionarioPublico certificadoFuncionarioPublico = (CertificadoFuncionarioPublico) certificadoBancoCentral;
                datosUsuario.setCedula(certificadoFuncionarioPublico.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoFuncionarioPublico.getNombres());
                datosUsuario.setApellido(certificadoFuncionarioPublico.getPrimerApellido() + " "
                        + certificadoFuncionarioPublico.getSegundoApellido());
                datosUsuario.setInstitucion(certificadoFuncionarioPublico.getInstitucion());
                datosUsuario.setCargo(certificadoFuncionarioPublico.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoBancoCentral instanceof CertificadoMiembroEmpresa) {
                CertificadoMiembroEmpresa certificadoMiembroEmpresa = (CertificadoMiembroEmpresa) certificadoBancoCentral;
                datosUsuario.setCedula(certificadoMiembroEmpresa.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoMiembroEmpresa.getNombres());
                datosUsuario.setApellido(certificadoMiembroEmpresa.getPrimerApellido() + " "
                        + certificadoMiembroEmpresa.getSegundoApellido());
                datosUsuario.setCargo(certificadoMiembroEmpresa.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoBancoCentral instanceof CertificadoPersonaJuridica) {
                CertificadoPersonaJuridica certificadoPersonaJuridica = (CertificadoPersonaJuridica) certificadoBancoCentral;
                datosUsuario.setCedula(certificadoPersonaJuridica.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoPersonaJuridica.getNombres());
                datosUsuario.setApellido(certificadoPersonaJuridica.getPrimerApellido() + " "
                        + certificadoPersonaJuridica.getSegundoApellido());
                datosUsuario.setCargo(certificadoPersonaJuridica.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoBancoCentral instanceof CertificadoPersonaNatural) {
                CertificadoPersonaNatural certificadoPersonaNatural = (CertificadoPersonaNatural) certificadoBancoCentral;
                datosUsuario.setCedula(certificadoPersonaNatural.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoPersonaNatural.getNombres());
                datosUsuario.setApellido(certificadoPersonaNatural.getPrimerApellido() + " "
                        + certificadoPersonaNatural.getSegundoApellido());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoBancoCentral instanceof CertificadoRepresentanteLegal) {
                CertificadoRepresentanteLegal certificadoRepresentanteLegal = (CertificadoRepresentanteLegal) certificadoBancoCentral;
                datosUsuario.setCedula(certificadoRepresentanteLegal.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoRepresentanteLegal.getNombres());
                datosUsuario.setApellido(certificadoRepresentanteLegal.getPrimerApellido() + " "
                        + certificadoRepresentanteLegal.getSegundoApellido());
                datosUsuario.setCargo(certificadoRepresentanteLegal.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoBancoCentral instanceof CertificadoSelladoTiempo) {
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            datosUsuario.setEntidadCertificadora("Banco Central del Ecuador");
            datosUsuario.setCertificadoDigitalValido(true);
            return datosUsuario;
        }

        if (CertificadoConsejoJudicaturaDataFactory.esCertificadoDelConsejoJudicatura(certificado)) {
            CertificadoConsejoJudicatura certificadoConsejoJudicatura = CertificadoConsejoJudicaturaDataFactory.construir(certificado);
            if (certificadoConsejoJudicatura instanceof CertificadoDepartamentoEmpresaConsejoJudicatura) {
                CertificadoDepartamentoEmpresaConsejoJudicatura certificadoDepartamentoEmpresaConsejoJudicatura;
                certificadoDepartamentoEmpresaConsejoJudicatura = (CertificadoDepartamentoEmpresaConsejoJudicatura) certificadoConsejoJudicatura;

                datosUsuario.setCedula(certificadoDepartamentoEmpresaConsejoJudicatura.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoDepartamentoEmpresaConsejoJudicatura.getNombres());
                datosUsuario.setApellido(certificadoDepartamentoEmpresaConsejoJudicatura.getPrimerApellido() + " "
                        + certificadoDepartamentoEmpresaConsejoJudicatura.getSegundoApellido());
                datosUsuario.setCargo(certificadoDepartamentoEmpresaConsejoJudicatura.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoConsejoJudicatura instanceof CertificadoEmpresaConsejoJudicatura) {
                CertificadoEmpresaConsejoJudicatura certificadoEmpresaConsejoJudicatura = (CertificadoEmpresaConsejoJudicatura) certificadoConsejoJudicatura;
                datosUsuario.setCedula(certificadoEmpresaConsejoJudicatura.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoEmpresaConsejoJudicatura.getNombres());
                datosUsuario.setApellido(certificadoEmpresaConsejoJudicatura.getPrimerApellido() + " "
                        + certificadoEmpresaConsejoJudicatura.getSegundoApellido());
                datosUsuario.setCargo(certificadoEmpresaConsejoJudicatura.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoConsejoJudicatura instanceof CertificadoMiembroEmpresaConsejoJudicatura) {
                CertificadoMiembroEmpresaConsejoJudicatura certificadoMiembroEmpresaConsejoJudicatura = (CertificadoMiembroEmpresaConsejoJudicatura) certificadoConsejoJudicatura;
                datosUsuario.setCedula(certificadoMiembroEmpresaConsejoJudicatura.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoMiembroEmpresaConsejoJudicatura.getNombres());
                datosUsuario.setApellido(certificadoMiembroEmpresaConsejoJudicatura.getPrimerApellido() + " "
                        + certificadoMiembroEmpresaConsejoJudicatura.getSegundoApellido());
                datosUsuario.setCargo(certificadoMiembroEmpresaConsejoJudicatura.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoConsejoJudicatura instanceof CertificadoPersonaJuridicaPrivadaConsejoJudicatura) {
                CertificadoPersonaJuridicaPrivadaConsejoJudicatura certificadoPersonaJuridicaPrivadaConsejoJudicatura = (CertificadoPersonaJuridicaPrivadaConsejoJudicatura) certificadoConsejoJudicatura;
                datosUsuario.setCedula(certificadoPersonaJuridicaPrivadaConsejoJudicatura.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoPersonaJuridicaPrivadaConsejoJudicatura.getNombres());
                datosUsuario.setApellido(certificadoPersonaJuridicaPrivadaConsejoJudicatura.getPrimerApellido() + " "
                        + certificadoPersonaJuridicaPrivadaConsejoJudicatura.getSegundoApellido());
                datosUsuario.setCargo(datosUsuario.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoConsejoJudicatura instanceof CertificadoPersonaJuridicaPublicaConsejoJudicatura) {
                CertificadoPersonaJuridicaPublicaConsejoJudicatura certificadoPersonaJuridicaPublicaConsejoJudicatura = (CertificadoPersonaJuridicaPublicaConsejoJudicatura) certificadoConsejoJudicatura;
                datosUsuario.setCedula(certificadoPersonaJuridicaPublicaConsejoJudicatura.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoPersonaJuridicaPublicaConsejoJudicatura.getNombres());
                datosUsuario.setApellido(certificadoPersonaJuridicaPublicaConsejoJudicatura.getPrimerApellido() + " "
                        + certificadoPersonaJuridicaPublicaConsejoJudicatura.getSegundoApellido());
                datosUsuario.setCargo(certificadoPersonaJuridicaPublicaConsejoJudicatura.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoConsejoJudicatura instanceof CertificadoPersonaNaturalConsejoJudicatura) {
                CertificadoPersonaNaturalConsejoJudicatura certificadoPersonaNaturalConsejoJudicatura = (CertificadoPersonaNaturalConsejoJudicatura) certificadoConsejoJudicatura;
                datosUsuario.setCedula(certificadoPersonaNaturalConsejoJudicatura.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoPersonaNaturalConsejoJudicatura.getNombres());
                datosUsuario.setApellido(certificadoPersonaNaturalConsejoJudicatura.getPrimerApellido() + " "
                        + certificadoPersonaNaturalConsejoJudicatura.getSegundoApellido());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoConsejoJudicatura instanceof CertificadoSelladoTiempo) {
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            datosUsuario.setEntidadCertificadora("Consejo de la Judicatura");
            datosUsuario.setCertificadoDigitalValido(true);
            return datosUsuario;
        }

        if (CertificadoSecurityDataFactory.esCertificadoDeSecurityData(certificado)) {
            CertificadoSecurityData certificadoSecurityData = CertificadoSecurityDataFactory.construir(certificado);
            if (certificadoSecurityData instanceof CertificadoFuncionarioPublico) {
                CertificadoFuncionarioPublico certificadoFuncionarioPublico = (CertificadoFuncionarioPublico) certificadoSecurityData;
                datosUsuario.setCedula(certificadoFuncionarioPublico.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoFuncionarioPublico.getNombres());
                datosUsuario.setApellido(certificadoFuncionarioPublico.getPrimerApellido() + " "
                        + certificadoFuncionarioPublico.getSegundoApellido());
                datosUsuario.setCargo(certificadoFuncionarioPublico.getCargo());
                datosUsuario.setInstitucion(certificadoFuncionarioPublico.getInstitucion());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoSecurityData instanceof CertificadoPersonaJuridica) {
                CertificadoPersonaJuridica certificadoPersonaJuridica = (CertificadoPersonaJuridica) certificadoSecurityData;
                datosUsuario.setCedula(certificadoPersonaJuridica.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoPersonaJuridica.getNombres());
                datosUsuario.setApellido(certificadoPersonaJuridica.getPrimerApellido() + " "
                        + certificadoPersonaJuridica.getSegundoApellido());
                datosUsuario.setCargo(certificadoPersonaJuridica.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }

            if (certificadoSecurityData instanceof CertificadoPersonaNatural) {
                CertificadoPersonaNatural certificadoPersonaNatural = (CertificadoPersonaNatural) certificadoSecurityData;
                datosUsuario.setCedula(certificadoPersonaNatural.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoPersonaNatural.getNombres());
                datosUsuario.setApellido(certificadoPersonaNatural.getPrimerApellido() + " "
                        + certificadoPersonaNatural.getSegundoApellido());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoSecurityData instanceof CertificadoSelladoTiempo) {
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            datosUsuario.setEntidadCertificadora("Security Data");
            datosUsuario.setCertificadoDigitalValido(true);
            return datosUsuario;
        }

        if (CertificadoAnfAc18332Factory.esCertificadoDeAnfAc18332(certificado)) {
            CertificadoAnfAc18332 certificadoAnfAc18332 = CertificadoAnfAc18332Factory.construir(certificado);
            if (certificadoAnfAc18332 instanceof CertificadoFuncionarioPublico) {
                CertificadoFuncionarioPublico certificadoFuncionarioPublico = (CertificadoFuncionarioPublico) certificadoAnfAc18332;

                datosUsuario.setCedula(certificadoFuncionarioPublico.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoFuncionarioPublico.getNombres());
                datosUsuario.setApellido(certificadoFuncionarioPublico.getPrimerApellido() + " "
                        + certificadoFuncionarioPublico.getSegundoApellido());
                datosUsuario.setCargo(certificadoFuncionarioPublico.getCargo());
                datosUsuario.setInstitucion(certificadoFuncionarioPublico.getInstitucion());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoAnfAc18332 instanceof CertificadoPersonaJuridica) {
                CertificadoPersonaJuridica certificadoPersonaJuridica = (CertificadoPersonaJuridica) certificadoAnfAc18332;
                datosUsuario.setCedula(certificadoPersonaJuridica.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoPersonaJuridica.getNombres());
                datosUsuario.setApellido(certificadoPersonaJuridica.getPrimerApellido() + " "
                        + certificadoPersonaJuridica.getSegundoApellido());
                datosUsuario.setCargo(certificadoPersonaJuridica.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }

            if (certificadoAnfAc18332 instanceof CertificadoPersonaNatural) {
                CertificadoPersonaNatural certificadoPersonaNatural = (CertificadoPersonaNatural) certificadoAnfAc18332;
                datosUsuario.setCedula(certificadoPersonaNatural.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoPersonaNatural.getNombres());
                datosUsuario.setApellido(certificadoPersonaNatural.getPrimerApellido() + " "
                        + certificadoPersonaNatural.getSegundoApellido());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoAnfAc18332 instanceof CertificadoSelladoTiempo) {
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            datosUsuario.setEntidadCertificadora("Anf AC");
            datosUsuario.setCertificadoDigitalValido(true);
            return datosUsuario;
        }

        if (CertificadoAnfAc37442Factory.esCertificadoDeAnfAc37442(certificado)) {
            CertificadoAnfAc37442 certificadoAnfAc37442 = CertificadoAnfAc37442Factory.construir(certificado);
            if (certificadoAnfAc37442 instanceof CertificadoFuncionarioPublico) {
                CertificadoFuncionarioPublico certificadoFuncionarioPublico = (CertificadoFuncionarioPublico) certificadoAnfAc37442;

                datosUsuario.setCedula(certificadoFuncionarioPublico.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoFuncionarioPublico.getNombres());
                datosUsuario.setApellido(certificadoFuncionarioPublico.getPrimerApellido() + " "
                        + certificadoFuncionarioPublico.getSegundoApellido());
                datosUsuario.setCargo(certificadoFuncionarioPublico.getCargo());
                datosUsuario.setInstitucion(certificadoFuncionarioPublico.getInstitucion());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoAnfAc37442 instanceof CertificadoPersonaJuridica) {
                CertificadoPersonaJuridica certificadoPersonaJuridica = (CertificadoPersonaJuridica) certificadoAnfAc37442;
                datosUsuario.setCedula(certificadoPersonaJuridica.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoPersonaJuridica.getNombres());
                datosUsuario.setApellido(certificadoPersonaJuridica.getPrimerApellido() + " "
                        + certificadoPersonaJuridica.getSegundoApellido());
                datosUsuario.setCargo(certificadoPersonaJuridica.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }

            if (certificadoAnfAc37442 instanceof CertificadoPersonaNatural) {
                CertificadoPersonaNatural certificadoPersonaNatural = (CertificadoPersonaNatural) certificadoAnfAc37442;
                datosUsuario.setCedula(certificadoPersonaNatural.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoPersonaNatural.getNombres());
                datosUsuario.setApellido(certificadoPersonaNatural.getPrimerApellido() + " "
                        + certificadoPersonaNatural.getSegundoApellido());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            if (certificadoAnfAc37442 instanceof CertificadoSelladoTiempo) {
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            datosUsuario.setEntidadCertificadora("Anf AC");
            datosUsuario.setCertificadoDigitalValido(true);
            return datosUsuario;
        }
        if (CertificadoDigercicFactory.esCertificadoDigercic(certificado)) {
            CertificadoDigercic certificadoDigercic = CertificadoDigercicFactory.construir(certificado);
            if (certificadoDigercic instanceof CertificadoPersonaNatural) {
                CertificadoPersonaNatural certificadoPersonaNatural = (CertificadoPersonaNatural) certificadoDigercic;

                datosUsuario.setCedula(certificadoPersonaNatural.getCedulaPasaporte());
                datosUsuario.setNombre(Utils.getCN(certificado));
                datosUsuario.setApellido("");
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            datosUsuario.setEntidadCertificadora("DIGERCIC");
            datosUsuario.setCertificadoDigitalValido(true);
            return datosUsuario;
        }
        if (CertificadoUanatacaDataFactory.esCertificadoUanataca(certificado)) {
            CertificadoUanataca certificadoUanataca = CertificadoUanatacaDataFactory.construir(certificado);
            if (certificadoUanataca instanceof CertificadoMiembroEmpresaUanataca) {
                CertificadoMiembroEmpresaUanataca certificadoMiembroEmpresaUanataca = (CertificadoMiembroEmpresaUanataca) certificadoUanataca;
                datosUsuario.setCedula(certificadoMiembroEmpresaUanataca.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoMiembroEmpresaUanataca.getNombres());
                datosUsuario.setApellido(certificadoMiembroEmpresaUanataca.getPrimerApellido() + " "
                        + certificadoMiembroEmpresaUanataca.getSegundoApellido());
                datosUsuario.setCargo(certificadoMiembroEmpresaUanataca.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            } else if (certificadoUanataca instanceof CertificadoPersonaJuridicaPrivadaUanataca) {
                CertificadoPersonaJuridicaPrivadaUanataca certificadoPersonaJuridicaUanataca = (CertificadoPersonaJuridicaPrivadaUanataca) certificadoUanataca;
                datosUsuario.setCedula(certificadoPersonaJuridicaUanataca.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoPersonaJuridicaUanataca.getNombres());
                datosUsuario.setApellido(certificadoPersonaJuridicaUanataca.getPrimerApellido() + " "
                        + certificadoPersonaJuridicaUanataca.getSegundoApellido());
                datosUsuario.setCargo(datosUsuario.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            } else if (certificadoUanataca instanceof CertificadoPersonaNaturalUanataca) {
                CertificadoPersonaNaturalUanataca certificadoPersonaNaturalU = (CertificadoPersonaNaturalUanataca) certificadoUanataca;
                datosUsuario.setCedula(certificadoPersonaNaturalU.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoPersonaNaturalU.getNombres());
                datosUsuario.setApellido(certificadoPersonaNaturalU.getPrimerApellido() + " "
                        + certificadoPersonaNaturalU.getSegundoApellido());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            } else if (certificadoUanataca instanceof CertificadoRepresentanteLegalUanataca) {
                CertificadoRepresentanteLegalUanataca certificadoRepresentanteLegalUanataca = (CertificadoRepresentanteLegalUanataca) certificadoUanataca;
                datosUsuario.setCedula(certificadoRepresentanteLegalUanataca.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoRepresentanteLegalUanataca.getNombres());
                datosUsuario.setApellido(certificadoRepresentanteLegalUanataca.getPrimerApellido() + " "
                        + certificadoRepresentanteLegalUanataca.getSegundoApellido());
                datosUsuario.setCargo(certificadoRepresentanteLegalUanataca.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            } else if (certificadoUanataca instanceof CertificadoSelladoTiempo) {
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            datosUsuario.setEntidadCertificadora("Uanataca Ecuador");
            datosUsuario.setCertificadoDigitalValido(true);
            return datosUsuario;
        }
        if (CertificadoEclipsoftDataFactory.esCertificadoEclipsoft(certificado)) {
            CertificadoEclipsoft certificadoEclipsoft = CertificadoEclipsoftDataFactory.construir(certificado);
            if (certificadoEclipsoft instanceof CertificadoPersonalNaturalEclipsoft) {
                CertificadoPersonalNaturalEclipsoft certificadoPersonalNaturalEclipsoft = (CertificadoPersonalNaturalEclipsoft) certificadoEclipsoft;
                datosUsuario.setCedula(certificadoPersonalNaturalEclipsoft.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoPersonalNaturalEclipsoft.getNombres());
                datosUsuario.setApellido(certificadoPersonalNaturalEclipsoft.getPrimerApellido() + " " + certificadoPersonalNaturalEclipsoft.getSegundoApellido());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            } else if (certificadoEclipsoft instanceof CertificadoMiembroEmpresaEclipsoft) {
                CertificadoMiembroEmpresaEclipsoft certificadoMiembroEmpresaEclipsoft = (CertificadoMiembroEmpresaEclipsoft) certificadoEclipsoft;
                datosUsuario.setCedula(certificadoMiembroEmpresaEclipsoft.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoMiembroEmpresaEclipsoft.getNombres());
                datosUsuario.setApellido(certificadoMiembroEmpresaEclipsoft.getPrimerApellido() + " " + certificadoMiembroEmpresaEclipsoft.getSegundoApellido());
                datosUsuario.setCargo(certificadoMiembroEmpresaEclipsoft.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            } else if (certificadoEclipsoft instanceof CertificadoRepresentanteLegalEclipsoft) {
                CertificadoRepresentanteLegalEclipsoft certificadoRepresentanteLegalEclipsoft = (CertificadoRepresentanteLegalEclipsoft) certificadoEclipsoft;
                datosUsuario.setCedula(certificadoRepresentanteLegalEclipsoft.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoRepresentanteLegalEclipsoft.getNombres());
                datosUsuario.setApellido(certificadoRepresentanteLegalEclipsoft.getPrimerApellido() + " " + certificadoRepresentanteLegalEclipsoft.getSegundoApellido());
                datosUsuario.setCargo(certificadoRepresentanteLegalEclipsoft.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            } else if (certificadoEclipsoft instanceof CertificadoPersonaJuridicaPrivadaEclipsoft) {
                CertificadoPersonaJuridicaPrivadaEclipsoft certificadoPersonaJuridicaPrivadaEclipsoft = (CertificadoPersonaJuridicaPrivadaEclipsoft) certificadoEclipsoft;
                datosUsuario.setCedula(certificadoPersonaJuridicaPrivadaEclipsoft.getCedulaPasaporte());
                datosUsuario.setNombre(certificadoPersonaJuridicaPrivadaEclipsoft.getNombres());
                datosUsuario.setApellido(certificadoPersonaJuridicaPrivadaEclipsoft.getPrimerApellido() + " " + certificadoPersonaJuridicaPrivadaEclipsoft.getSegundoApellido());
                datosUsuario.setCargo(datosUsuario.getCargo());
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            } else if (certificadoEclipsoft instanceof CertificadoSelladoTiempo) {
                datosUsuario.setSerial(certificado.getSerialNumber().toString());
            }
            datosUsuario.setEntidadCertificadora("Eclipsoft");
            datosUsuario.setCertificadoDigitalValido(true);
            return datosUsuario;
        }
        return null;
    }
}
