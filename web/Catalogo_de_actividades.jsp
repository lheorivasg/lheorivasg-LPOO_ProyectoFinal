<%-- 
    Document   : Catalogo_de_actividades
    Created on : 22/01/2025, 01:43:24 AM
    Author     : z23hu
--%>
<%@page import="java.util.List"%>
<%@page import="modelo.Entrenador"%>
<%@page import="modelo.Socio"%>
<%@page import="datos.OperacionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Catálogo de Actividades</title>
        <!-- Se incluye el archivo CSS 'estilos4.css' -->
        <link href="estilos4.css" rel="stylesheet">
    </head>
    <body>
        <h1>Catálogo de Actividades</h1>

        <h3>Filtrar por actividad</h3>

        <select id="filterSelect" onchange="filterTable()">
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

        <h2>Actividades</h2>
        <table>
            <thead>
                <tr>
                    <th>Actividad</th>
                    <th>Entrenador</th>
                    <th>Horario</th>
                    <th>Reservar</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        OperacionBD operacionBD = new OperacionBD();
                        if (operacionBD.conectar()) {
                            List<Entrenador> listaEntrenadores = operacionBD.consultarEntrenador();
                            operacionBD.desconectar();

                            if (listaEntrenadores != null && !listaEntrenadores.isEmpty()) {
                                for (Entrenador entrenador : listaEntrenadores) {
                %>
                <tr>
                    <td><%= entrenador.getEspecialidad()%></td>
                    <td><%= entrenador.getNombre()%></td>
                    <td><%= entrenador.getHorario()%></td>
                    <td>
                        <!-- Botón para registrar asistencia -->
                        <form method="post" action="reservarAsistencia.jsp">
                            <input type="hidden" name="idSocio" value="<%= session.getAttribute("idSocio")%>">
                            <input type="hidden" name="actividad" value="<%= entrenador.getEspecialidad()%>">
                            <input type="submit" class="btn-reservar" value="Reservar">
                        </form>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="4">No hay actividades disponibles.</td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="4">No se pudo conectar a la base de datos.</td>
                </tr>
                <%
                    }
                } catch (Exception e) {
                %>
                <tr>
                    <td colspan="4">Error: <%= e.getMessage()%></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <script>
            function filterTable() {
                var select = document.getElementById("filterSelect");
                var filter = select.value.toLowerCase();

                var table = document.querySelector("table");
                var rows = table.getElementsByTagName("tr");

                for (var i = 1; i < rows.length; i++) {
                    var cells = rows[i].getElementsByTagName("td");
                    var activityCell = cells[0];

                    if (activityCell) {
                        var activityText = activityCell.textContent || activityCell.innerText;
                        if (filter === "" || activityText.toLowerCase().indexOf(filter) > -1) {
                            rows[i].style.display = "";
                        } else {
                            rows[i].style.display = "none";
                        }
                    }
                }
            }
        </script>
    </body>
</html>
