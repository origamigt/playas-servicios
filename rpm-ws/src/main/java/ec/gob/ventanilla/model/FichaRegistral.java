package ec.gob.ventanilla.model;

import java.util.List;

public class FichaRegistral {

    private Long id;
    private Long numFicha;
    private String tipoInmueble;
    private String claveCatastral;
    private String parroquia;
    private String sector;
    private String manazana;
    //DIRECCION DEL BIEN =)
    private String solNumeroCasa;
    private String lote;
    private Boolean excedentePropietarios;
    private List<FichaRegistralPropietarios> fichaPropietarios;


    public Boolean getExcedentePropietarios() {
        return excedentePropietarios;
    }

    public void setExcedentePropietarios(Boolean excedentePropietarios) {
        this.excedentePropietarios = excedentePropietarios;
    }

    public String getLote() {
        return lote;
    }

    public void setLote(String lote) {
        this.lote = lote;
    }


    public List<FichaRegistralPropietarios> getFichaPropietarios() {
        return fichaPropietarios;
    }

    public void setFichaPropietarios(List<FichaRegistralPropietarios> fichaPropietarios) {
        this.fichaPropietarios = fichaPropietarios;
    }

    public FichaRegistral() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getNumFicha() {
        return numFicha;
    }

    public void setNumFicha(Long numFicha) {
        this.numFicha = numFicha;
    }

    public String getTipoInmueble() {
        return tipoInmueble;
    }

    public void setTipoInmueble(String tipoInmueble) {
        this.tipoInmueble = tipoInmueble;
    }

    public String getClaveCatastral() {
        return claveCatastral;
    }

    public void setClaveCatastral(String claveCatastral) {
        this.claveCatastral = claveCatastral;
    }

    public String getParroquia() {
        return parroquia;
    }

    public void setParroquia(String parroquia) {
        this.parroquia = parroquia;
    }

    public String getSector() {
        return sector;
    }

    public void setSector(String sector) {
        this.sector = sector;
    }

    public String getManazana() {
        return manazana;
    }

    public void setManazana(String manazana) {
        this.manazana = manazana;
    }

    public String getSolNumeroCasa() {
        return solNumeroCasa;
    }

    public void setSolNumeroCasa(String solNumeroCasa) {
        this.solNumeroCasa = solNumeroCasa;
    }


}
