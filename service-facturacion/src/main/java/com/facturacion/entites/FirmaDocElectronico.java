package com.facturacion.entites;

import com.facturacion.CollectionsNames;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import javax.validation.constraints.Size;
import java.math.BigInteger;
import java.util.Date;

@Document(collection = CollectionsNames.FIRMA_DOC_ELECTRONICO)
public class FirmaDocElectronico {

    @Id
    private ObjectId _id;
    @Field
    private Firma firma;
    @Field
    private DocElectronico docElectronico;
    @Field
    @Size(min = 1, max = 3)
    private String establecimiento;
    @Field
    @Size(min = 1, max = 3)
    private String puntoEmision;
    @Field
    private BigInteger secuencial;
    @Field
    private Date deleteAt;
    @Field
    private Boolean isOnline;

    public FirmaDocElectronico() {

    }

    public String get_id() {
        return _id.toHexString();
    }

    public void set_id(ObjectId _id) {
        this._id = _id;
    }

    public Firma getFirma() {
        return firma;
    }

    public void setFirma(Firma firma) {
        this.firma = firma;
    }

    public DocElectronico getDocElectronico() {
        return docElectronico;
    }

    public void setDocElectronico(DocElectronico docElectronico) {
        this.docElectronico = docElectronico;
    }

    public String getEstablecimiento() {
        return establecimiento;
    }

    public void setEstablecimiento(String establecimiento) {
        this.establecimiento = establecimiento;
    }

    public String getPuntoEmision() {
        return puntoEmision;
    }

    public void setPuntoEmision(String puntoEmision) {
        this.puntoEmision = puntoEmision;
    }

    public BigInteger getSecuencial() {
        return secuencial;
    }

    public void setSecuencial(BigInteger secuencial) {
        this.secuencial = secuencial;
    }

    public Date getDeleteAt() {
        return deleteAt;
    }

    public void setDeleteAt(Date deleteAt) {
        this.deleteAt = deleteAt;
    }
   
    public Boolean getIsOnline() {
		return isOnline;
	}

	public void setIsOnline(Boolean isOnline) {
		this.isOnline = isOnline;
	}

	@Override
    public String toString() {
        return "FirmaDocElectronico{" +
                "_id=" + _id +
                ", firma=" + firma +
                ", docElectronico=" + docElectronico +
                ", establecimiento='" + establecimiento + '\'' +
                ", puntoEmision='" + puntoEmision + '\'' +
                ", secuencial='" + secuencial + '\'' +
                ", deleteAt=" + deleteAt +
                '}';
    }
}
