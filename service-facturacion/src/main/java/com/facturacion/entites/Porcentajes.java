package com.facturacion.entites;

import com.facturacion.CollectionsNames;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Document(collection = CollectionsNames.PORCENTAJES)
public class Porcentajes {

    @Id
    private ObjectId _id;
    private Impuesto impuesto;
    @Indexed(unique = true)
    @Field(value = "descripcion")
    private String descripcion;
    @Indexed(unique = true)
    @Field(value = "codigo")
    private String codigo;
    private Double valorPorcentaje;

    public Porcentajes() {
    }

    public String get_id() {
        return _id.toHexString();
    }

    public void set_id(ObjectId _id) {
        this._id = _id;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public Double getValorPorcentaje() {
        return valorPorcentaje;
    }

    public void setValorPorcentaje(Double valorPorcentaje) {
        this.valorPorcentaje = valorPorcentaje;
    }

    public Impuesto getImpuesto() {
        return impuesto;
    }

    public void setImpuesto(Impuesto impuesto) {
        this.impuesto = impuesto;
    }
}
