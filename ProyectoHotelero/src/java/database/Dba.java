package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;

public class Dba {
    private String base_datos;
    private Connection dbcon;
    public PreparedStatement query;
    
    public Dba(String base_datos){
        
        this.base_datos=base_datos;
    }

    public void setBase_datos(String base_datos) {
        this.base_datos = base_datos;
    }
   public void conectar(){
        try {
            Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            String driver = "jdbc:ucanaccess://";
            dbcon = DriverManager.getConnection(driver+base_datos,"","");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.toString());
        }
    }
   
   public void prepare(String sql){
        try {
            query = dbcon.prepareStatement(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
   
   public void desconectar() {
        try {
            query.close();
            dbcon.close();
        } catch (Exception e) {
        }
    }
   
   public void commit(){
       try{
           dbcon.commit();
       }catch(Exception e){
           e.printStackTrace();
       }
   }
    
    
}
