package com.facturacion.entites;

public class MsgFormatoNotificacion {

    private String header;
    private String footer;
    private String asunto;

    public MsgFormatoNotificacion() {
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
