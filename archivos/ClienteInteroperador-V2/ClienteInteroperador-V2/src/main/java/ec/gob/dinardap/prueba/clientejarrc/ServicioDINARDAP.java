/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.dinardap.prueba.clientejarrc;

import ec.gob.prueba.ws.DINARDAPService.Columna;
import ec.gob.prueba.ws.DINARDAPService.Consultar;
import ec.gob.prueba.ws.DINARDAPService.ConsultarFaultException;
import ec.gob.prueba.ws.DINARDAPService.ConsultarResponse;
import ec.gob.prueba.ws.DINARDAPService.Entidad;

import ec.gob.prueba.ws.DINARDAPService.Fila;
import ec.gob.prueba.ws.DINARDAPService.Interoperador;
import ec.gob.prueba.ws.DINARDAPService.Parametro;
import ec.gob.prueba.ws.DINARDAPService.Parametros;
import java.util.List;
import org.apache.cxf.endpoint.Client;
import org.apache.cxf.frontend.ClientProxy;
import org.apache.cxf.jaxws.JaxWsProxyFactoryBean;
import org.apache.cxf.transport.http.HTTPConduit;
import org.apache.cxf.transports.http.configuration.HTTPClientPolicy;

/**
 *
 * @author luis.molina
 */
public class ServicioDINARDAP {

    public void getDatosDINARDAP(String cedula) {
        try {

            JaxWsProxyFactoryBean factory = new JaxWsProxyFactoryBean();
            factory.setServiceClass(Interoperador.class);
            factory.setAddress("https://interoperabilidad.dinardap.gob.ec/interoperador-v2?wsdl");

            /**
             * ****************
             * cambiar usurio *****************
             */
            factory.setUsername("interoperador");
            /**
             * ****************
             * cambiar password *******************
             */
            factory.setPassword("**********");

            Interoperador port = (Interoperador) factory.create();
            Client client = ClientProxy.getClient(port);

            if (client != null) {
                HTTPConduit conduit = (HTTPConduit) client.getConduit();
                HTTPClientPolicy policy = new HTTPClientPolicy();
                //policy.setConnectionTimeout(ParametrosUtil.CONNECTION_TIMEOUT);
                //policy.setReceiveTimeout(ParametrosUtil.RECEIVE_TIMEOUT);
                policy.setAllowChunking(false);
                conduit.setClient(policy);

            }
            Parametro paramCodigoPaquete = new Parametro();
            paramCodigoPaquete.setNombre("codigoPaquete");
            paramCodigoPaquete.setValor("383");

            Parametro paramIdent = new Parametro();
            paramIdent.setNombre("identificacion");
            paramIdent.setValor(cedula);

            Parametros parametros = new Parametros();
            parametros.getParametro().add(paramCodigoPaquete);
            parametros.getParametro().add(paramIdent);

            Consultar consultar = new Consultar();
            consultar.setParametros(parametros);
            ConsultarResponse response = port.consultar(consultar);

            //System.out.println(response.getReturn().getCodigoPaquete());
            //System.out.println("MENSAJE PRINCIPAL:"+response.getReturn().getMensaje());
            List<Entidad> entidades = response.getPaquete().getEntidades().getEntidad();

            for (Entidad entidad : entidades) {
//                filas
                System.out.println("Información de:" + entidad.getNombre());
                System.out.println("------------------------------------------------------------");
                for (Fila fila : entidad.getFilas().getFila()) {
//                    columnas
                    for (Columna columna : fila.getColumnas().getColumna()) {
//                        se obtiene los valores de cada columna
                        System.out.println(columna.getCampo() + " = " + columna.getValor());

                    }
                    System.out.println("------------------------------------------------------------");
                }

            }

        } catch (ConsultarFaultException ex) {
            ex.printStackTrace(System.out);
        }
    }
}
