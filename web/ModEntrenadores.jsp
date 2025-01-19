<%-- 
    Document   : Entrenadores
    Created on : Jan 18, 2025, 3:11:28 PM
    Author     : Kirig
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Entrenador"%>
<%@ page import="java.util.List" %>
<%@ page import="datos.OperacionBD" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Administración de Entrenadores</title>
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
    <h1>Administración de Entrenadores</h1>

    <%
        OperacionBD operacionBD = new OperacionBD();
        List<Entrenador> listaEntrenadores = new ArrayList<>();

        try {
            if (operacionBD.conectar()) {
                // Método para consultar entrenadores desde la base de datos
                listaEntrenadores = operacionBD.consultarEntrenador();
                operacionBD.desconectar();
            } else {
                out.println("<p>Error: No se pudo conectar a la base de datos.</p>");
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    %>

    <% if (listaEntrenadores == null || listaEntrenadores.isEmpty()) { %>
        <p>No hay datos disponibles.</p>
    <% } else { %>
        <h2>Lista de Entrenadores</h2>
        <table>
            <thead>
                <tr>
                    <th>ID Entrenador</th>
                    <th>Nombre</th>
                    <th>Especialidad</th>
                    <th>Teléfono</th>
                    <th>Email</th>
                    <th>Años de Experiencia</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <% for (Entrenador entrenador : listaEntrenadores) { %>
                    <tr>
                        <td><%= entrenador.getIdEntrenador() %></td>
                        <td><%= entrenador.getNombre() %></td>
                        <td><%= entrenador.getEspecialidad() %></td>
                        <td><%= entrenador.getTelefono() %></td>
                        <td><%= entrenador.getHorario() %></td>
                        <td><%= entrenador.getEstado() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</body>
</html>

