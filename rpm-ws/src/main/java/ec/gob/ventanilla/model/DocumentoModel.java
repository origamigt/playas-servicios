package ec.gob.ventanilla.model;

import org.springframework.web.multipart.MultipartFile;

public class DocumentoModel {

    private String nombre;
    private byte[] multipartFile;
    private FirmaElectronica firmaElectronica;

    public DocumentoModel() {
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public byte[] getMultipartFile() {
        return multipartFile;
    }

    public void setMultipartFile(byte[] multipartFile) {
        this.multipartFile = multipartFile;
    }

    public FirmaElectronica getFirmaElectronica() {
        return firmaElectronica;
    }

    public void setFirmaElectronica(FirmaElectronica firmaElectronica) {
        this.firmaElectronica = firmaElectronica;
    }
}
