/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graficos;

import database.Dba;
import java.io.File;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.labels.PieSectionLabelGenerator;
import org.jfree.chart.labels.StandardPieSectionLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PiePlot;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;

/**
 *
 * @author Denisse
 */
public class GenerarGraficoPromociones {

    String path;
    String pathdb;
    String idcategoria;

    public GenerarGraficoPromociones(String path, String idcategoria, String pathdb) {
        this.path = path;
        this.pathdb = pathdb;
        this.idcategoria = idcategoria;
    }

    public void crear() throws ParseException {
        DefaultPieDataset pieDataset = new DefaultPieDataset();
         ArrayList<String> reservaciones = new ArrayList();
        try {
            Dba db = new Dba(pathdb);
            db.conectar();
            String sql = "select FechaReservacion from Reservacion join Habitacion on Reservacion.IdHabitacion=Habitacion.IdHabitacion "
                    + " where Habitacion.IdCategoria="+idcategoria;
            db.prepare(sql);
            db.query.execute();
            ResultSet rs = db.query.getResultSet();
           
            while (rs.next()) {
                reservaciones.add(rs.getString(1));
            }
           db.desconectar();
        } catch (Exception e) {

        }
        ArrayList<String> promociones = new ArrayList();
        try {
            Dba db = new Dba(pathdb);
            db.conectar();
            String sql = "select Tipo, FechaInicio, FechaFin,Porcentaje from CategoriaDescuentoPromocion where IdCategoria="+idcategoria;
            db.prepare(sql);
            db.query.execute();
            ResultSet rs = db.query.getResultSet();
            while (rs.next()) {
             promociones.add(rs.getString(1)+","+rs.getString(2)+","+rs.getString(3)+","+rs.getString(4));
            }
           db.desconectar();
        } catch (Exception e) {

        }
        int []count = new int[promociones.size()+1];
            for(int i=0;i<reservaciones.size();i++){
                int si=0;
                for(int j=0;j<promociones.size();j++){
                    String []partes = promociones.get(j).split(",");
                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    Date fechain = format.parse(partes[1]);
                    Date fechafi = format.parse(partes[2]);
                    Date fechare = format.parse(reservaciones.get(i));
                    if(fechare.compareTo(fechain)>=0 && fechare.compareTo(fechafi)<=0){
                        si++;
                        count[j]++;
                    }
                }
                if(si==0){
                    count[promociones.size()]++;
                }
            }
            for(int j=0;j<count.length;j++){
                 if(j==promociones.size()){
                      pieDataset.setValue("Precio Normal", new Integer(count[j]));
                 }else{
                   String []partes = promociones.get(j).split(",");
                    pieDataset.setValue("desc: "+partes[3]+"%", new Integer(count[j]));
                 }
                
            }
         JFreeChart chart = ChartFactory.createPieChart("Porcentaje de Reservaciones Precio Normal vs Promociones y Descuentos", pieDataset, true, true, false);
          PiePlot plot = (PiePlot) chart.getPlot();
        PieSectionLabelGenerator gen = new StandardPieSectionLabelGenerator(
            "{0}: {1} ({2})", new DecimalFormat("0"), new DecimalFormat("0%"));
        plot.setLabelGenerator(gen);
         try {
                ChartUtilities.saveChartAsJPEG(new File(path), chart, 500, 300);
            } catch (Exception ee) {
                System.err.println(ee.toString());
                System.err.println("Problem occurred creating chart.");
            }
    }
}
