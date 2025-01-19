<%-- 
    Document   : Maquinas
    Created on : Jan 18, 2025, 3:12:12 PM
    Author     : Kirig
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
    <h1>Administración de Máquinas</h1>

    <!-- Formulario para Agregar Máquina -->
    <h2>Agregar Nueva Máquina</h2>
    <form action="ModMaquinas.jsp" method="post">
        <label for="nombre">Nombre:</label><br>
        <input type="text" id="nombre" name="nombre" required><br><br>

        <label for="tipo">Tipo:</label><br>
        <input type="text" id="tipo" name="tipo" required><br><br>

        <label for="ubicacion">Ubicación:</label><br>
        <input type="text" id="ubicacion" name="ubicacion" required><br><br>

        <label for="estado">Estado:</label><br>
        <input type="text" id="estado" name="estado" required><br><br>

        <input type="submit" value="Agregar Máquina">
    </form>

    <!-- Formulario para Modificar Máquina -->
    <h2>Modificar Máquina</h2>
    <form action="ModMaquinas.jsp" method="post">
        <label for="idMaquinaModificar">ID Máquina:</label><br>
        <input type="number" id="idMaquinaModificar" name="idMaquinaModificar" required><br><br>

        <label for="nuevoNombre">Nuevo Nombre:</label><br>
        <input type="text" id="nuevoNombre" name="nuevoNombre"><br><br>

        <label for="nuevoTipo">Nuevo Tipo:</label><br>
        <input type="text" id="nuevoTipo" name="nuevoTipo"><br><br>

        <label for="nuevaUbicacion">Nueva Ubicación:</label><br>
        <input type="text" id="nuevaUbicacion" name="nuevaUbicacion"><br><br>

        <label for="nuevoEstado">Nuevo Estado:</label><br>
        <input type="text" id="nuevoEstado" name="nuevoEstado"><br><br>

        <input type="submit" value="Modificar Máquina">
    </form>

    <!-- Formulario para Eliminar Máquina -->
    <h2>Eliminar Máquina</h2>
    <form action="ModMaquinas.jsp" method="post">
        <label for="idMaquinaEliminar">ID Máquina:</label><br>
        <input type="number" id="idMaquinaEliminar" name="idMaquinaEliminar" required><br><br>

        <input type="submit" value="Eliminar Máquina">
    </form>

    <%
        OperacionBD operacionBD = new OperacionBD();
        List<Maquina> listaMaquinas = new ArrayList<>();

        try {
            if (operacionBD.conectar()) {
                listaMaquinas = operacionBD.consultarMaquina();
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
                    <th>ID Máquina</th>
                    <th>Nombre</th>
                    <th>Tipo</th>
                    <th>Ubicación</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <% for (Maquina maquina : listaMaquinas) { %>
                    <tr>
                        <td><%= maquina.getId_maquina() %></td>
                        <td><%= maquina.getNombre() %></td>
                        <td><%= maquina.getTipo() %></td>
                        <td><%= maquina.getUbicacion() %></td>
                        <td><%= maquina.getEstado() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</body>
</html>
