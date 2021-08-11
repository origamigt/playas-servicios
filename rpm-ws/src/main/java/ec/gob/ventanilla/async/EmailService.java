package ec.gob.ventanilla.async;

import ec.gob.ventanilla.conf.AppProps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.IOException;
import java.io.Serializable;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Origami
 */
@Service
public class EmailService implements Serializable {

    @Autowired
    private AppProps appProps;
    private String copiaOcultaBCC;
    private String copiaCC;
    private String contentType = CTYPE_TEXT;

    private static final String CTYPE_TEXT = "text/html; charset=utf-8";
    private static final String CTYPE_HTML = "text/html; charset=utf-8";

    @Async
    public void sendMail(String destinatario, String asunto, String mensaje) {
        try {
                      //INGRESO DE LAS PROPIEDADES DE LA CONEXION
            Properties props = new Properties();
            props.setProperty("mail.transport.protocol", "smtp");
            props.setProperty("mail.smtp.host", appProps.getHostCorreo());
            props.setProperty("mail.smtp.starttls.enable", "true");
            props.setProperty("mail.smtp.port", appProps.getPortCorreo());
            props.setProperty("mail.smtp.user", appProps.getCorreo());
            props.setProperty("mail.smtp.auth", "true");
            props.setProperty("mail.smtp.starttls.enable", "true");
            //props.setProperty("mail.smtp.ssl.trust", appProps.getHostCorreo());
            props.setProperty("mail.smtp.ssl.trust", "smtp.gmail.com");
            props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");

          //  props.setProperty("mail.debug", "true");
            //INSTANCIA DE LA SESSION
            Session session = Session.getInstance(props, null);
            //CUERPO DEL MENSAJE
            MimeMessage mimeMessage = new MimeMessage(session);
            mimeMessage.setFrom(new InternetAddress(appProps.getCorreo(), appProps.getEntidad()));
            mimeMessage.setSubject(asunto);
            mimeMessage.setSentDate(new Date());
            mimeMessage.addRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            if (copiaOcultaBCC != null) {
                mimeMessage.addRecipients(Message.RecipientType.BCC, InternetAddress.parse(copiaOcultaBCC));
            }
            if (copiaCC != null) {
                mimeMessage.addRecipients(Message.RecipientType.CC, InternetAddress.parse(copiaCC));
            }
            //TEXTO DEL MENSAJE
            MimeBodyPart texto = new MimeBodyPart();
            //texto.setText(mensaje);
            texto.setContent(mensaje, contentType);
            //CONTENEDOR DE LAS PARTES
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(texto);
            //AGREGAR MULTIPART EN CUERPO DEL MENSAJE
            mimeMessage.setContent(multipart);
            // ENVIAR MENSAJE
            Transport transport = session.getTransport("smtp");
            transport.connect(appProps.getCorreo(), appProps.getClaveCorreo());
            transport.sendMessage(mimeMessage, mimeMessage.getAllRecipients());
            transport.close();

        } catch (MessagingException | IOException ex) {
            Logger.getLogger(EmailService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

}
