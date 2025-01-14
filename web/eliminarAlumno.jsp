<%-- 
    Document   : eliminarAlumno
    Created on : 9/01/2025, 06:50:57 PM
    Author     : Profesor
--%>

<%@page import="datos.OperacionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Alumno</title>
    </head>
    <body>
        <%
            OperacionBD op= new OperacionBD();
            op.conectar();
            String mat= request.getParameter("matricula");
            op.eliminarAlumno(mat);
            op.desconectar();
            response.sendRedirect("alumnos.jsp");


        %>
        
        
        
    </body>
</html>
