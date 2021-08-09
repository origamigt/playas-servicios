package ec.gob.ventanilla.conf;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class AppProps {
    @Value("${spring.profiles.active}")
    private String activeProfile;
    @Value("${app.logo}")
    private String logo;
    @Value("${app.urlPdfFirmado}")
    private String urlPdfFirmado;
    @Value("${app.urlPersona}")
    private String urlPersona;
    @Value("${app.urlFichaRegistral}")
    private String urlFichaRegistral;

    @Value("${app.userSgr}")
    private String userSgr;
    @Value("${app.passSgr}")
    private String passSgr;

    @Value("${app.rpConsultarTramite}")
    private String rpConsultarTramite;
    @Value("${app.rpIniciarTramite}")
    private String rpIniciarTramite;
    @Value("${app.rpActualizarDocumentos}")
    private String rpActualizarDocumentos;
    @Value("${app.rpConsultarOidDocument}")
    private String rpConsultarOidDocument;
    @Value("${app.rpConsultarOidInscripcion}")
    private String rpConsultarOidInscripcion;
    @Value("${app.rpConsultarOid}")
    private String rpConsultarOid;
    @Value("${app.rpEntregaTramiteAPP}")
    private String rpEntregaTramiteAPP;
    @Value("${app.rpFacturas}")
    private String rpFacturas;
    @Value("${app.rpActoInscripciones}")
    private String rpActosInscripciones;
    @Value("${app.rpIniciarTramiteInscripcion}")
    private String rpIniciarTramiteInscripcion;
    @Value("${app.rpIniciarTramiteSolicitudInscripcion}")
    private String rpIniciarTramiteSolicitudInscripcion;

    @Value("${app.rpActualizarRequisitos}")
    private String rpActualizarRequisitos;

    @Value("${app.payphoneError}")
    private String payphoneError;
    @Value("${app.payphoneTransactionCreate}")
    private String payphoneTransactionCreate;
    @Value("${app.payphoneReverseClient}")
    private String payphoneReverseClient;
    @Value("${app.payphoneApiCoding}")
    private String payphoneApiCoding;
    @Value("${app.payphoneBearerApiToken}")
    private String payphoneBearerApiToken;

    @Value("${app.payphoneLinkPago}")
    private String payphoneLinkPago;
    @Value("${app.payphoneLinkApiCoding}")
    private String payphoneLinkApiCoding;
    @Value("${app.payphoneLinkBearerApiToken}")
    private String payphoneLinkBearerApiToken;

    @Value("${app.payphoneBtnPago}")
    private String payphoneBtnPago;
    @Value("${app.payphoneBtnApiCoding}")
    private String payphoneBtnApiCoding;
    @Value("${app.payphoneBtnBearerApiToken}")
    private String payphoneBtnBearerApiToken;

    @Value("${app.payphoneConfirmPago}")
    private String payphoneConfirmPago;

    @Value("${app.correo}")
    private String correo;
    @Value("${app.claveCorreo}")
    private String claveCorreo;
    @Value("${app.hostCorreo}")
    private String hostCorreo;
    @Value("${app.portCorreo}")
    private String portCorreo;
    @Value("${app.entidad}")
    private String entidad;
    @Value("${app.outputDir}")
    private String outputDir;
    @Value("${app.dominio}")
    private String dominio;
    @Value("${app.docUrl}")
    private String docUrl;
    @Value("${app.dbDocUser}")
    private String dbDocUser;
    @Value("${app.dbDocPass}")
    private String dbDocPass;

    public String getLogo() {
        return logo;
    }

    public String getActiveProfile() {
        return activeProfile;
    }

    public void setActiveProfile(String activeProfile) {
        this.activeProfile = activeProfile;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getUrlPdfFirmado() {
        return urlPdfFirmado;
    }

    public void setUrlPdfFirmado(String urlPdfFirmado) {
        this.urlPdfFirmado = urlPdfFirmado;
    }

    public String getUrlPersona() {
        return urlPersona;
    }

    public void setUrlPersona(String urlPersona) {
        this.urlPersona = urlPersona;
    }

    public String getUrlFichaRegistral() {
        return urlFichaRegistral;
    }

    public void setUrlFichaRegistral(String urlFichaRegistral) {
        this.urlFichaRegistral = urlFichaRegistral;
    }

    public String getRpConsultarTramite() {
        return rpConsultarTramite;
    }

    public void setRpConsultarTramite(String rpConsultarTramite) {
        this.rpConsultarTramite = rpConsultarTramite;
    }

    public String getRpIniciarTramite() {
        return rpIniciarTramite;
    }

    public void setRpIniciarTramite(String rpIniciarTramite) {
        this.rpIniciarTramite = rpIniciarTramite;
    }

    public String getRpActualizarDocumentos() {
        return rpActualizarDocumentos;
    }

    public void setRpActualizarDocumentos(String rpActualizarDocumentos) {
        this.rpActualizarDocumentos = rpActualizarDocumentos;
    }

    public String getRpConsultarOidDocument() {
        return rpConsultarOidDocument;
    }

    public void setRpConsultarOidDocument(String rpConsultarOidDocument) {
        this.rpConsultarOidDocument = rpConsultarOidDocument;
    }

    public String getRpConsultarOid() {
        return rpConsultarOid;
    }

    public void setRpConsultarOid(String rpConsultarOid) {
        this.rpConsultarOid = rpConsultarOid;
    }

    public String getRpEntregaTramiteAPP() {
        return rpEntregaTramiteAPP;
    }

    public void setRpEntregaTramiteAPP(String rpEntregaTramiteAPP) {
        this.rpEntregaTramiteAPP = rpEntregaTramiteAPP;
    }

    public String getRpFacturas() {
        return rpFacturas;
    }

    public void setRpFacturas(String rpFacturas) {
        this.rpFacturas = rpFacturas;
    }

    public String getUserSgr() {
        return userSgr;
    }

    public void setUserSgr(String userSgr) {
        this.userSgr = userSgr;
    }

    public String getPassSgr() {
        return passSgr;
    }

    public void setPassSgr(String passSgr) {
        this.passSgr = passSgr;
    }

    public String getPayphoneError() {
        return payphoneError;
    }

    public void setPayphoneError(String payphoneError) {
        this.payphoneError = payphoneError;
    }

    public String getPayphoneTransactionCreate() {
        return payphoneTransactionCreate;
    }

    public void setPayphoneTransactionCreate(String payphoneTransactionCreate) {
        this.payphoneTransactionCreate = payphoneTransactionCreate;
    }

    public String getPayphoneReverseClient() {
        return payphoneReverseClient;
    }

    public void setPayphoneReverseClient(String payphoneReverseClient) {
        this.payphoneReverseClient = payphoneReverseClient;
    }

    public String getPayphoneApiCoding() {
        return payphoneApiCoding;
    }

    public void setPayphoneApiCoding(String payphoneApiCoding) {
        this.payphoneApiCoding = payphoneApiCoding;
    }

    public String getPayphoneBearerApiToken() {
        return payphoneBearerApiToken;
    }

    public void setPayphoneBearerApiToken(String payphoneBearerApiToken) {
        this.payphoneBearerApiToken = payphoneBearerApiToken;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getClaveCorreo() {
        return claveCorreo;
    }

    public void setClaveCorreo(String claveCorreo) {
        this.claveCorreo = claveCorreo;
    }

    public String getHostCorreo() {
        return hostCorreo;
    }

    public void setHostCorreo(String hostCorreo) {
        this.hostCorreo = hostCorreo;
    }

    public String getPortCorreo() {
        return portCorreo;
    }

    public void setPortCorreo(String portCorreo) {
        this.portCorreo = portCorreo;
    }

    public String getEntidad() {
        return entidad;
    }

    public void setEntidad(String entidad) {
        this.entidad = entidad;
    }

    public String getOutputDir() {
        return outputDir;
    }

    public void setOutputDir(String outputDir) {
        this.outputDir = outputDir;
    }

    public String getDominio() {
        return dominio;
    }

    public void setDominio(String dominio) {
        this.dominio = dominio;
    }

    public String getDocUrl() {
        return docUrl;
    }

    public void setDocUrl(String docUrl) {
        this.docUrl = docUrl;
    }

    public String getRpConsultarOidInscripcion() {
        return rpConsultarOidInscripcion;
    }

    public void setRpConsultarOidInscripcion(String rpConsultarOidInscripcion) {
        this.rpConsultarOidInscripcion = rpConsultarOidInscripcion;
    }

    public String getRpActosInscripciones() {
        return rpActosInscripciones;
    }

    public void setRpActosInscripciones(String rpActosInscripciones) {
        this.rpActosInscripciones = rpActosInscripciones;
    }

    public String getRpIniciarTramiteInscripcion() {
        return rpIniciarTramiteInscripcion;
    }

    public void setRpIniciarTramiteInscripcion(String rpIniciarTramiteInscripcion) {
        this.rpIniciarTramiteInscripcion = rpIniciarTramiteInscripcion;
    }

    public String getRpActualizarRequisitos() {
        return rpActualizarRequisitos;
    }

    public void setRpActualizarRequisitos(String rpActualizarRequisitos) {
        this.rpActualizarRequisitos = rpActualizarRequisitos;
    }

    public String getPayphoneLinkPago() {
        return payphoneLinkPago;
    }

    public void setPayphoneLinkPago(String payphoneLinkPago) {
        this.payphoneLinkPago = payphoneLinkPago;
    }

    public String getPayphoneLinkApiCoding() {
        return payphoneLinkApiCoding;
    }

    public void setPayphoneLinkApiCoding(String payphoneLinkApiCoding) {
        this.payphoneLinkApiCoding = payphoneLinkApiCoding;
    }

    public String getPayphoneLinkBearerApiToken() {
        return payphoneLinkBearerApiToken;
    }

    public void setPayphoneLinkBearerApiToken(String payphoneLinkBearerApiToken) {
        this.payphoneLinkBearerApiToken = payphoneLinkBearerApiToken;
    }

    public String getPayphoneBtnPago() {
        return payphoneBtnPago;
    }

    public void setPayphoneBtnPago(String payphoneBtnPago) {
        this.payphoneBtnPago = payphoneBtnPago;
    }

    public String getPayphoneBtnApiCoding() {
        return payphoneBtnApiCoding;
    }

    public void setPayphoneBtnApiCoding(String payphoneBtnApiCoding) {
        this.payphoneBtnApiCoding = payphoneBtnApiCoding;
    }

    public String getPayphoneBtnBearerApiToken() {
        return payphoneBtnBearerApiToken;
    }

    public void setPayphoneBtnBearerApiToken(String payphoneBtnBearerApiToken) {
        this.payphoneBtnBearerApiToken = payphoneBtnBearerApiToken;
    }

    public String getPayphoneConfirmPago() {
        return payphoneConfirmPago;
    }

    public void setPayphoneConfirmPago(String payphoneConfirmPago) {
        this.payphoneConfirmPago = payphoneConfirmPago;
    }

    public String getRpIniciarTramiteSolicitudInscripcion() {
        return rpIniciarTramiteSolicitudInscripcion;
    }

    public void setRpIniciarTramiteSolicitudInscripcion(String rpIniciarTramiteSolicitudInscripcion) {
        this.rpIniciarTramiteSolicitudInscripcion = rpIniciarTramiteSolicitudInscripcion;
    }

    public String getDbDocUser() {
        return dbDocUser;
    }

    public void setDbDocUser(String dbDocUser) {
        this.dbDocUser = dbDocUser;
    }

    public String getDbDocPass() {
        return dbDocPass;
    }

    public void setDbDocPass(String dbDocPass) {
        this.dbDocPass = dbDocPass;
    }



}
