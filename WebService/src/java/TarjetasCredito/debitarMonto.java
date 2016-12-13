/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package TarjetasCredito;

import database.Dba;
import java.sql.ResultSet;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author Denisse
 */
@WebService(serviceName = "debitarMonto")
public class debitarMonto {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "dibitarMonto")
    public boolean debitarMonto(@WebParam(name = "numerotarjeta") String numerotarjeta,
            @WebParam(name = "monto") String monto) {
        boolean respuesta = false;
        try {
            Dba db = new Dba("C:\\Users\\Denisse\\Documents\\NetBeansProjects\\WebService\\build\\web\\Tarjetas.mdb");
            db.conectar();
            String sql = "select CreditoAFavor from Tarjeta where NumeroTarjeta="+numerotarjeta;
            db.prepare(sql);
            db.query.execute();
            ResultSet rs = db.query.getResultSet();
            while (rs.next()) {
                if(rs.getDouble(1)>=Double.parseDouble(monto)){
                    respuesta = true;
                    String sql1 = "update Tarjeta set CreditoAFavor=? where NumeroTarjeta="+numerotarjeta;
                    db.prepare(sql1);
                    db.query.setString(1,(rs.getDouble(1)-Double.parseDouble(monto))+"" );
                    db.query.executeUpdate();
                    db.commit();
                }
            }
            
            db.desconectar();
        } catch (Exception e) {
           
        }
        return respuesta;
    }
}
