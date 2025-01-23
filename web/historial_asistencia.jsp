<%-- 
    Document   : historial_asistencia
    Created on : 22/01/2025, 08:58:25 AM
    Author     : z23hu
--%>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Socio" %>
<%@ page import="datos.OperacionBD" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historial de Asistencia</title>
        <!-- Enlace al archivo de estilo -->
        <link href="estilos5.css" rel="stylesheet">
    </head>
    <body>
        <h1>Historial de Asistencia</h1>

        <%
            // Obtener el socio de la sesión
            Socio socio = (Socio) session.getAttribute("socio");

            // Verificar si el socio tiene asistencias registradas
            if (socio != null && socio.getAsistencia() != null && !socio.getAsistencia().isEmpty()) {
        %>

        <table>
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Actividad</th>
                    <th>Hora</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<String> asistencias = socio.getAsistencia();
                    for (String asistencia : asistencias) {

                        String[] datos = asistencia.split(" - ");

                        if (datos.length == 2) {
                            String actividad = datos[0].replace("Actividad: ", "");
                            String fecha = datos[1].replace("Fecha: ", "");
                %>
                <tr>
                    <td><%= socio.getNombre()%></td>
                    <td><%= actividad%></td>
                    <td><%= fecha%></td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>

        <%
        } else {
        %>
        <p>No se han registrado asistencias.</p>
        <%
            }
        %>
    </body>
</html>
