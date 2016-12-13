/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graficos;

import database.Dba;
import java.awt.Color;
import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;

/**
 *
 * @author Denisse
 */
public class GenerarGraficoFinanciero {

    String path;
    String periodo;
    String pathdb;

    public GenerarGraficoFinanciero(String path, String periodo, String pathdb) {
        this.path = path;
        this.periodo = periodo;
        this.pathdb = pathdb;
    }

    public void crear() {
        try {
            Dba db = new Dba(pathdb);
            db.conectar();
            String sql = "select IdCategoria, Nombre from Categoria";
            db.prepare(sql);
            db.query.execute();
            ResultSet rs = db.query.getResultSet();
            DefaultCategoryDataset dataset = new DefaultCategoryDataset();
            String fechai = periodo.substring(0,10)+" 00:00:00";
            String fechaf= periodo.substring(13,23)+" 00:00:00";
            while (rs.next()) {
                String sql1 = "select Monto from PagoCliente join FichaCliente on PagoCliente.IdFichaCliente=FichaCliente.IdFichaCliente"
                    + " join Reservacion  on Reservacion.IdReservacion=FichaCliente.IdReservacion join Habitacion on Reservacion.IdHabitacion="
                    + "Habitacion.IdHabitacion  where Habitacion.IdCategoria="+rs.getInt(1)+" and FichaCliente.FechaSalida>='"+fechai+"' and"
                        + " FichaCliente.FechaSalida<='"+fechaf+"'";
                db.prepare(sql1);
                db.query.execute();
                ResultSet rs1 = db.query.getResultSet();
                Double monto =0.0;
                
                while (rs1.next()) {
                    monto+=rs1.getDouble(1);
                }
                dataset.setValue(monto, "Ingresos", rs.getString(2));
            }
           
            JFreeChart chart = ChartFactory.createBarChart3D("Comparación de Ingresos por Categoría\nPeriodo:" + periodo,
                    "Categoría", "Ingresos", dataset, PlotOrientation.VERTICAL,
                    false, true, false);
             CategoryPlot p = chart.getCategoryPlot(); // Get the Plot object for a bar graph
             p.setBackgroundPaint(Color.black); 

            try {
                ChartUtilities.saveChartAsJPEG(new File(path), chart, 500, 300);
            } catch (Exception ee) {
                System.err.println(ee.toString());
                System.err.println("Problem occurred creating chart.");
            }

            db.desconectar();
        } catch (Exception e) {

        }

    }

}
