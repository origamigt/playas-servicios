package ec.gob.ventanilla.model;

public class BalconServicio {

    private Long id;
    private String numeroFicha;
    private String acto;
    private String fechaInscripcion;
    private String anioInscripcion;
    private String numeroInscripcion;
    private String cedula;
    private String nombres;
    private String papel;
    private String observacion;
    private String estado;
    private Boolean tieneResultado = Boolean.TRUE;

    public BalconServicio() {
    }

    public BalconServicio(String numeroFicha, String acto, String fechaInscripcion, String anioInscripcion,
                          String numeroInscripcion, String cedula,
                          String nombres, String papel, String observacion, String estado, Boolean tieneResultado) {
        this.numeroFicha = numeroFicha;
        this.acto = acto;
        this.fechaInscripcion = fechaInscripcion;
        this.anioInscripcion = anioInscripcion;
        this.numeroInscripcion = numeroInscripcion;
        this.cedula = cedula;
        this.nombres = nombres;
        this.papel = papel;
        this.observacion = observacion;
        this.estado = estado;
        this.tieneResultado = tieneResultado;
    }

    public BalconServicio(String estado, Boolean tieneResultado) {
        this.estado = estado;
        this.tieneResultado = tieneResultado;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNumeroFicha() {
        return numeroFicha;
    }

    public void setNumeroFicha(String numeroFicha) {
        this.numeroFicha = numeroFicha;
    }

    public String getActo() {
        return acto;
    }

    public void setActo(String acto) {
        this.acto = acto;
    }

    public String getFechaInscripcion() {
        return fechaInscripcion;
    }

    public void setFechaInscripcion(String fechaInscripcion) {
        this.fechaInscripcion = fechaInscripcion;
    }

    public String getNumeroInscripcion() {
        return numeroInscripcion;
    }

    public void setNumeroInscripcion(String numeroInscripcion) {
        this.numeroInscripcion = numeroInscripcion;
    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getPapel() {
        return papel;
    }

    public void setPapel(String papel) {
        this.papel = papel;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public String getAnioInscripcion() {
        return anioInscripcion;
    }

    public void setAnioInscripcion(String anioInscripcion) {
        this.anioInscripcion = anioInscripcion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Boolean getTieneResultado() {
        return tieneResultado;
    }

    public void setTieneResultado(Boolean tieneResultado) {
        this.tieneResultado = tieneResultado;
    }

    @Override
    public String toString() {
        return "RegInscripcion{" +
                "id=" + id +
                ", numeroFicha='" + numeroFicha + '\'' +
                ", acto='" + acto + '\'' +
                ", fechaInscripcion='" + fechaInscripcion + '\'' +
                ", anioInscripcion='" + anioInscripcion + '\'' +
                ", numeroInscripcion='" + numeroInscripcion + '\'' +
                ", cedula='" + cedula + '\'' +
                ", nombres='" + nombres + '\'' +
                ", papel='" + papel + '\'' +
                ", observacion='" + observacion + '\'' +
                ", estado='" + estado + '\'' +
                ", tieneResultado=" + tieneResultado +
                '}';
    }

}
