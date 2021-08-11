package com.facturacion.entites;

import com.facturacion.CollectionsNames;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.math.BigInteger;

//@Document(collection = CollectionsNames.SECUENCIA_COMPROBANTE)
public class SecuenciaComprobante {

    @Id
    private ObjectId _id;
    private Comprobante comprobante;
    //@Indexed
    private BigInteger secuencia;

    public SecuenciaComprobante() {
    }

    public String get_id() {
        return _id.toHexString();
    }

    public void set_id(ObjectId _id) {
        this._id = _id;
    }

   

    @Override
    public String toString() {
        return "SecuenciaComprobante{" +
                "_id=" + _id +
                ", comprobante=" + comprobante +
                ", secuencia=" + secuencia +
                '}';
    }
}
