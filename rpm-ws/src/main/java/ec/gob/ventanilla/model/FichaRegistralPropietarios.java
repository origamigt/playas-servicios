package ec.gob.ventanilla.model;

public class FichaRegistralPropietarios {

    private Integer id;
    private String cedRuc;
    private String nombre;

    public FichaRegistralPropietarios() {
    }

    public String getCedRuc() {
        return cedRuc;
    }

    public void setCedRuc(String cedRuc) {
        this.cedRuc = cedRuc;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
