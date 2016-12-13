/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mpq;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**
 *
 * @author Denisse
 */
public class EnviadorMailArchivo {
    final String miCorreo = "luismonc53@gmail.com";
    final String servidorSMTP ="smtp.gmail.com";
    final String puertoEnvio = "465";
    String mailReceptor = null;
    String asunto = null;
    String cuerpo = null;
    
    public EnviadorMailArchivo(String mailReceptor,String asunto, String cuerpo, FileDataSource fds){
        this.mailReceptor = mailReceptor;
        this.asunto=asunto;
        this.cuerpo=cuerpo;
        Properties props = new Properties();
        props.put("mail.smtp.user", miCorreo);
        props.put("mail.smtp.host", servidorSMTP);
        props.put("mail.smtp.port", puertoEnvio);
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.debug", "true");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.socketFactory.port", puertoEnvio);
        props.put("mail.smtp.socketFactory.class", "javaz.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "false");
        SecurityManager security = System.getSecurityManager();
        try{
            //Authenticator auth = new autentificadorSMTP();
            Session session = Session.getInstance(props, new javax.mail.Authenticator() {
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication("luismonc53@gmail.com", "donatila");
    }
});
            session.setDebug(true);
            BodyPart texto = new MimeBodyPart();
            texto.setText(cuerpo);
            BodyPart adjunto = new MimeBodyPart();
            adjunto.setDataHandler(new DataHandler(fds));
            adjunto.setFileName("Factura.pdf");
            MimeMultipart multiParte = new MimeMultipart();
            multiParte.addBodyPart(texto);
            multiParte.addBodyPart(adjunto);
            
            MimeMessage msg = new MimeMessage(session);
            msg.setSubject(asunto);
            msg.setFrom(new InternetAddress(miCorreo));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(mailReceptor));
            msg.setContent(multiParte);
            //Transport.send(msg);
            Transport transport = session.getTransport("smtps");
            transport.connect(servidorSMTP,Integer.parseInt(puertoEnvio),"luismonc53@gmail.com","luismonc53@gmail.com");
            transport.sendMessage(msg, msg.getAllRecipients());
            transport.close();
        }catch(Exception mex){
            mex.printStackTrace();
            System.err.println("error:"+mex.toString());
        }
        
    }
}

