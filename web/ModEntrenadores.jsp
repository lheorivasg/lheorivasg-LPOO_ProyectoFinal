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

    <!-- Formulario para Agregar Entrenador -->
    <h2>Agregar Nuevo Entrenador</h2>
    <form action="ModEntrenadores.jsp" method="post">
        <label for="nombre">Nombre:</label><br>
        <input type="text" id="nombre" name="nombre" required><br><br>

        <label for="especialidad">Especialidad:</label><br>
        <input type="text" id="especialidad" name="especialidad" required><br><br>

        <label for="telefono">Teléfono:</label><br>
        <input type="text" id="telefono" name="telefono" required><br><br>

        <label for="horario">Horario:</label><br>
        <input type="text" id="horario" name="horario" required><br><br>

        <label for="estado">Estado:</label><br>
        <input type="text" id="estado" name="estado" required><br><br>

        <input type="submit" value="Agregar Entrenador">
    </form>

    <!-- Formulario para Modificar Entrenador -->
    <h2>Modificar Entrenador</h2>
    <form action="ModEntrenadores.jsp" method="post">
        <label for="idEntrenadorModificar">ID Entrenador:</label><br>
        <input type="text" id="idEntrenadorModificar" name="idEntrenadorModificar" required><br><br>

        <label for="nuevoNombre">Nuevo Nombre:</label><br>
        <input type="text" id="nuevoNombre" name="nuevoNombre"><br><br>

        <label for="nuevaEspecialidad">Nueva Especialidad:</label><br>
        <input type="text" id="nuevaEspecialidad" name="nuevaEspecialidad"><br><br>

        <label for="nuevoTelefono">Nuevo Teléfono:</label><br>
        <input type="text" id="nuevoTelefono" name="nuevoTelefono"><br><br>

        <label for="nuevoHorario">Nuevo Horario:</label><br>
        <input type="text" id="nuevoHorario" name="nuevoHorario"><br><br>

        <label for="nuevoEstado">Nuevo Estado:</label><br>
        <input type="text" id="nuevoEstado" name="nuevoEstado"><br><br>

        <input type="submit" value="Modificar Entrenador">
    </form>

    <!-- Formulario para Eliminar Entrenador -->
    <h2>Eliminar Entrenador</h2>
    <form action="ModEntrenadores.jsp" method="post">
        <label for="idEntrenadorEliminar">ID Entrenador:</label><br>
        <input type="text" id="idEntrenadorEliminar" name="idEntrenadorEliminar" required><br><br>

        <input type="submit" value="Eliminar Entrenador">
    </form>

    <%
        OperacionBD operacionBD = new OperacionBD();
        List<Entrenador> listaEntrenadores = new ArrayList<>();

        try {
            if (operacionBD.conectar()) {
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
                    <th>Horario</th>
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
