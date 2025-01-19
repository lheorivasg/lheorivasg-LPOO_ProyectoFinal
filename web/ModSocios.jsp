<%-- 
    Document   : Socios
    Created on : Jan 18, 2025, 3:11:14 PM
    Author     : Kirig
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Socio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="datos.OperacionBD" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Administración de Socios</title>
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
    </style>
</head>
<body>
    <h1>Lista de Socios</h1>

    <%
        OperacionBD operacionBD = new OperacionBD();
        List<Socio> listaSocios = new ArrayList<>();

        try {
            if (operacionBD.conectar()) {
                listaSocios = operacionBD.consultarSocio();
                operacionBD.desconectar();
            } else {
                out.println("<p>Error: No se pudo conectar a la base de datos.</p>");
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    %>

    <% if (listaSocios == null || listaSocios.isEmpty()) { %>
        <p>No hay datos disponibles.</p>
    <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>ID Socio</th>
                    <th>Nombre</th>
                    <th>Fecha de Nacimiento</th>
                    <th>Teléfono</th>
                    <th>Email</th>
                    <th>Fecha de Inscripción</th>
                    <th>Membresía</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <% for (Socio socio : listaSocios) { %>
                    <tr>
                        <td><%= socio.getIdSocio() %></td>
                        <td><%= socio.getNombre() %></td>
                        <td><%= socio.getFechaNacimiento() %></td>
                        <td><%= socio.getTelefono() %></td>
                        <td><%= socio.getEmail() %></td>
                        <td><%= socio.getFechaInscripcion() %></td>
                        <td><%= socio.getMembresia() %></td>
                        <td><%= socio.getEstado() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</body>
</html>

