<%-- 
    Document   : Socios
    Created on : Jan 18, 2025, 3:11:14 PM
    Author     : Kirig
--%>
<%@page import="java.util.List"%>
<%@page import="modelo.Socio"%>
<%@page import="datos.OperacionBD"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Administraci�n de Socios</title>
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
    <h1>Administraci�n de Socios</h1>

    <% 
        OperacionBD operacionBD = new OperacionBD();
        String mensaje = "";

        try {
            if (operacionBD.conectar()) {
                String accion = request.getParameter("accion");

                if ("agregar".equals(accion)) {
                    Socio nuevoSocio = new Socio();
                    nuevoSocio.setNombre(request.getParameter("nombre"));
                    nuevoSocio.setFechaNacimiento(java.time.LocalDate.parse(request.getParameter("fechaNacimiento")));
                    nuevoSocio.setTelefono(request.getParameter("telefono"));
                    nuevoSocio.setEmail(request.getParameter("email"));
                    nuevoSocio.setFechaInscripcion(java.time.LocalDate.parse(request.getParameter("fechaInscripcion")));
                    nuevoSocio.setMembresia(request.getParameter("membresia"));
                    nuevoSocio.setEstado(request.getParameter("estado"));

                    boolean resultado = operacionBD.agregarSocio(nuevoSocio);
                    mensaje = resultado ? "Socio agregado con �xito." : "Error al agregar el socio.";
                } else if ("eliminar".equals(accion)) {
                    String idSocio = request.getParameter("idSocio");
                    if (idSocio != null && !idSocio.isEmpty()) {
                        boolean resultado = operacionBD.eliminarSocio(idSocio);
                        mensaje = resultado ? "Socio eliminado con �xito." : "Error al eliminar el socio.";
                    }
                } else if ("actualizar".equals(accion)) {
                    Socio socioActualizado = new Socio();
                    socioActualizado.setIdSocio(request.getParameter("idSocioActualizar"));
                    socioActualizado.setNombre(request.getParameter("nuevoNombre"));
                    socioActualizado.setFechaNacimiento(request.getParameter("nuevaFechaNacimiento") != null
                        ? java.time.LocalDate.parse(request.getParameter("nuevaFechaNacimiento")) : null);
                    socioActualizado.setTelefono(request.getParameter("nuevoTelefono"));
                    socioActualizado.setEmail(request.getParameter("nuevoEmail"));
                    socioActualizado.setFechaInscripcion(request.getParameter("nuevaFechaInscripcion") != null
                        ? java.time.LocalDate.parse(request.getParameter("nuevaFechaInscripcion")) : null);
                    socioActualizado.setMembresia(request.getParameter("nuevaMembresia"));
                    socioActualizado.setEstado(request.getParameter("nuevoEstado"));

                    boolean resultado = operacionBD.actualizarSocio(socioActualizado);
                    mensaje = resultado ? "Socio actualizado con �xito." : "Error al actualizar el socio.";
                }

                operacionBD.desconectar();
            } else {
                mensaje = "Error al conectar con la base de datos.";
            }
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
        }
    %>

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

        <label for="telefono">Tel�fono:</label>
        <input type="text" id="telefono" name="telefono" required><br><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br><br>

        <label for="fechaInscripcion">Fecha de Inscripci�n:</label>
        <input type="date" id="fechaInscripcion" name="fechaInscripcion" required><br><br>

        <label for="membresia">Membres�a:</label>
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

        <label for="nuevoTelefono">Nuevo Tel�fono:</label>
        <input type="text" id="nuevoTelefono" name="nuevoTelefono"><br><br>

        <label for="nuevoEmail">Nuevo Email:</label>
        <input type="email" id="nuevoEmail" name="nuevoEmail"><br><br>

        <label for="nuevaFechaInscripcion">Nueva Fecha de Inscripci�n:</label>
        <input type="date" id="nuevaFechaInscripcion" name="nuevaFechaInscripcion"><br><br>

        <label for="nuevaMembresia">Nueva Membres�a:</label>
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
                <th>Tel�fono</th>
                <th>Email</th>
                <th>Fecha de Inscripci�n</th>
                <th>Membres�a</th>
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
