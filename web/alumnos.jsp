<%-- 
    Document   : alumnos
    Created on : 9/01/2025, 06:15:13 PM
    Author     : Profesor
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Alumno"%>
<%@page import="datos.OperacionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alumnos LPOO</title>
    </head>
    <body>
        <h1>Alumnos</h1>
        <%
             OperacionBD op= new OperacionBD();
             op.conectar();
             ArrayList<Alumno> alumnos= op.consultarAlumnos();
             op.desconectar();
        %>
        
        <table border=1 width="500">
            <tr>
                <th>Matricula</th> <th>Nombre</th> <th>Edad</th>
            </tr>    
            <%                 
             for (Alumno al : alumnos) {
                     out.print("<tr><td>"+al.getMatricula()+"</td>");
                     out.print("<td>"+al.getNombre()+"</td>");
                     out.print("<td>"+al.getEdad()+"</td></tr>");
                 }
            %>
        
        <table>
            
            
        <h2>Eliminar Alumno</h2>        
        <form action="eliminarAlumno.jsp" method="post">
            
            <select name="matricula">
                <%
                    for (Alumno al : alumnos) {
                            out.print("<option>"+al.getMatricula()+"</option>");
                        }

                %>
                
            </select>
            <input type="submit" value="eliminar">
        </form>
                
                
           <h2>Agregar un Alumno</h2>
        <form action="agregarAlumno.jsp" method="post">
            Matrícula: <input type="text" name="matricula" size="15"><br><br>
            Nombre: <input type="text" name="nombre" size="15"><br><br>
            Edad: <input type="text" name="edad" size="15"><br><br>
            <input type="submit" value="agregar">            
        </form>
        
    </body>
</html>
