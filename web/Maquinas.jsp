<%-- 
    Document   : Maquinas
    Created on : 18/01/2025, 03:06:14 PM
    Author     : max-1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Maquina"%>
<%@ page import="java.util.List" %>
<%@ page import="datos.OperacionBD" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Administración de Máquinas</title>
        <link href="estilos9.css" rel="stylesheet"> <!-- Enlace al archivo de estilos externo -->        
        
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid black;
                padding: 8px;
                text-align: center;
            }
            th {
                background-color: #f2f2f2;
            }
            form {
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>

<%
    OperacionBD operacionBD = new OperacionBD();
    List<Maquina> listaMaquinas = new ArrayList<>();

    try {
        if (operacionBD.conectar()) {
            // Suponiendo que el método consulta está en la clase Maquina y devuelve una lista de Maquina
            Maquina maquina = new Maquina();
            listaMaquinas = maquina.consultarMaquina();
            operacionBD.desconectar();
        } else {
            out.println("<p>Error: No se pudo conectar a la base de datos.</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
%>


        <% if (listaMaquinas == null || listaMaquinas.isEmpty()) { %>
        <p>No hay datos disponibles.</p>
        <% } else { %>
        <h2>Lista de Máquinas</h2>
        <table>
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Tipo</th>
                    <th>Ubicación</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <% for (Maquina maquina : listaMaquinas) {%>
                <tr>
                    <td><%= maquina.getNombre()%></td>
                    <td><%= maquina.getTipo()%></td>
                    <td><%= maquina.getUbicacion()%></td>
                    <td><%= maquina.getEstado()%></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% }%>
    </body>
</html>
