package com.facturacion.jdbc;

import com.facturacion.entites.comprobanterespuestasri.ComprobanteSRI;
import com.facturacion.sri.util.Constantes;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Conexion {

    static SimpleDateFormat formatComprobante = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");

    public static void updateLiquidacionClaveAcceso(Long idLiquidacion, String claveAcceso) {
        Connection conn = getConnection();
        try {
            try (PreparedStatement ps = conn.prepareStatement("UPDATE flow.regp_liquidacion SET clave_acceso = ? WHERE id = ?;")) {
                ps.setString(1, claveAcceso);
                ps.setLong(2, idLiquidacion);
                ps.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    public static void updateReenvioLiquidacion(Long idLiquidacion, String infoReenvio) {
        Connection conn = getConnection();
        try {
            try (PreparedStatement ps = 
                    conn.prepareStatement("UPDATE flow.regp_liquidacion SET  parentesco_solicitante = ? WHERE id = ?;")) {
                ps.setString(1, infoReenvio);
                ps.setLong(2, idLiquidacion);
                ps.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public static void updateRenFacturaClaveAcceso(Long idRenFactura, String claveAcceso) {
        Connection conn = getConnection();
        try {
            try (PreparedStatement ps = conn.prepareStatement("UPDATE financiero.ren_factura SET  clave_acceso = ? WHERE id = ?;")) {
                ps.setString(1, claveAcceso);
                ps.setLong(2, idRenFactura);
                ps.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public static void updateNotaCreditoClaveAcceso(Long idNotaCredito, String claveAcceso) {
        Connection conn = getConnection();
        try {
            System.out.println("updateNotaCreditoClaveAcceso: "  + claveAcceso + " idNotaCredito " + idNotaCredito);
            try (PreparedStatement ps = 
                    conn.prepareStatement("UPDATE financiero.ren_nota_credito " + "SET  clave_acceso = ? WHERE id = ?;")) {
                ps.setString(1, claveAcceso);
                ps.setLong(2, idNotaCredito);
                System.out.println("ps.executeUpdate(): " + ps.executeUpdate());
            }
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public static void updateAutorizacion(String tipo, Long id, ComprobanteSRI comprobanteSRI) {
        System.out.println("tipo: " + tipo + ", id: " + id + ", comprobanteSRI: " + comprobanteSRI);
        switch (tipo) {
            case "RL":
                updateLiquidacion(id, comprobanteSRI);
                break;
            case "RF":
                updateRenFactura(id, comprobanteSRI);
                break;
            case "RN":
                updateRenNotaCredito(id, comprobanteSRI);
                break;
        }
    }

    public static void updateClaveAcceso(Long id, String tipoLiquidacion, String claveAccesoTipoLiquidacionSGR) {
        System.out.println("updateClaveAcceso ");
        switch (tipoLiquidacion) {
            case "RL":
                Conexion.updateLiquidacionClaveAcceso(id, claveAccesoTipoLiquidacionSGR);
                break;
            case "RF":
                Conexion.updateRenFacturaClaveAcceso(id, claveAccesoTipoLiquidacionSGR);
                break;
            case "RN":
                Conexion.updateNotaCreditoClaveAcceso(id, claveAccesoTipoLiquidacionSGR);
                break;
            default:
                break;
        }
    }

    public static void updateLiquidacion(Long idLiquidacion, ComprobanteSRI comprobanteSRI) {
        Connection conn = getConnection();
        try {
            Map<String, Object> datosAutorizacion = getDatosAutorizacion(comprobanteSRI);
            try (PreparedStatement ps = conn.prepareStatement("UPDATE flow.regp_liquidacion "
                    + "SET numero_autorizacion = ?, estado_ws = ? , "
                    + "mensaje_ws = ?  , fecha_autorizacion = ? " + "WHERE id = ?;")) {
                ps.setString(1, comprobanteSRI.getNumAutorizacion());
                ps.setString(2, datosAutorizacion.get("estadoWS").toString());
                ps.setString(3, datosAutorizacion.get("mensajeWS").toString());
                if (comprobanteSRI.getFechaAutorizacion() != null) {
                    ps.setTimestamp(4, new Timestamp(formatComprobante.parse(comprobanteSRI.getFechaAutorizacion()).getTime()));
                } else {
                    ps.setTimestamp(4, null);
                }
                ps.setLong(5, idLiquidacion);
                ps.executeUpdate();
            }
        } catch (SQLException | ParseException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public static void updateRenFactura(Long idRenFactura, ComprobanteSRI comprobanteSRI) {
        Connection conn = getConnection();
        try {
            Map<String, Object> datosAutorizacion = getDatosAutorizacion(comprobanteSRI);
            try ( // Now insert the row into table
                    PreparedStatement ps = conn.prepareStatement("UPDATE financiero.ren_factura "
                            + "SET numero_autorizacion = ?, estado_ws = ? , "
                            + "mensaje_ws = ?  , fecha_autorizacion = ? "
                            + "WHERE id = ?;")) {
                ps.setString(1, comprobanteSRI.getNumAutorizacion());
                ps.setString(2, datosAutorizacion.get("estadoWS").toString());
                ps.setString(3, datosAutorizacion.get("mensajeWS").toString());
                if (comprobanteSRI.getFechaAutorizacion() != null) {
                    ps.setTimestamp(4,
                            new Timestamp(formatComprobante.parse(comprobanteSRI.getFechaAutorizacion()).getTime()));
                } else {
                    ps.setTimestamp(4, null);
                }
                
                ps.setLong(5, idRenFactura);
                ps.executeUpdate();
            }
        } catch (SQLException | ParseException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    public static void updateRenNotaCredito(Long idNotaCredito, ComprobanteSRI comprobanteSRI) {
        Connection conn = getConnection();
        try {
            Map<String, Object> datosAutorizacion = getDatosAutorizacion(comprobanteSRI);
            try ( // Now insert the row into table
                    PreparedStatement ps = conn.prepareStatement("UPDATE financiero.ren_nota_credito "
                            + "SET  numero_autorizacion = ?, estado  = ?, mensaje = ?, "
                            + "fecha_autorizacion = ?  WHERE id = ?;")) {
                ps.setString(1, comprobanteSRI.getNumAutorizacion());
                ps.setString(2, datosAutorizacion.get("estadoWS").toString());
                ps.setString(3, datosAutorizacion.get("mensajeWS").toString());
                if (comprobanteSRI.getFechaAutorizacion() != null) {
                    ps.setTimestamp(4,
                            new Timestamp(formatComprobante.parse(comprobanteSRI.getFechaAutorizacion()).getTime()));
                } else {
                    ps.setTimestamp(4, null);
                }
                ps.setLong(5, idNotaCredito);
                ps.executeUpdate();
            }

        } catch (SQLException | ParseException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public static Map getDatosAutorizacion(ComprobanteSRI comprobanteSRI) {
        Map<String, Object> datosAutorizacion = new HashMap<>();
        String estado = "", mensaje = "";
        if (comprobanteSRI.getRespuestaSolicitudSRI() != null && !comprobanteSRI.getRespuestaSolicitudSRI().isEmpty()) {
            estado = (comprobanteSRI.getRespuestaSolicitudSRI().get(0).getEstado() != null
                    ? comprobanteSRI.getRespuestaSolicitudSRI().get(0).getEstado() : "");

            mensaje = (comprobanteSRI.getRespuestaSolicitudSRI().get(0).getMensaje() != null
                    ? comprobanteSRI.getRespuestaSolicitudSRI().get(0).getMensaje() : "");
        }
        if (comprobanteSRI.getRespuestaAutorizacionSRI() != null && !comprobanteSRI.getRespuestaAutorizacionSRI().isEmpty()) {
            estado = estado + ";" + (comprobanteSRI.getRespuestaAutorizacionSRI().get(0).getEstado() != null
                    ? comprobanteSRI.getRespuestaAutorizacionSRI().get(0).getEstado() : "");

            mensaje = mensaje + ";" + (comprobanteSRI.getRespuestaAutorizacionSRI().get(0).getMensaje() != null
                    ? comprobanteSRI.getRespuestaAutorizacionSRI().get(0).getMensaje() : "");
        }
        datosAutorizacion.put("estadoWS", estado);
        datosAutorizacion.put("mensajeWS", mensaje);
        return datosAutorizacion;
    }

    public static Connection getConnection() {
        try {
            Class.forName(Constantes.DRIVERCLASS);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
        Properties props = new Properties();
        props.setProperty("user", Constantes.USERDB);
        props.setProperty("password", Constantes.PASSDB);
        try {
            return DriverManager.getConnection(Constantes.URLDB, props);
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

}
