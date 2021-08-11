package com.facturacion.entites;

import com.facturacion.CollectionsNames;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = CollectionsNames.MSG_FORMATO_NOTIFICACION)
public class MsgFormatoNotificacion {

    @Id
    private ObjectId _id;
    private String header;
    private String footer;
    private String asunto;

    public MsgFormatoNotificacion() {
    }

    public String get_id() {
        return _id.toHexString();
    }

    public void set_id(ObjectId _id) {
        this._id = _id;
    }

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
    }

    public String getFooter() {
        return footer;
    }

    public void setFooter(String footer) {
        this.footer = footer;
    }

    public String getAsunto() {
        return asunto;
    }

    public void setAsunto(String asunto) {
        this.asunto = asunto;
    }
}
