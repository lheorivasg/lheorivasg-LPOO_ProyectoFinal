<%-- 
    Document   : Socios
    Created on : Jan 18, 2025, 3:11:14 PM
    Author     : Kirig
--%>

<%@page import="java.util.List"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="modelo.Socio"%>
<%@page import="datos.OperacionBD"%>
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

    <% 
        OperacionBD operacionBD = new OperacionBD();
        String mensaje = "";

        try {
            if (operacionBD.conectar()) {
                // Parámetros del formulario
                String accion = request.getParameter("accion");
                if ("agregar".equals(accion)) {
                    // Agregar socio
                    String nombre = request.getParameter("nombre");
                    String fechaNacimientoStr = request.getParameter("fechaNacimiento");
                    String telefono = request.getParameter("telefono");
                    String email = request.getParameter("email");
                    String fechaInscripcionStr = request.getParameter("fechaInscripcion");
                    String membresia = request.getParameter("membresia");
                    String estado = request.getParameter("estado");

                    if (nombre != null && fechaNacimientoStr != null && fechaInscripcionStr != null) {
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                        LocalDate fechaNacimiento = LocalDate.parse(fechaNacimientoStr, formatter);
                        LocalDate fechaInscripcion = LocalDate.parse(fechaInscripcionStr, formatter);

                        Socio nuevoSocio = new Socio();
                        nuevoSocio.setNombre(nombre);
                        nuevoSocio.setFechaNacimiento(fechaNacimiento);
                        nuevoSocio.setTelefono(telefono);
                        nuevoSocio.setEmail(email);
                        nuevoSocio.setFechaInscripcion(fechaInscripcion);
                        nuevoSocio.setMembresia(membresia);
                        nuevoSocio.setEstado(estado);

                        boolean agregado = operacionBD.agregarSocio(nuevoSocio);
                        mensaje = agregado ? "Socio agregado con éxito." : "Error al agregar el socio.";
                    }
                } else if ("eliminar".equals(accion)) {
                    // Eliminar socio
                    String idSocio = request.getParameter("idSocio");
                    if (idSocio != null && !idSocio.isEmpty()) {
                        boolean eliminado = operacionBD.eliminarSocio(idSocio);
                        mensaje = eliminado ? "Socio eliminado con éxito." : "Error al eliminar el socio.";
                    }
                } else if ("actualizar".equals(accion)) {
                    // Actualizar socio
                    String idSocio = request.getParameter("idSocioActualizar");
                    String nombre = request.getParameter("nuevoNombre");
                    String fechaNacimientoStr = request.getParameter("nuevaFechaNacimiento");
                    String telefono = request.getParameter("nuevoTelefono");
                    String email = request.getParameter("nuevoEmail");
                    String fechaInscripcionStr = request.getParameter("nuevaFechaInscripcion");
                    String membresia = request.getParameter("nuevaMembresia");
                    String estado = request.getParameter("nuevoEstado");

                    if (idSocio != null && !idSocio.isEmpty()) {
                        Socio socioActualizado = new Socio();
                        socioActualizado.setIdSocio(idSocio);
                        socioActualizado.setNombre(nombre);
                        socioActualizado.setFechaNacimiento(fechaNacimientoStr != null && !fechaNacimientoStr.isEmpty()
                                ? LocalDate.parse(fechaNacimientoStr) : null);
                        socioActualizado.setTelefono(telefono);
                        socioActualizado.setEmail(email);
                        socioActualizado.setFechaInscripcion(fechaInscripcionStr != null && !fechaInscripcionStr.isEmpty()
                                ? LocalDate.parse(fechaInscripcionStr) : null);
                        socioActualizado.setMembresia(membresia);
                        socioActualizado.setEstado(estado);

                        boolean actualizado = operacionBD.actualizarSocio(socioActualizado);
                        mensaje = actualizado ? "Socio actualizado con éxito." : "Error al actualizar el socio.";
                    }
                }
                operacionBD.desconectar();
            } else {
                mensaje = "Error al conectar con la base de datos.";
            }
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
        }
    %>

    <!-- Mostrar mensaje de resultado -->
    <% if (!mensaje.isEmpty()) { %>
        <p><%= mensaje %></p>
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

        <input type="submit" value="Agregar Socio">
    </form>

    <!-- Formulario para Eliminar Socio -->
    <h2>Eliminar Socio</h2>
    <form action="ModSocios.jsp" method="post">
        <input type="hidden" name="accion" value="eliminar">
        <label for="idSocio">ID del Socio:</label>
        <input type="number" id="idSocio" name="idSocio" required><br><br>
        <input type="submit" value="Eliminar Socio">
    </form>

    <!-- Formulario para Actualizar Socio -->
    <h2>Actualizar Socio</h2>
    <form action="ModSocios.jsp" method="post">
        <input type="hidden" name="accion" value="actualizar">
        <label for="idSocioActualizar">ID del Socio:</label>
        <input type="number" id="idSocioActualizar" name="idSocioActualizar" required><br><br>

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
            </tr>
        </thead>
        <tbody>
            <% 
                try {
                    if (operacionBD.conectar()) {
                        List<Socio> listaSocios = operacionBD.consultarSocio();
                        operacionBD.desconectar();

                        if (listaSocios != null && !listaSocios.isEmpty()) {
                            for (Socio socio : listaSocios) { %>
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
            <%              }
                        } else { %>
                            <tr>
                                <td colspan="8">No hay socios registrados.</td>
                            </tr>
            <%          }
                    }
                } catch (Exception e) { %>
                    <tr>
                        <td colspan="8">Error: <%= e.getMessage() %></td>
                    </tr>
            <%  } %>
        </tbody>
    </table>
</body>
</html>
