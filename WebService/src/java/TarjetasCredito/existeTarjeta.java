/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package TarjetasCredito;

import database.Dba;
import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.ResultSet;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author Denisse
 */
@WebService(serviceName = "existeTarjeta")
public class existeTarjeta {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "existeTarjeta")
    public boolean existeTarjeta(@WebParam(name = "numerotarjeta") String numerotarjeta) {
        boolean respuesta = false;
        try {
            Dba db = new Dba("C:\\Users\\Denisse\\Documents\\NetBeansProjects\\WebService\\build\\web\\Tarjetas.mdb");
            db.conectar();
            String sql = "select IdTarjeta from Tarjeta where NumeroTarjeta="+numerotarjeta;
            db.prepare(sql);
            db.query.execute();
            ResultSet rs = db.query.getResultSet();
            while (rs.next()) {
                respuesta = true;
            }
            db.desconectar();
        } catch (Exception e) {
           
        }
        return respuesta;
    }
}
