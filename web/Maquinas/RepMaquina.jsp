<%-- 
    Document   : RepMaquina
    Created on : 21/01/2025, 01:58:32 PM
    Author     : max-1
--%>


<%@page import="datos.OperacionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Máquina Reparada</title>
    </head>
    <body>
        <%
            String maqReparar = request.getParameter("maqReparar");
            if (maqReparar != null && !maqReparar.isEmpty()) {
                OperacionBD reparar = new OperacionBD();
                if (reparar.conectar()) {  // Verifica si la conexión fue exitosa
                    boolean exito = reparar.repararMaquina(maqReparar);
                    reparar.desconectar();
                    
                    if (exito) {
        %>
                        <h1>La máquina con ID <%= maqReparar %> se reparó con éxito</h1>
        <%
                    } else {
        %>
                        <h1>No se encontró la máquina con ID <%= maqReparar %></h1>
        <%
                    }
                } else {
        %>
                    <h1>Error de conexión a la base de datos.</h1>
        <%
                }
            } else {
        %>
                <h1>No se proporcionó un ID de máquina válido.</h1>
        <%
            }
        %>
        
        <a href="ModMaquinas.jsp">Volver</a>
    </body>
</html>
