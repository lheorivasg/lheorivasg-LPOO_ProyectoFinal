<%-- 
    Document   : Entrenadores
    Created on : Jan 18, 2025, 3:11:28 PM
    Author     : Kirig
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.Entrenador"%>
<%@page import="datos.OperacionBD"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Administración de Entrenadores</title>
                <link rel="stylesheet" href="estilos8.css">
    </head>
    <body>
        <h1>Administración de Entrenadores</h1>


<%@ page import="datos.OperacionBD" %>
<%@ page import="modelo.Entrenador" %>
<%@ page import="java.util.List" %>


<%
    OperacionBD operacionBD = new OperacionBD();
    String mensaje = "";

    try {
        if (operacionBD.conectar()) {
            String accion = request.getParameter("accion");

            if ("agregar".equals(accion)) {
                Entrenador nuevoEntrenador = new Entrenador();
                nuevoEntrenador.setNombre(request.getParameter("nombre"));
                nuevoEntrenador.setEspecialidad(request.getParameter("especialidad"));
                nuevoEntrenador.setTelefono(request.getParameter("telefono"));
                nuevoEntrenador.setHorario(request.getParameter("horario"));
                nuevoEntrenador.setEstado(request.getParameter("estado"));

                boolean resultado = nuevoEntrenador.agregarEntrenador();
                mensaje = resultado ? "Entrenador agregado con éxito." : "Error al agregar el entrenador.";
            } else if ("eliminar".equals(accion)) {
                String idEntrenador = request.getParameter("idEntrenador");
                if (idEntrenador != null && !idEntrenador.isEmpty()) {
                    Entrenador entrenador = new Entrenador();
                    boolean resultado = entrenador.eliminarEntrenador(Integer.parseInt(idEntrenador));
                    mensaje = resultado ? "Entrenador eliminado con éxito." : "Error al eliminar el entrenador.";
                }
            } else if ("actualizar".equals(accion)) {
                Entrenador entrenadorActualizado = new Entrenador();
                entrenadorActualizado.setIdEntrenador(Integer.parseInt(request.getParameter("idEntrenadorActualizar")));
                entrenadorActualizado.setNombre(request.getParameter("nuevoNombre"));
                entrenadorActualizado.setEspecialidad(request.getParameter("nuevaEspecialidad"));
                entrenadorActualizado.setTelefono(request.getParameter("nuevoTelefono"));
                entrenadorActualizado.setHorario(request.getParameter("nuevoHorario"));
                entrenadorActualizado.setEstado(request.getParameter("nuevoEstado"));

                boolean resultado = entrenadorActualizado.actualizarEntrenador();
                mensaje = resultado ? "Entrenador actualizado con éxito." : "Error al actualizar el entrenador.";
            } else if ("consultar".equals(accion)) {
                Entrenador entrenador = new Entrenador();
                List<Entrenador> entrenadores = entrenador.consultarEntrenador();
                // Aquí puedes añadir código para mostrar la lista de entrenadores en tu página JSP
            }

            operacionBD.desconectar();
        } else {
            mensaje = "Error al conectar con la base de datos.";
        }
    } catch (Exception e) {
        mensaje = "Error: " + e.getMessage();
    }
%>








        <% if (!mensaje.isEmpty()) {%>
        <p><%= mensaje%></p>
        <% } %>

        <!-- Formulario para Agregar Entrenador -->
        <h2>Agregar Nuevo Entrenador</h2>
        <form action="ModEntrenadores.jsp" method="post">
            <input type="hidden" name="accion" value="agregar">
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" required><br><br>

            <label for="especialidad">Especialidad:</label>
            <input type="text" id="especialidad" name="especialidad" required><br><br>

            <label for="telefono">Teléfono:</label>
            <input type="text" id="telefono" name="telefono" required><br><br>

            <label for="horario">Horario:</label>
            <input type="text" id="horario" name="horario" required><br><br>

            <label for="estado">Estado:</label>
            <input type="text" id="estado" name="estado" required><br><br>

            <input type="submit" value="Agregar Entrenador">
        </form>

        <!-- Formulario para Eliminar Entrenador -->
        <h2>Eliminar Entrenador</h2>
        <form action="ModEntrenadores.jsp" method="post">
            <input type="hidden" name="accion" value="eliminar">
            <label for="idEntrenador">ID del Entrenador:</label>
            <input type="text" id="idEntrenador" name="idEntrenador" required><br><br>
            <input type="submit" value="Eliminar Entrenador">
        </form>

        <!-- Formulario para Actualizar Entrenador -->
        <h2>Actualizar Entrenador</h2>
        <form action="ModEntrenadores.jsp" method="post">
            <input type="hidden" name="accion" value="actualizar">
            <label for="idEntrenadorActualizar">ID del Entrenador:</label>
            <input type="text" id="idEntrenadorActualizar" name="idEntrenadorActualizar" required><br><br>

            <label for="nuevoNombre">Nuevo Nombre:</label>
            <input type="text" id="nuevoNombre" name="nuevoNombre"><br><br>

            <label for="nuevaEspecialidad">Nueva Especialidad:</label>
            <input type="text" id="nuevaEspecialidad" name="nuevaEspecialidad"><br><br>

            <label for="nuevoTelefono">Nuevo Teléfono:</label>
            <input type="text" id="nuevoTelefono" name="nuevoTelefono"><br><br>

            <label for="nuevoHorario">Nuevo Horario:</label>
            <input type="text" id="nuevoHorario" name="nuevoHorario"><br><br>

            <label for="nuevoEstado">Nuevo Estado:</label>
            <input type="text" id="nuevoEstado" name="nuevoEstado"><br><br>

            <input type="submit" value="Actualizar Entrenador">
        </form>

        <!-- Tabla para Mostrar Entrenadores -->
        <h2>Lista de Entrenadores</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Especialidad</th>
                    <th>Teléfono</th>
                    <th>Horario</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
<%
    OperacionBD operacionBD1 = new OperacionBD();
    String mensaje1 = "";

    try {
        if (operacionBD1.conectar()) {
            Entrenador entrenador = new Entrenador();
            List<Entrenador> listaEntrenadores = entrenador.consultarEntrenador();
            operacionBD1.desconectar();

            if (listaEntrenadores != null && !listaEntrenadores.isEmpty()) {
                for (Entrenador e : listaEntrenadores) {
%>
                <tr>
                    <td><%= e.getIdEntrenador() %></td>
                    <td><%= e.getNombre() %></td>
                    <td><%= e.getEspecialidad() %></td>
                    <td><%= e.getTelefono() %></td>
                    <td><%= e.getHorario() %></td>
                    <td><%= e.getEstado() %></td>
                </tr>
<%
                }
            } else {
%>
                <tr>
                    <td colspan="6">No hay entrenadores registrados.</td>
                </tr>
<%
            }
        } else {
            mensaje1 = "Error al conectar con la base de datos.";
        }
    } catch (Exception e) {
%>
    <tr>
        <td colspan="6">Error: <%= e.getMessage() %></td>
    </tr>
<%
    }
%>

            </tbody>
        </table>
    </body>
</html>
