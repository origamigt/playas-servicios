/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.ventanilla.model.payphone;

/**
 *
 * @author ORIGAMI
 */
public class ResponseBtn {

    private Integer id;
    private String clientTxId;
    private Long solicitud;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getClientTxId() {
        return clientTxId;
    }

    public void setClientTxId(String clientTxId) {
        this.clientTxId = clientTxId;
    }

    public Long getSolicitud() {
        return solicitud;
    }

    public void setSolicitud(Long solicitud) {
        this.solicitud = solicitud;
    }

}
