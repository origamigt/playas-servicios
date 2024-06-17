/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gob.ec.dinardap.dinardap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import gob.ec.dinardap.entities.PubPersona;
import gob.ec.dinardap.repository.ValoresRepository;
import org.apache.cxf.endpoint.Client;
import org.apache.cxf.frontend.ClientProxy;
import org.apache.cxf.jaxws.JaxWsProxyFactoryBean;
import org.apache.cxf.transport.http.HTTPConduit;
import org.apache.cxf.transports.http.configuration.HTTPClientPolicy;
import ec.gob.ws.DINARDAPService.Columna;
import ec.gob.ws.DINARDAPService.Consultar;
import ec.gob.ws.DINARDAPService.ConsultarFaultException;
import ec.gob.ws.DINARDAPService.ConsultarResponse;
import ec.gob.ws.DINARDAPService.Entidad;
import ec.gob.ws.DINARDAPService.Fila;
import ec.gob.ws.DINARDAPService.Interoperador;
import ec.gob.ws.DINARDAPService.Parametro;
import ec.gob.ws.DINARDAPService.Parametros;
import gob.ec.dinardap.entities.SriRuc;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author gutya
 */
@Service
public class ServicioDINARDAP {

    private static final Logger logger = Logger.getLogger(ServicioDINARDAP.class.getName());

    @Autowired
    private ValoresRepository valoresRepository;

    /**
     * @param identificacion
     * @param codigoPaquete
     * @param parametro
     * @return
     */
    public PubPersona datosDINARDAP(String identificacion,
            String codigoPaquete, String parametro) {
        PubPersona persona;
        try {
            String paqueteSri = valoresRepository.findByCode("DINARDAP_SRI").getValorString();
            String paqueteDemografico = valoresRepository.findByCode("DINARDAP_DEMOGRAFICO").getValorString();
            String urlInterOperatividad = valoresRepository.findByCode("DINARDAP_URL").getValorString();
            String userInterOperatividad = valoresRepository.findByCode("DINARDAP_USUARIO").getValorString();
            String passInterOperatividad = valoresRepository.findByCode("DINARDAP_CLAVE").getValorString();

            JaxWsProxyFactoryBean factory = new JaxWsProxyFactoryBean();
            factory.setServiceClass(Interoperador.class);
            factory.setAddress(urlInterOperatividad);
            factory.setUsername(userInterOperatividad);
            factory.setPassword(passInterOperatividad);

            Interoperador port = (Interoperador) factory.create();
            Client client = ClientProxy.getClient(port);

            if (client != null) {
                HTTPConduit conduit = (HTTPConduit) client.getConduit();
                HTTPClientPolicy policy = new HTTPClientPolicy();
                policy.setAllowChunking(false);
                conduit.setClient(policy);

            }
            Parametro paramCodigoPaquete = new Parametro();
            paramCodigoPaquete.setNombre("codigoPaquete");
            paramCodigoPaquete.setValor(codigoPaquete);

            Parametro paramIdent = new Parametro();
            paramIdent.setNombre(parametro);
            paramIdent.setValor(identificacion);

            Parametros parametros = new Parametros();
            parametros.getParametro().add(paramCodigoPaquete);
            parametros.getParametro().add(paramIdent);

            if (codigoPaquete.equals(paqueteSri)) {
                System.out.println("holi ");
                Parametro fuenteDatos = new Parametro();
                fuenteDatos.setNombre("fuenteDatos");
                fuenteDatos.setValor("");
                parametros.getParametro().add(fuenteDatos);
            }

            Consultar consultar = new Consultar();
            consultar.setParametros(parametros);
            ConsultarResponse response = port.consultar(consultar);

            List<Entidad> entidades = response.getPaquete().getEntidades().getEntidad();
            persona = new PubPersona();
            Map<String, String> datos;
            for (Entidad entidad : entidades) {
//                filas
                System.out.println("Información de:" + entidad.getNombre());
                for (Fila fila : entidad.getFilas().getFila()) {
//                    columnas
                    for (Columna columna : fila.getColumnas().getColumna()) {
//                        se obtiene los valores de cada columna
                        System.out.println(columna.getCampo() + " = " + columna.getValor());
                        switch (columna.getCampo()) {
                            case "cedula":
                            case "numeroRuc":
                                persona.setCedRuc(columna.getValor());
                                break;
                            case "nombre":
                                if (codigoPaquete.equals(paqueteDemografico)) {
                                    datos = getDatos(columna.getValor());
                                    persona.setNombres(datos.get("nombre"));
                                    persona.setApellidos(datos.get("apellido"));
                                }
                                break;
                            case "razonSocial":
                                persona.setNombres(columna.getValor());
                                break;
                            case "nombreComercial":
                                persona.setApellidos(columna.getValor());
                                break;
                            case "lugarNacimiento":
                            case "direccionCorta":
                                persona.setDireccion(columna.getValor());
                                break;
                            case "estadoCivil":
                                persona.setEstadoCivil(columna.getValor());
                                break;
                            case "fechaNacimiento":
                                persona.setFechaNacimientoLong(new SimpleDateFormat("dd/MM/yyyy").parse(columna.getValor()).getTime());
                                break;
                            case "email":
                                persona.setCorreo1(columna.getValor());
                                break;
                            case "conyuge":
                                if (columna.getValor() != null && !columna.getValor().isEmpty()) {
                                    datos = getDatos(columna.getValor());
                                    persona.setNombreConyuge(datos.get("nombre"));
                                    persona.setApellidoConyuge(datos.get("apellido"));
                                }
                                break;
                            case "fechaExpedicion":
                                if (codigoPaquete.equals(paqueteDemografico)) {
                                    persona.setFechaExpedicionLong(new SimpleDateFormat("dd/MM/yyyy").parse(columna.getValor()).getTime());
                                }
                                break;
                            case "fechaInicioActividades":
                                if (codigoPaquete.equals(paqueteSri)) {
                                    persona.setFechaExpedicionLong(new SimpleDateFormat("yyyy-MM-dd").parse(columna.getValor()).getTime());
                                }
                                break;
                            case "condicionCiudadano":
                                if (codigoPaquete.equals(paqueteDemografico)) {
                                    persona.setCondicionCiudadano(columna.getValor());
                                }
                                break;
                            case "fechaDefuncion":
                                if (codigoPaquete.equals(paqueteDemografico)) {
                                    persona.setFechaDefuncion(columna.getValor());
                                }
                                break;
                            default:
                                break;
                        }
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            persona = null;
        }
        return persona;
    }

    public SriRuc datosSRI(SriRuc sriruc) {
        String parametro = "identificacion";
        try {
            String paqueteSri = valoresRepository.findByCode("DINARDAP_SRI").getValorString();
            String urlInterOperatividad = valoresRepository.findByCode("DINARDAP_URL").getValorString();
            String userInterOperatividad = valoresRepository.findByCode("DINARDAP_USUARIO").getValorString();
            String passInterOperatividad = valoresRepository.findByCode("DINARDAP_CLAVE").getValorString();

            JaxWsProxyFactoryBean factory = new JaxWsProxyFactoryBean();
            factory.setServiceClass(Interoperador.class);
            factory.setAddress(urlInterOperatividad);
            factory.setUsername(userInterOperatividad);
            factory.setPassword(passInterOperatividad);

            Interoperador port = (Interoperador) factory.create();
            Client client = ClientProxy.getClient(port);

            if (client != null) {
                HTTPConduit conduit = (HTTPConduit) client.getConduit();
                HTTPClientPolicy policy = new HTTPClientPolicy();
                policy.setAllowChunking(false);
                conduit.setClient(policy);

            }
            Parametro paramCodigoPaquete = new Parametro();
            paramCodigoPaquete.setNombre("codigoPaquete");
            paramCodigoPaquete.setValor(paqueteSri);

            Parametro paramIdent = new Parametro();
            paramIdent.setNombre(parametro);
            paramIdent.setValor(sriruc.getNumeroRuc());

            Parametros parametros = new Parametros();
            parametros.getParametro().add(paramCodigoPaquete);
            parametros.getParametro().add(paramIdent);

            Parametro fuenteDatos = new Parametro();
            fuenteDatos.setNombre("fuenteDatos");
            fuenteDatos.setValor("");
            parametros.getParametro().add(fuenteDatos);

            Consultar consultar = new Consultar();
            consultar.setParametros(parametros);
            ConsultarResponse response = port.consultar(consultar);

            List<Entidad> entidades = response.getPaquete().getEntidades().getEntidad();
            for (Entidad entidad : entidades) {
                //filas
                //System.out.println("Información de: " + entidad.getNombre());
                for (Fila fila : entidad.getFilas().getFila()) {
                    //columnas
                    for (Columna columna : fila.getColumnas().getColumna()) {
                        //se obtiene los valores de cada columna
                        //System.out.println(columna.getCampo() + ":" + columna.getValor());
                        switch (columna.getCampo()) {
                            case "email":
                                sriruc.setCorreo(columna.getValor());
                                break;
                            case "cargo":
                                sriruc.setCargoRepresentante(columna.getValor());
                                break;
                            case "identificacion":
                                sriruc.setIdentificacionRepresentante(columna.getValor());
                                break;
                            case "nombre":
                                sriruc.setNombreRepresentante(columna.getValor());
                                break;
                            default:
                                break;
                        }
                    }
                }
            }
        } catch (ConsultarFaultException e) {
            logger.log(Level.SEVERE, "Error: {0}", e.getMessage());
            return null;
        }
        return sriruc;
    }

    private Map<String, String> getDatos(String valor) {
        Map<String, String> map = new HashMap<>();
        String apellidos = "";
        String nombres = "";
        String[] datos = valor.split(" ");
        if (datos.length > 2) {
            for (int i = 0; i < datos.length; i++) {
                switch (i) {
                    case 0:
                    case 1:
                        apellidos = apellidos + datos[i] + " ";
                        break;
                    default:
                        nombres = nombres + datos[i] + " ";
                }
            }
        } else {
            for (int i = 0; i < datos.length; i++) {
                switch (i) {
                    case 0:
                        apellidos = apellidos + datos[i] + " ";
                        break;
                    case 1:
                        nombres = nombres + datos[i] + " ";
                        break;
                    default:
                        nombres = " ";
                }
            }
        }

        map.put("nombre", nombres.trim());
        map.put("apellido", apellidos.trim());
        return map;
    }

}
