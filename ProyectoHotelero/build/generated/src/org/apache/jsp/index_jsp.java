package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.ResultSet;
import database.Dba;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.File;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");

    if (request.getParameter("user") != null) {
        session.setAttribute("Rol", request.getParameter("user").toString());
        if (request.getParameter("user").equals("Administrador")) {
            session.setAttribute("Id-Usuario", 2);
            session.setAttribute("Usuario", "useradmin");
            
            try {
                Dba db = new Dba(application.getRealPath("Hotel.mdb"));
                db.conectar();
                String sql = "select Last(IdCaja) from Caja";
                db.prepare(sql);
                db.query.execute();
                ResultSet rs = db.query.getResultSet();
                while (rs.next()) {
                    session.setAttribute("idcaja", rs.getInt(1));
                    
                    } db.desconectar();
                      }catch(Exception e){
                           
                     }

}else{
session.setAttribute("Id-Usuario", 3);
session.setAttribute("Usuario", "primeruser");
}
}


      out.write("\n");
      out.write("<html>\n");
      out.write("    ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "head.jsp", out, false);
      out.write("\n");
      out.write("    <head>\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"./css/index.css\">\n");
      out.write("        <title>Home</title>\n");
      out.write("    </head>\n");
      out.write("\n");
      out.write("    <body>\n");
      out.write("        ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "header.jsp", out, false);
      out.write("\n");
      out.write("        <div class=\"slides\">\n");
      out.write("            <div id=\"myCarousel\" class=\"carousel slide\" data-ride=\"carousel\">\n");
      out.write("                <!-- Wrapper for slides -->\n");
      out.write("                <div class=\"carousel-inner\" role=\"listbox\">\n");
      out.write("\n");
      out.write("                    ");

                        ServletContext context = session.getServletContext();
                        String realContextPath = context.getRealPath(request.getContextPath());
                        File file = new File(realContextPath.substring(0, realContextPath.length() - 17) + "/images/imghotel.txt");
                        FileInputStream fis = new FileInputStream(file);

                        BufferedReader br = new BufferedReader(new InputStreamReader(fis));

                        String line = null;
                        int cont = 0;
                        while ((line = br.readLine()) != null) {
                            if (cont == 0) {


                    
      out.write("\n");
      out.write("                    <div class=\"item active\">\n");
      out.write("                        ");
      out.print( line);
      out.write("\n");
      out.write("                    </div>\n");
      out.write("                    ");
          } else {
      out.write("\n");
      out.write("                    <div class=\"item\">\n");
      out.write("                        ");
      out.print( line);
      out.write("\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    ");
 }
                        cont++;
                    }
      out.write("\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "footer.jsp", out, false);
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
