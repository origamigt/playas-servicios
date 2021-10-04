package ec.gob.ventanilla.model.payphone;

import com.google.gson.annotations.Expose;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "response_create")
public class ResponseCreate implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    @Expose(serialize = false, deserialize = false)
    private Long id;
    private String cardToken;
    private String authorizationCode;
    private String message;
    private String messageCode;
    private String status;
    private String statusCode;
    private String transactionStatus;
    private String transactionId;
    private String clientTransactionId;
    @Expose(serialize = false, deserialize = false)
    private Long idSolicitud;
    @Expose(serialize = false, deserialize = false)
    private Date fecha;
    private String acto;
    private Double total;
    private String email;
    private String phoneNumber;
    private String document;
    private String cardType;
    private String cardBrandCode;
    private String cardBrand;
    private String bin;
    private String lastDigits;
    private String deferredMessage;
    private String deferred;
    private String recap;
    private Double amount;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCardToken() {
        return cardToken;
    }

    public void setCardToken(String cardToken) {
        this.cardToken = cardToken;
    }

    public String getAuthorizationCode() {
        return authorizationCode;
    }

    public void setAuthorizationCode(String authorizationCode) {
        this.authorizationCode = authorizationCode;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getMessageCode() {
        return messageCode;
    }

    public void setMessageCode(String messageCode) {
        this.messageCode = messageCode;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getTransactionStatus() {
        return transactionStatus;
    }

    public void setTransactionStatus(String transactionStatus) {
        this.transactionStatus = transactionStatus;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getDocument() {
        return document;
    }

    public void setDocument(String document) {
        this.document = document;
    }

    public String getCardType() {
        return cardType;
    }

    public void setCardType(String cardType) {
        this.cardType = cardType;
    }

    public String getCardBrandCode() {
        return cardBrandCode;
    }

    public void setCardBrandCode(String cardBrandCode) {
        this.cardBrandCode = cardBrandCode;
    }

    public String getCardBrand() {
        return cardBrand;
    }

    public void setCardBrand(String cardBrand) {
        this.cardBrand = cardBrand;
    }

    public String getBin() {
        return bin;
    }

    public void setBin(String bin) {
        this.bin = bin;
    }

    public String getLastDigits() {
        return lastDigits;
    }

    public void setLastDigits(String lastDigits) {
        this.lastDigits = lastDigits;
    }

    public String getDeferredMessage() {
        return deferredMessage;
    }

    public void setDeferredMessage(String deferredMessage) {
        this.deferredMessage = deferredMessage;
    }

    public String getDeferred() {
        return deferred;
    }

    public void setDeferred(String deferred) {
        this.deferred = deferred;
    }

    public String getRecap() {
        return recap;
    }

    public void setRecap(String recap) {
        this.recap = recap;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getClientTransactionId() {
        return clientTransactionId;
    }

    public void setClientTransactionId(String clientTransactionId) {
        this.clientTransactionId = clientTransactionId;
    }

    public Long getIdSolicitud() {
        return idSolicitud;
    }

    public void setIdSolicitud(Long idSolicitud) {
        this.idSolicitud = idSolicitud;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getActo() {
        return acto;
    }

    public void setActo(String acto) {
        this.acto = acto;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    @Override
    public String toString() {
        return "ResponseCreate{" +
                "id=" + id +
                ", cardToken='" + cardToken + '\'' +
                ", authorizationCode='" + authorizationCode + '\'' +
                ", message='" + message + '\'' +
                ", messageCode='" + messageCode + '\'' +
                ", status='" + status + '\'' +
                ", statusCode='" + statusCode + '\'' +
                ", transactionStatus='" + transactionStatus + '\'' +
                ", transactionId='" + transactionId + '\'' +
                ", clientTransactionId='" + clientTransactionId + '\'' +
                ", idSolicitud=" + idSolicitud +
                ", fecha=" + fecha +
                ", acto='" + acto + '\'' +
                ", total=" + total +
                ", email='" + email + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", document='" + document + '\'' +
                ", cardType='" + cardType + '\'' +
                ", cardBrandCode='" + cardBrandCode + '\'' +
                ", cardBrand='" + cardBrand + '\'' +
                ", bin='" + bin + '\'' +
                ", lastDigits='" + lastDigits + '\'' +
                ", deferredMessage='" + deferredMessage + '\'' +
                ", deferred='" + deferred + '\'' +
                ", recap='" + recap + '\'' +
                ", amount=" + amount +
                '}';
    }
}
