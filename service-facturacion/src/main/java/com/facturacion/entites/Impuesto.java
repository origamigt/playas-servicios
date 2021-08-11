package com.facturacion.entites;

import com.facturacion.CollectionsNames;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

//@Document(collection = CollectionsNames.IMPUESTO)
public class Impuesto {
/*@Idpublic ObjectId _id;*/

    private String descripcion;
    private String codigo;
  //  private List<Porcentajes> porcentajes;

    public Impuesto() {
    }

    /*public String get_id() {return _id.toHexString();}public void set_id(ObjectId _id) {this._id = _id;}*/
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
/*public List<Porcentajes> getPorcentajes() {return porcentajes;}public void setPorcentajes(List<Porcentajes> porcentajes) {this.porcentajes = porcentajes;}*/
}
