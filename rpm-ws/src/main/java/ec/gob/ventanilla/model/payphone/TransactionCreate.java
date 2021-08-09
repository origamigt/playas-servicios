package ec.gob.ventanilla.model.payphone;

public class TransactionCreate {

    private String data; //EfhY888nQ/zh/42idk9y5gNbX+h4WG5jyOu9eDztXPRpWrkiwg38MZso+dhGzN2N5St+WzGCAiYAnM02tMcDqcPqwJAePFHnTWzX0T1V9JNu/L/+euCZxK4hfyV4CIzbAwBC6+VesT+LGMaIRuzXEo3W3FAFtScbdhyZa8rGbUo=
    private String phoneNumber; //+593960978378
    private String email; //andysanchezgonzalez1996@gmail.com
    private String optionalParameter; //WEB - MOVIL
    private String documentId; //0953255957
    private Integer amount; // 100
    private Integer amountWithTax; //0
    private Integer amountWithoutTax; // 100
    private String clientTransactionId; //ID SOLICITUD
    private Integer tax; //0
    private Integer expireIn; //0
    private String responseUrl; //186.47.44.170/sgr.
    private String reference;
    private String currency;
    private Boolean oneTime;

    public TransactionCreate() {
    }

    public TransactionCreate(String data, String phoneNumber,
                             String email, String optionalParameter,
                             String documentId, Integer amount,
                             Integer amountWithTax, Integer amountWithoutTax,
                             String clientTransactionId, Integer tax, String responseUrl) {
        this.data = data;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.optionalParameter = optionalParameter;
        this.documentId = documentId;
        this.amount = amount;
        this.amountWithTax = amountWithTax;
        this.amountWithoutTax = amountWithoutTax;
        this.clientTransactionId = clientTransactionId;
        this.tax = tax;
        this.responseUrl = responseUrl;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getOptionalParameter() {
        return optionalParameter;
    }

    public void setOptionalParameter(String optionalParameter) {
        this.optionalParameter = optionalParameter;
    }

    public String getDocumentId() {
        return documentId;
    }

    public void setDocumentId(String documentId) {
        this.documentId = documentId;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public Integer getAmountWithTax() {
        return amountWithTax;
    }

    public void setAmountWithTax(Integer amountWithTax) {
        this.amountWithTax = amountWithTax;
    }

    public Integer getAmountWithoutTax() {
        return amountWithoutTax;
    }

    public void setAmountWithoutTax(Integer amountWithoutTax) {
        this.amountWithoutTax = amountWithoutTax;
    }

    public String getClientTransactionId() {
        return clientTransactionId;
    }

    public void setClientTransactionId(String clientTransactionId) {
        this.clientTransactionId = clientTransactionId;
    }

    public Integer getTax() {
        return tax;
    }

    public void setTax(Integer tax) {
        this.tax = tax;
    }

    public String getResponseUrl() {
        return responseUrl;
    }

    public void setResponseUrl(String responseUrl) {
        this.responseUrl = responseUrl;

    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public Boolean getOneTime() {
        return oneTime;
    }

    public void setOneTime(Boolean oneTime) {
        this.oneTime = oneTime;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public Integer getExpireIn() {
        return expireIn;
    }

    public void setExpireIn(Integer expireIn) {
        this.expireIn = expireIn;
    }

    @Override
    public String toString() {
        return "TransactionCreate{"
                + "data='" + data + '\''
                + ", phoneNumber='" + phoneNumber + '\''
                + ", email='" + email + '\''
                + ", optionalParameter='" + optionalParameter + '\''
                + ", documentId='" + documentId + '\''
                + ", amount=" + amount
                + ", amountWithTax=" + amountWithTax
                + ", amountWithoutTax=" + amountWithoutTax
                + ", clientTransactionId='" + clientTransactionId + '\''
                + ", tax=" + tax
                + ", responseUrl='" + responseUrl + '\''
                + '}';
    }
}
