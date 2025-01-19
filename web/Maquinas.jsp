<%-- 
    Document   : Maquinas
    Created on : 18/01/2025, 03:06:14 PM
    Author     : max-1
--%>

<%@page import="modelo.Maquina"%>
<%@page import="datos.OperacionBD"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Maquinas Gym</title>
    </head>
    <body>
        <h1>Menú de Máquinas</h1>
        <h2>Lista de máquinas</h2>
        <a href="Maquinas.jsp">Maquinas</a>
        <%
            ArrayList<Maquina> listMaq = (ArrayList<Maquina>) request.getAttribute("listMaq");
            if (listMaq != null) {
        %>
        <table border="1">
            <tr>
                <th>Nombre</th>
                <th>Tipo</th>
                <th>Ubicación</th>
                <th>Estado</th>
            </tr>
            <%
                for (Maquina maquina : listMaq) {
            %>
            <tr>
                
                <td><%= maquina.getNombre()%></td>
                <td><%= maquina.getTipo()%></td>
                <td><%= maquina.getUbicacion()%></td>
                <td><%= maquina.getEstado()%></td>
            </tr>
            <%
                }
            %>
        </table>
        <%
        } else {
        %>
        <p>No se encontraron máquinas disponibles.</p>
        <%
            }
        %>

    </body>

</html>
