package ec.gob.ventanilla.util;


import ec.gob.ventanilla.conf.AppProps;
import org.postgresql.largeobject.LargeObject;
import org.postgresql.largeobject.LargeObjectManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.*;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

@Service
public class OmegaUploader {

    @Autowired
    private AppProps appProps;

    public Boolean streamFile(Long oid, OutputStream out, String jdbc) {
        Boolean flag = false;
        LargeObjectManager lobj;
        LargeObject obj = null;
        Connection conn = getConnection(jdbc);
        try {
            // All LargeObject API calls must be within a transaction block
            if (conn == null) {
                return false;
            }
            conn.setAutoCommit(false);
            // Get the Large Object Manager to perform operations with
            lobj = ((org.postgresql.PGConnection) conn).getLargeObjectAPI();
            try {
                obj = lobj.open(oid, LargeObjectManager.READ);
            } catch (SQLException e) {
                System.out.println(e);
                flag = false;
            }
            if (obj != null) {
                flag = true;
            } else {
                return false;
            }
            byte buf[] = new byte[2048];
            int s, tl = 0;
            while ((s = obj.read(buf, 0, 2048)) > 0) {
                out.write(buf, 0, s);
                tl += s;

            }
            out.flush();
            obj.close();
            conn.commit();
        } catch (SQLException | IOException ex) {
            flag = false;
            Logger.getLogger(OmegaUploader.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                flag = false;
                Logger.getLogger(OmegaUploader.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return flag;
    }

    public Long uploadFile(InputStream stream, String nombre, String contentType, String jdbc) {

        Connection conn = getConnection(jdbc);
        Long oid = null;

        try {
            // All LargeObject API calls must be within a transaction block
            conn.setAutoCommit(false);
            // Get the Large Object Manager to perform operations with
            LargeObjectManager lobj = ((org.postgresql.PGConnection) conn).getLargeObjectAPI();
            // Create a new large object
            oid = lobj.createLO(LargeObjectManager.READ | LargeObjectManager.WRITE);
            // Open the large object for writing
            LargeObject obj = lobj.open(oid, LargeObjectManager.WRITE);

            // Copy the data from the file to the large object
            byte buf[] = new byte[2048];
            int s, tl = 0;
            while ((s = stream.read(buf, 0, 2048)) > 0) {
                obj.write(buf, 0, s);
                tl += s;
            }

            // Close the large object
            obj.close();

            // Now insert the row into table
            PreparedStatement ps = conn.prepareStatement("INSERT INTO archivos.doc_file VALUES (?, ?, ?, ?, ?)");
            ps.setLong(1, oid);
            ps.setString(2, nombre);
            ps.setBoolean(3, false);
            ps.setTimestamp(4, new Timestamp((new Date()).getTime()));
            ps.setString(5, contentType);
            ps.executeUpdate();
            ps.close();
            stream.close();

            // Finally, commit the transaction.
            conn.commit();

        } catch (SQLException | IOException ex) {
            Logger.getLogger(OmegaUploader.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(OmegaUploader.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return oid;
    }

    public Connection getConnection(String jdbc) {
        try {
            Class.forName(SisVars.docDriverClass);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(OmegaUploader.class.getName()).log(Level.SEVERE, null, ex);
        }
        Properties props = new Properties();
        props.setProperty("user", appProps.getDbDocUser());
        props.setProperty("password", appProps.getDbDocPass());
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(jdbc, props);
        } catch (SQLException ex) {
            Logger.getLogger(OmegaUploader.class.getName()).log(Level.SEVERE, null, ex);
        }
        return conn;
    }

}
