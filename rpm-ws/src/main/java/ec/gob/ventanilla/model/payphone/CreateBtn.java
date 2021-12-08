/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.ventanilla.model.payphone;

/**
 * @author ORIGAMI
 */
public class CreateBtn {

    private String paymentId;
    private String payWithPayPhone;
    private String payWithCard;
    private String payWithApp;

    public CreateBtn() {
    }

    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

    public String getPayWithPayPhone() {
        return payWithPayPhone;
    }

    public void setPayWithPayPhone(String payWithPayPhone) {
        this.payWithPayPhone = payWithPayPhone;
    }

    public String getPayWithCard() {
        return payWithCard;
    }

    public void setPayWithCard(String payWithCard) {
        this.payWithCard = payWithCard;
    }

    @Override
    public String toString() {
        return "CreateBtn{" + "paymentId=" + paymentId + ", payWithPayPhone=" + payWithPayPhone + ", payWithCard=" + payWithCard + '}';
    }

    public String getPayWithApp() {
        return payWithApp;
    }

    public void setPayWithApp(String payWithApp) {
        this.payWithApp = payWithApp;
    }
}
