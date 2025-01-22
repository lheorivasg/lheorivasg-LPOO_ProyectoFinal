<%-- 
    Document   : MoverMaquina
    Created on : 21/01/2025, 06:22:57 PM
    Author     : max-1
--%>

<%@page import="datos.OperacionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Resultado de Movimiento</title>
    </head>
    <body>
        <%
            String idMaquina = request.getParameter("idMaquina");
            String nuevaUbicacion = request.getParameter("nuevaUbicacion");

            if (idMaquina != null && nuevaUbicacion != null && !idMaquina.isEmpty()) {
                OperacionBD op = new OperacionBD();
                if (op.conectar()) {
                    boolean exito = op.moverMaquina(idMaquina, nuevaUbicacion);
                    op.desconectar();
                    
                    if (exito) {
        %>
                        <h1>La máquina con ID <%= idMaquina %> se movió a <%= nuevaUbicacion %> correctamente.</h1>
        <%
                    } else {
        %>
                        <h1>Error: No se pudo mover la máquina con ID <%= idMaquina %>.</h1>
        <%
                    }
                } else {
        %>
                    <h1>Error de conexión a la base de datos.</h1>
        <%
                }
            } else {
        %>
                <h1>Por favor, proporcione todos los datos necesarios.</h1>
        <%
            }
        %>
        
        <a href="ModMaquinas.jsp">Volver</a>
    </body>
</html>
