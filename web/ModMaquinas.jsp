<%-- 
    Document   : Maquinas
    Created on : Jan 18, 2025, 3:12:12 PM
    Author     : Kirig
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.Maquina"%>
<%@page import="datos.OperacionBD"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Administraci�n de M�quinas</title>
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
    <h1>Administraci�n de M�quinas</h1>

    <% 
        OperacionBD operacionBD = new OperacionBD();
        String mensaje = "";

        try {
            if (operacionBD.conectar()) {
                String accion = request.getParameter("accion");

                if ("agregar".equals(accion)) {
                    // Agregar m�quina
                    Maquina nuevaMaquina = new Maquina();
                    nuevaMaquina.setNombre(request.getParameter("nombre"));
                    nuevaMaquina.setTipo(request.getParameter("tipo"));
                    nuevaMaquina.setUbicacion(request.getParameter("ubicacion"));
                    nuevaMaquina.setEstado(request.getParameter("estado"));

                    boolean resultado = operacionBD.agregarMaquina(nuevaMaquina);
                    mensaje = resultado ? "M�quina agregada con �xito." : "Error al agregar la m�quina.";
                } else if ("eliminar".equals(accion)) {
                    // Eliminar m�quina
                    String idMaquina = request.getParameter("idMaquina");
                    if (idMaquina != null && !idMaquina.isEmpty()) {
                        boolean resultado = operacionBD.eliminarMaquina(idMaquina);
                        mensaje = resultado ? "M�quina eliminada con �xito." : "Error al eliminar la m�quina.";
                    }
                } else if ("actualizar".equals(accion)) {
                    // Actualizar m�quina
                    Maquina maquinaActualizada = new Maquina();
                    maquinaActualizada.setId_maquina(request.getParameter("idMaquinaActualizar"));
                    maquinaActualizada.setNombre(request.getParameter("nuevoNombre"));
                    maquinaActualizada.setTipo(request.getParameter("nuevoTipo"));
                    maquinaActualizada.setUbicacion(request.getParameter("nuevaUbicacion"));
                    maquinaActualizada.setEstado(request.getParameter("nuevoEstado"));

                    boolean resultado = operacionBD.actualizarMaquina(maquinaActualizada);
                    mensaje = resultado ? "M�quina actualizada con �xito." : "Error al actualizar la m�quina.";
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

    <!-- Formulario para Agregar M�quina -->
    <h2>Agregar Nueva M�quina</h2>
    <form action="ModMaquinas.jsp" method="post">
        <input type="hidden" name="accion" value="agregar">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required><br><br>

        <label for="tipo">Tipo:</label>
        <input type="text" id="tipo" name="tipo" required><br><br>

        <label for="ubicacion">Ubicaci�n:</label>
        <input type="text" id="ubicacion" name="ubicacion" required><br><br>

        <label for="estado">Estado:</label>
        <input type="text" id="estado" name="estado" required><br><br>

        <input type="submit" value="Agregar M�quina">
    </form>

    <!-- Formulario para Eliminar M�quina -->
    <h2>Eliminar M�quina</h2>
    <form action="ModMaquinas.jsp" method="post">
        <input type="hidden" name="accion" value="eliminar">
        <label for="idMaquina">ID de la M�quina:</label>
        <input type="number" id="idMaquina" name="idMaquina" required><br><br>
        <input type="submit" value="Eliminar M�quina">
    </form>

    <!-- Formulario para Actualizar M�quina -->
    <h2>Actualizar M�quina</h2>
    <form action="ModMaquinas.jsp" method="post">
        <input type="hidden" name="accion" value="actualizar">
        <label for="idMaquinaActualizar">ID de la M�quina:</label>
        <input type="number" id="idMaquinaActualizar" name="idMaquinaActualizar" required><br><br>

        <label for="nuevoNombre">Nuevo Nombre:</label>
        <input type="text" id="nuevoNombre" name="nuevoNombre"><br><br>

        <label for="nuevoTipo">Nuevo Tipo:</label>
        <input type="text" id="nuevoTipo" name="nuevoTipo"><br><br>

        <label for="nuevaUbicacion">Nueva Ubicaci�n:</label>
        <input type="text" id="nuevaUbicacion" name="nuevaUbicacion"><br><br>

        <label for="nuevoEstado">Nuevo Estado:</label>
        <input type="text" id="nuevoEstado" name="nuevoEstado"><br><br>

        <input type="submit" value="Actualizar M�quina">
    </form>

    <!-- Tabla para Mostrar M�quinas -->
    <h2>Lista de M�quinas</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Tipo</th>
                <th>Ubicaci�n</th>
                <th>Estado</th>
            </tr>
        </thead>
        <tbody>
            <% 
                try {
                    if (operacionBD.conectar()) {
                        List<Maquina> listaMaquinas = operacionBD.consultarMaquina();
                        operacionBD.desconectar();

                        if (listaMaquinas != null && !listaMaquinas.isEmpty()) {
                            for (Maquina maquina : listaMaquinas) { %>
                                <tr>
                                    <td><%= maquina.getId_maquina() %></td>
                                    <td><%= maquina.getNombre() %></td>
                                    <td><%= maquina.getTipo() %></td>
                                    <td><%= maquina.getUbicacion() %></td>
                                    <td><%= maquina.getEstado() %></td>
                                </tr>
            <%              }
                        } else { %>
                            <tr>
                                <td colspan="5">No hay m�quinas registradas.</td>
                            </tr>
            <%          }
                    }
                } catch (Exception e) { %>
                    <tr>
                        <td colspan="5">Error: <%= e.getMessage() %></td>
                    </tr>
            <%  } %>
        </tbody>
    </table>
</body>
</html>
