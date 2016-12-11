/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mpq;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Denisse
 */
public class EnviadorMail {
    final String miCorreo = "luismonc53@gmail.com";
    final String servidorSMTP ="smtp.gmail.com";
    final String puertoEnvio = "465";
    String mailReceptor = null;
    String asunto = null;
    String cuerpo = null;
    
    public EnviadorMail(String mailReceptor,String asunto, String cuerpo){
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

            MimeMessage msg = new MimeMessage(session);
            msg.setText(cuerpo);
            msg.setSubject(asunto);
            msg.setFrom(new InternetAddress(miCorreo));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(mailReceptor));
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
