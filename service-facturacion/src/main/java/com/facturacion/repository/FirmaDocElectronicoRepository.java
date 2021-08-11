package com.facturacion.repository;

import com.facturacion.entites.FirmaDocElectronico;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface FirmaDocElectronicoRepository extends MongoRepository<FirmaDocElectronico, String> {

    FirmaDocElectronico findByPuntoEmisionAndDocElectronico_Entidad_RucEntidadAndDocElectronico_Comprobante_CodigoAndDocElectronico_Ambiente_CodigoAndFirma_EstadoAndIsOnline(String puntoEmision, String rucEntidad, String codigo, String ambiente, String estado, Boolean isOnline);

}
