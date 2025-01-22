<%-- 
    Document   : EliminarMaquina
    Created on : 21/01/2025, 06:50:35 PM
    Author     : max-1
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Maquina"%>
<%@page import="datos.OperacionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>Eliminar Máquina</title>
</head>
<body>
    <%
        // Obtener el ID de la máquina a eliminar desde el formulario
        String idMaquina = request.getParameter("idMaquinaEliminar");

        if (idMaquina != null && !idMaquina.isEmpty()) {
            // Crear instancia de OperacionBD y conectar
            OperacionBD op = new OperacionBD();
            if (op.conectar()) {
                boolean exito = op.eliminarMaquina(idMaquina);
                op.desconectar();

                if (exito) {
    %>
                    <h1>Máquina con ID <%= idMaquina %> eliminada con éxito.</h1>
    <%
                } else {
    %>
                    <h1>Error: No se encontró la máquina con ID <%= idMaquina %>.</h1>
    <%
                }
            } else {
    %>
                <h1>Error de conexión a la base de datos.</h1>
    <%
            }
        } else {
    %>
            <h1>Por favor, ingrese un ID de máquina válido.</h1>
    <%
        }
    %>

    <a href="ModMaquinas.jsp">Volver</a>
</body>
</html>
