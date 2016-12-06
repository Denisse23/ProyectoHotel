<%-- 
    Document   : newjsp
    Created on : 5/12/2016, 04:16:40 PM
    Author     : Denisse
--%>

<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                                                    Date date = format.parse(request.getParameter("date-fecha-llegada"));
                                                    out.print("<script>alert('"+date+"');</script>");
    %>