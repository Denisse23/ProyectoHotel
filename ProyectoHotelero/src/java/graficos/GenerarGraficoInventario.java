/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graficos;

import database.Dba;
import java.awt.Color;
import java.io.File;
import java.sql.ResultSet;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.renderer.category.StandardBarPainter;
import org.jfree.data.category.DefaultCategoryDataset;

/**
 *
 * @author Denisse
 */
public class GenerarGraficoInventario {
    String path;
    String pathdb;

    public GenerarGraficoInventario(String path, String pathdb) {
        this.path = path;
        this.pathdb = pathdb;
    }

    public void crear() {
        try {
            Dba db = new Dba(pathdb);
            db.conectar();
            String sql = "select Nombre, CantidadDisponibles, CantidadEnUso from Activos";
            db.prepare(sql);
            db.query.execute();
            ResultSet rs = db.query.getResultSet();
            DefaultCategoryDataset dataset = new DefaultCategoryDataset();
            while (rs.next()) {
                int total = rs.getInt(2) + rs.getInt(3);
                dataset.setValue(total, "Cantidad", rs.getString(1));
            }
           
            JFreeChart chart = ChartFactory.createBarChart3D("Inventario de Activos del Hotel",
                    "Activo", "Cantidad", dataset, PlotOrientation.VERTICAL,
                    false, true, false);
             CategoryPlot p = chart.getCategoryPlot(); // Get the Plot object for a bar graph
             p.setBackgroundPaint(Color.black); 
             ((BarRenderer)p.getRenderer()).setBarPainter(new StandardBarPainter());

              BarRenderer r = (BarRenderer)chart.getCategoryPlot().getRenderer();
              r.setSeriesPaint(0, Color.BLUE);

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
