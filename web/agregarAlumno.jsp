<%-- 
    Document   : agregarAlumno
    Created on : 9/01/2025, 07:04:07 PM
    Author     : Profesor
--%>

<%@page import="modelo.Alumno"%>
<%@page import="datos.OperacionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       
        <%
            OperacionBD op= new OperacionBD();
            op.conectar();
            //if(!request.getParameter("matricula").equals("") && !request.getParameter("nombre").equals("") && !request.getParameter("edad").equals("")){
                String mat= request.getParameter("matricula");
                String nom= request.getParameter("nombre");
                int edad= Integer.parseInt(request.getParameter("edad"));
                Alumno al= new Alumno(mat,nom,edad);
                op.agregarAlumno(al);
            //}
           
            op.desconectar();
            response.sendRedirect("alumnos.jsp");

        %>
        
        
    </body>
</html>
