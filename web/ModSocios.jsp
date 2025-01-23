<%-- 
    Document   : Socios
    Created on : Jan 18, 2025, 3:11:14 PM
    Author     : Kirig
--%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Socio"%>
<%@page import="datos.OperacionBD"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Administración de Socios</title>
        <!-- Enlazamos el archivo CSS -->
        <link rel="stylesheet" href="estilos8.css">
    </head>
    <body>
        <h1>Administración de Socios</h1>

<%
    OperacionBD operacionBD = new OperacionBD();
    String mensaje = "";

    try {
        if (operacionBD.conectar()) {
            String accion = request.getParameter("accion");
            Socio socioBD = new Socio();

            if ("agregar".equals(accion)) {
                // Agregar socio
                Socio nuevoSocio = new Socio();
                nuevoSocio.setNombre(request.getParameter("nombre"));
                nuevoSocio.setFechaNacimiento(LocalDate.parse(request.getParameter("fechaNacimiento")));
                nuevoSocio.setTelefono(request.getParameter("telefono"));
                nuevoSocio.setEmail(request.getParameter("email"));
                nuevoSocio.setFechaInscripcion(LocalDate.parse(request.getParameter("fechaInscripcion")));
                nuevoSocio.setTipoMembresia(request.getParameter("membresia"));
                nuevoSocio.setEstado(request.getParameter("estado"));
                nuevoSocio.setDuracion(request.getParameter("duracion"));

                boolean resultado = socioBD.agregarSocio(nuevoSocio);
                mensaje = resultado ? "Socio agregado con éxito." : "Error al agregar el socio.";
            } else if ("eliminar".equals(accion)) {
                // Eliminar socio
                String idSocio = request.getParameter("idSocio");
                if (idSocio != null && !idSocio.isEmpty()) {
                    boolean resultado = socioBD.eliminarSocio(idSocio);
                    mensaje = resultado ? "Socio eliminado con éxito." : "Error al eliminar el socio.";
                }
            } else if ("actualizar".equals(accion)) {
                // Actualizar socio
                Socio socioActualizado = new Socio();
                socioActualizado.setIdSocio(request.getParameter("idSocioActualizar"));
                socioActualizado.setNombre(request.getParameter("nuevoNombre"));
                socioActualizado.setFechaNacimiento(LocalDate.parse(request.getParameter("nuevaFechaNacimiento")));
                socioActualizado.setTelefono(request.getParameter("nuevoTelefono"));
                socioActualizado.setEmail(request.getParameter("nuevoEmail"));
                socioActualizado.setFechaInscripcion(LocalDate.parse(request.getParameter("nuevaFechaInscripcion")));
                socioActualizado.setTipoMembresia(request.getParameter("nuevaMembresia"));
                socioActualizado.setEstado(request.getParameter("nuevoEstado"));
                socioActualizado.setDuracion(request.getParameter("nuevoDuracion"));

                boolean resultado = socioBD.actualizarSocio(socioActualizado);
                mensaje = resultado ? "Socio actualizado con éxito." : "Error al actualizar el socio.";
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

        <!-- Formulario para Agregar Socio -->
        <h2>Agregar Nuevo Socio</h2>
        <form action="ModSocios.jsp" method="post">
            <input type="hidden" name="accion" value="agregar">
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" required><br><br>

            <label for="fechaNacimiento">Fecha de Nacimiento:</label>
            <input type="date" id="fechaNacimiento" name="fechaNacimiento" required><br><br>

            <label for="telefono">Teléfono:</label>
            <input type="text" id="telefono" name="telefono" required><br><br>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required><br><br>

            <label for="fechaInscripcion">Fecha de Inscripción:</label>
            <input type="date" id="fechaInscripcion" name="fechaInscripcion" required><br><br>

            <label for="membresia">Membresía:</label>
            <input type="text" id="membresia" name="membresia" required><br><br>

            <label for="estado">Estado:</label>
            <input type="text" id="estado" name="estado" required><br><br>

            <label for="duracion">Duración:</label>
            <input type="text" id="duracion" name="duracion" required><br><br>

            <input type="submit" value="Agregar Socio">
        </form>

        <!-- Formulario para Eliminar Socio -->
        <h2>Eliminar Socio</h2>
        <form action="ModSocios.jsp" method="post">
            <input type="hidden" name="accion" value="eliminar">
            <label for="idSocio">ID del Socio:</label>
            <input type="text" id="idSocio" name="idSocio" required><br><br>
            <input type="submit" value="Eliminar Socio">
        </form>

        <!-- Formulario para Actualizar Socio -->
        <h2>Actualizar Socio</h2>
        <form action="ModSocios.jsp" method="post">
            <input type="hidden" name="accion" value="actualizar">
            <label for="idSocioActualizar">ID del Socio:</label>
            <input type="text" id="idSocioActualizar" name="idSocioActualizar" required><br><br>

            <label for="nuevoNombre">Nuevo Nombre:</label>
            <input type="text" id="nuevoNombre" name="nuevoNombre"><br><br>

            <label for="nuevaFechaNacimiento">Nueva Fecha de Nacimiento:</label>
            <input type="date" id="nuevaFechaNacimiento" name="nuevaFechaNacimiento"><br><br>

            <label for="nuevoTelefono">Nuevo Teléfono:</label>
            <input type="text" id="nuevoTelefono" name="nuevoTelefono"><br><br>

            <label for="nuevoEmail">Nuevo Email:</label>
            <input type="email" id="nuevoEmail" name="nuevoEmail"><br><br>

            <label for="nuevaFechaInscripcion">Nueva Fecha de Inscripción:</label>
            <input type="date" id="nuevaFechaInscripcion" name="nuevaFechaInscripcion"><br><br>

            <label for="nuevaMembresia">Nueva Membresía:</label>
            <input type="text" id="nuevaMembresia" name="nuevaMembresia"><br><br>

            <label for="nuevoEstado">Nuevo Estado:</label>
            <input type="text" id="nuevoEstado" name="nuevoEstado"><br><br>

            <label for="nuevoDuracion">Duración:</label>
            <input type="text" id="nuevoDuracion" name="nuevoDuracion"><br><br>

            <input type="submit" value="Actualizar Socio">
        </form>

        <!-- Tabla para Mostrar Socios -->
        <h2>Lista de Socios</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Fecha de Nacimiento</th>
                    <th>Teléfono</th>
                    <th>Email</th>
                    <th>Fecha de Inscripción</th>
                    <th>Membresía</th>
                    <th>Estado</th>
                    <th>Duración</th>
                </tr>
            </thead>
            <tbody>
<%
    OperacionBD operacionBD1 = new OperacionBD();
    String mensaje1 = "";

    try {
        if (operacionBD.conectar()) {
            Socio socioBD = new Socio();
            List<Socio> listaSocios = socioBD.consultarSocio();
            operacionBD.desconectar();

            if (listaSocios != null && !listaSocios.isEmpty()) {
                for (Socio socio : listaSocios) {
%>
                    <tr>
                        <td><%= socio.getIdSocio() %></td>
                        <td><%= socio.getNombre() %></td>
                        <td><%= socio.getFechaNacimiento() %></td>
                        <td><%= socio.getTelefono() %></td>
                        <td><%= socio.getEmail() %></td>
                        <td><%= socio.getFechaInscripcion() %></td>
                        <td><%= socio.getTipoMembresia() %></td>
                        <td><%= socio.getEstado() %></td>
                        <td><%= socio.getDuracion() %></td>
                    </tr>
<%
                }
            } else {
%>
                <tr>
                    <td colspan="9">No hay socios registrados.</td>
                </tr>
<%
            }
        }
    } catch (Exception e) {
%>
        <tr>
            <td colspan="9">Error: <%= e.getMessage() %></td>
        </tr>
<%
    }
%>

            </tbody>
        </table>
    </body>
</html>
