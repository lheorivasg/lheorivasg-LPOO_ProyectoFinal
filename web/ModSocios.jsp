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
        form {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <h1>Administración de Socios</h1>

    <!-- Formulario para Agregar Socio -->
    <h2>Agregar Nuevo Socio</h2>
    <form action="ModSocios.jsp" method="post">
        <label for="nombre">Nombre:</label><br>
        <input type="text" id="nombre" name="nombre" required><br><br>

        <label for="fechaNacimiento">Fecha de Nacimiento:</label><br>
        <input type="date" id="fechaNacimiento" name="fechaNacimiento" required><br><br>

        <label for="telefono">Teléfono:</label><br>
        <input type="text" id="telefono" name="telefono" required><br><br>

        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" required><br><br>

        <label for="fechaInscripcion">Fecha de Inscripción:</label><br>
        <input type="date" id="fechaInscripcion" name="fechaInscripcion" required><br><br>

        <label for="membresia">Membresía:</label><br>
        <input type="text" id="membresia" name="membresia" required><br><br>

        <label for="estado">Estado:</label><br>
        <input type="text" id="estado" name="estado" required><br><br>

        <input type="submit" value="Agregar Socio">
    </form>

    <!-- Formulario para Modificar Socio -->
    <h2>Modificar Socio</h2>
    <form action="ModSocios.jsp" method="post">
        <label for="idSocioModificar">ID Socio:</label><br>
        <input type="number" id="idSocioModificar" name="idSocioModificar" required><br><br>

        <label for="nuevoNombre">Nuevo Nombre:</label><br>
        <input type="text" id="nuevoNombre" name="nuevoNombre"><br><br>

        <label for="nuevaFechaNacimiento">Nueva Fecha de Nacimiento:</label><br>
        <input type="date" id="nuevaFechaNacimiento" name="nuevaFechaNacimiento"><br><br>

        <label for="nuevoTelefono">Nuevo Teléfono:</label><br>
        <input type="text" id="nuevoTelefono" name="nuevoTelefono"><br><br>

        <label for="nuevoEmail">Nuevo Email:</label><br>
        <input type="email" id="nuevoEmail" name="nuevoEmail"><br><br>

        <label for="nuevaFechaInscripcion">Nueva Fecha de Inscripción:</label><br>
        <input type="date" id="nuevaFechaInscripcion" name="nuevaFechaInscripcion"><br><br>

        <label for="nuevaMembresia">Nueva Membresía:</label><br>
        <input type="text" id="nuevaMembresia" name="nuevaMembresia"><br><br>

        <label for="nuevoEstado">Nuevo Estado:</label><br>
        <input type="text" id="nuevoEstado" name="nuevoEstado"><br><br>

        <input type="submit" value="Modificar Socio">
    </form>

    <!-- Formulario para Eliminar Socio -->
    <h2>Eliminar Socio</h2>
    <form action="ModSocios.jsp" method="post">
        <label for="idSocioEliminar">ID Socio:</label><br>
        <input type="number" id="idSocioEliminar" name="idSocioEliminar" required><br><br>

        <input type="submit" value="Eliminar Socio">
    </form>

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
        <h2>Lista de Socios</h2>
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
