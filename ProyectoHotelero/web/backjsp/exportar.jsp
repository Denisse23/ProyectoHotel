<%-- 
    Document   : exportar
    Created on : 13/12/2016, 12:37:34 AM
    Author     : Denisse
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page import="org.jdom.output.Format"%>
<%@page import="java.io.Writer"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.jdom.Document"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="org.jdom.output.XMLOutputter"%>
<%@page import="org.jdom.Element"%>

<%
    if (request.getParameter("button-exporta") != null) {
        response.setContentType("text/xml;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"Hotel.xml\"");
        Writer writer = response.getWriter();
        writer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        Element raiz = new Element("Hotel");
        Element informacion = new Element("Informacion");
        try {
            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
            db.conectar();
            String sql = "select Nombre, Mision, Vision, Telefono, Email, Pais, Ciudad, Ubicacion from Informacion";
            db.prepare(sql);
            db.query.execute();
            ResultSet rs = db.query.getResultSet();
            while (rs.next()) {
                informacion.setAttribute("Nombre", rs.getString(1));
                informacion.setAttribute("Mision", rs.getString(2));
                informacion.setAttribute("Vision", rs.getString(3));
                informacion.setAttribute("Telefono", rs.getString(4));
                informacion.setAttribute("Email", rs.getString(5));
                informacion.setAttribute("Pais", rs.getString(6));
                informacion.setAttribute("Ciudad", rs.getString(7));
                informacion.setAttribute("Ubicacion", rs.getString(8));
            }
            db.desconectar();
        } catch (Exception e) {
        }
        raiz.addContent(informacion);
        Element Categorias = new Element("Categorias");
        try {
            Dba db = new Dba(application.getRealPath("Hotel.mdb"));
            db.conectar();
            String sql = "select IdCategoria, Nombre, Precio  from Categoria";
            db.prepare(sql);
            db.query.execute();
            ResultSet rs = db.query.getResultSet();
            while (rs.next()) {
                Element Categoria = new Element("Categoria");

                Categoria.setAttribute("IdCategoria", rs.getString(1));
                Categoria.setAttribute("Nombre", rs.getString(2));
                Categoria.setAttribute("Precio", rs.getString(3));
                
                String sql1 = "select IdHabitacion, IdCategoria, Habilitada  from Habitacion where IdCategoria="+rs.getString(1);
                db.prepare(sql1);
                db.query.execute();
                ResultSet rs1 = db.query.getResultSet();
                Element Habitaciones = new Element("Habitaciones");
                while (rs1.next()) {
                   Element Habitacion = new Element("Habitacion"); 
                   Habitacion.setAttribute("IdHabitacion", rs1.getString(1));
                   Habitacion.setAttribute("IdCategoria", rs1.getString(2));
                   Habitacion.setAttribute("Habilitada", rs1.getString(3));
                   Habitaciones.addContent(Habitacion);
                }
                String sql2 = "select IdServicio, Nombre,Precio  from Servicio join CategoriaServicio on Servicio.IdServicio"
                        + "=CategoriaServicio.IdServicio where IdCategoria="+rs.getString(1);
                db.prepare(sql2);
                db.query.execute();
                ResultSet rs2 = db.query.getResultSet();
                Element Servicios = new Element("Servicios");
                while (rs2.next()) {
                   Element Servicio = new Element("Servicio"); 
                   Servicio.setAttribute("IdServicio", rs2.getString(1));
                   Servicio.setAttribute("Nombre", rs2.getString(2));
                   Servicio.setAttribute("Precio", rs2.getString(3));
                   Servicios.addContent(Servicio);
                }
                Categoria.addContent(Habitaciones);
                Categoria.addContent(Servicios);
                Categorias.addContent(Categoria);
            }
            db.desconectar();
        } catch (Exception e) {
        }
        raiz.addContent(Categorias);
        XMLOutputter outputter = new XMLOutputter();
        try {
            outputter.output(raiz, writer);

        } catch (Exception e) {
            e.getMessage();
        }
        //writer.close();

    }


%>




