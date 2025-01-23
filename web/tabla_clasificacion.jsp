<%-- 
    Document   : tabla_clasificacion
    Created on : 22/01/2025, 09:30:27 AM
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
        <title>Clasificación</title>
        <!-- Enlazamos el archivo de estilo estilos6.css -->
        <link href="estilos6.css" rel="stylesheet">
    </head>
    <body>
        <h1>Tabla de Clasificación</h1>
        
        <!-- Filtro por actividad -->
        <h3>Filtrar por actividad</h3>
        <form method="get">
            <select id="filterSelect" name="actividad" onchange="this.form.submit()">
                <option value="">Seleccione una actividad...</option>
                <option value="Entrenamiento Funcional">Entrenamiento Funcional</option>
                <option value="Yoga">Yoga</option>
                <option value="Spinning">Spinning</option>
                <option value="Crossfit">Crossfit</option>
                <option value="Pilates">Pilates</option>
                <option value="Cardio">Cardio</option>
                <option value="Pesas">Pesas</option>
                <option value="Boxeo">Boxeo</option>
                <option value="Entrenamiento Personalizado">Entrenamiento Personalizado</option>
                <option value="Aerobicos">Aeróbicos</option>
            </select>
        </form>
        
        <h2>Socios</h2>
        <table>
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Numero de Asistencias</th>
                    <th>Última Actividad</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        OperacionBD operacionBD = new OperacionBD();
                        if (operacionBD.conectar()) {
                            List<Socio> listaSocios = operacionBD.consultarSocios();
                            operacionBD.desconectar();

                            String actividadFiltro = request.getParameter("actividad");

                            if (listaSocios != null && !listaSocios.isEmpty()) {
                                for (Socio socio : listaSocios) {
                                    // Verifica si hay asistencia y si la actividad coincide con el filtro
                                    boolean mostrarSocio = actividadFiltro == null || actividadFiltro.isEmpty() ||
                                        socio.getAsistencia().stream().anyMatch(a -> a.contains(actividadFiltro));

                                    if (mostrarSocio) {
                %>
                <tr>
                    <td><%= socio.getNombre() %></td>
                    <td><%= socio.getNumeroDeAsistencias() %></td>
                    <td>
                        <%
                            List<String> asistencias = socio.getAsistencia();
                            if (asistencias != null && !asistencias.isEmpty()) {
                                // Obtenemos la última asistencia
                                String ultimaAsistencia = asistencias.get(asistencias.size() - 1);
                                String[] datos = ultimaAsistencia.split(" - ");
                                if (datos.length == 2) {
                                    String actividad = datos[0].replace("Actividad: ", "");
                                    out.print(actividad);
                                }
                            } else {
                                out.print("Sin actividad");
                            }
                        %>
                    </td>
                </tr>
                <%
                                    }
                                }
                            } else {
                %>
                            <tr>
                                <td colspan="3">No hay socios registrados.</td>
                            </tr>
                <%
                            }
                        } else {
                %>
                            <tr>
                                <td colspan="3">No se pudo conectar a la base de datos.</td>
                            </tr>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <tr>
                        <td colspan="3">Error: <%= e.getMessage() %></td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </body>
</html>
