<%-- 
    Document   : ModificarMaquina
    Created on : 21/01/2025, 06:44:45 PM
    Author     : max-1
--%>

<%@page import="datos.OperacionBD"%>
<%@page import="modelo.Maquina"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modificar Máquina</title>
</head>
<body>
    <%
        // Obtener los parámetros del formulario
        String idMaquina = request.getParameter("idMaquinaModificar");
        String nuevoNombre = request.getParameter("nuevoNombre");
        String nuevoTipo = request.getParameter("nuevoTipo");
        String nuevaUbicacion = request.getParameter("nuevaUbicacion");

        // Verificar que el ID de la máquina no esté vacío
        if (idMaquina != null && !idMaquina.isEmpty()) {
            
            // Crear objeto Maquina con los valores ingresados
            Maquina maquinaModificada = new Maquina();
            maquinaModificada.setId_maquina(idMaquina);
            
            // Verificar si los campos no están vacíos antes de establecerlos
            if (nuevoNombre != null && !nuevoNombre.isEmpty()) {
                maquinaModificada.setNombre(nuevoNombre);
            } else {
                maquinaModificada.setNombre(null);
            }
            
            if (nuevoTipo != null && !nuevoTipo.isEmpty()) {
                maquinaModificada.setTipo(nuevoTipo);
            } else {
                maquinaModificada.setTipo(null);
            }

            if (nuevaUbicacion != null && !nuevaUbicacion.isEmpty()) {
                maquinaModificada.setUbicacion(nuevaUbicacion);
            } else {
                maquinaModificada.setUbicacion(null);
            }

            maquinaModificada.setEstado("Operativa"); // Puedes cambiarlo según tu necesidad

            // Conectar a la base de datos y actualizar la máquina
            OperacionBD op = new OperacionBD();
            if (op.conectar()) {
                boolean exito = op.actualizarMaquina(maquinaModificada);
                op.desconectar();

                if (exito) {
    %>
                    <h1>Máquina modificada con éxito.</h1>
    <%
                } else {
    %>
                    <h1>Error: No se pudo modificar la máquina.</h1>
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
