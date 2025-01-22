<%-- 
    Document   : AgregarMaquina
    Created on : 21/01/2025, 06:39:24 PM
    Author     : max-1
--%>

<%@page import="datos.OperacionBD"%>
<%@page import="modelo.Maquina"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Agregar Máquina</title>
    </head>
    <body>
        <%
            // Obtener los parámetros del formulario
            String nombre = request.getParameter("nombre");
            String tipo = request.getParameter("tipo");
            String ubicacion = request.getParameter("ubicacion");
            String estado = request.getParameter("estado");

            if (nombre != null && tipo != null && ubicacion != null && estado != null &&
                !nombre.isEmpty() && !tipo.isEmpty() && !ubicacion.isEmpty() && !estado.isEmpty()) {

                // Crear objeto Maquina
                Maquina nuevaMaquina = new Maquina();
                nuevaMaquina.setNombre(nombre);
                nuevaMaquina.setTipo(tipo);
                nuevaMaquina.setUbicacion(ubicacion);
                nuevaMaquina.setEstado(estado);

                // Conectar con la base de datos
                OperacionBD op = new OperacionBD();
                if (op.conectar()) {
                    boolean exito = op.agregarMaquina(nuevaMaquina);
                    op.desconectar();
                    
                    if (exito) {
        %>
                        <h1>Máquina agregada con éxito.</h1>
        <%
                    } else {
        %>
                        <h1>Error: No se pudo agregar la máquina.</h1>
        <%
                    }
                } else {
        %>
                    <h1>Error de conexión a la base de datos.</h1>
        <%
                }
            } else {
        %>
                <h1>Por favor, complete todos los campos del formulario.</h1>
        <%
            }
        %>
        
        <a href="ModMaquinas.jsp">Volver</a>
    </body>
</html>

