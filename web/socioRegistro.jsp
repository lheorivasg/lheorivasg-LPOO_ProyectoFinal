<%-- 
    Document   : socioRegistro
    Created on : 21/01/2025, 07:48:45 PM
    Author     : z23hu
--%>
<%@page import="java.util.List"%>
<%@page import="modelo.Socio"%>
<%@page import="datos.OperacionBD"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro</title>
        <link href="estilos2.css" rel="stylesheet">
    </head>
    <body>
        <h1>Registro Socio</h1>
        <%
            OperacionBD operacionBD = new OperacionBD();
            String mensaje = "";

            try {
                if (operacionBD.conectar()) {
                    String accion = request.getParameter("accion");

                    if ("enviar".equals(accion)) {
                        Socio nuevoSocio = new Socio();
                        nuevoSocio.setNombre(request.getParameter("nombre"));
                        nuevoSocio.setFechaNacimiento(java.time.LocalDate.parse(request.getParameter("fechaNacimiento")));
                        nuevoSocio.setTelefono(request.getParameter("telefono"));
                        nuevoSocio.setEmail(request.getParameter("email"));
                        boolean resultado = operacionBD.agregarSocio(nuevoSocio);
                        if (resultado) {
                            mensaje = "Socio registrado con éxito.";
                        } else {
                            mensaje = "Error al registrar al socio.";
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

        <!-- Mostrar mensaje al usuario -->
        <p><%= mensaje%></p>

        <form action="socioRegistro.jsp" method="post">
            <input type="hidden" name="accion" value="enviar">

            Nombre: <input type="text" name="nombre" size="15" required><br><br>
            Fecha de Nacimiento: <input type="date" name="fechaNacimiento" size="15" required><br><br>
            Email: <input type="email" name="email" size="15" required><br><br>
            Teléfono: <input type="tel" name="telefono" size="15" required pattern="[0-9]{10}"><br><br>

            <input type="submit" value="Enviar">
        </form>
    </body>
</html>
