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
    <title>Administración de Máquinas</title>
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
    <h1>Administración de Máquinas</h1>

    <% 
        OperacionBD operacionBD = new OperacionBD();
        Maquina maquina = new Maquina();
        String mensaje = "";

        try {
            if (operacionBD.conectar()) {
                String accion = request.getParameter("accion");

                if ("agregar".equals(accion)) {
                    // Agregar máquina
                    maquina.setNombre(request.getParameter("nombre"));
                    maquina.setTipo(request.getParameter("tipo"));
                    maquina.setUbicacion(request.getParameter("ubicacion"));
                    maquina.setEstado(request.getParameter("estado"));

                    boolean resultado = maquina.agregarMaquina(maquina);
                    mensaje = resultado ? "Máquina agregada con éxito." : "Error al agregar la máquina.";
                } else if ("eliminar".equals(accion)) {
                    // Eliminar máquina
                    String idMaquina = request.getParameter("idMaquina");
                    if (idMaquina != null && !idMaquina.isEmpty()) {
                        boolean resultado = maquina.eliminarMaquina(Integer.parseInt(idMaquina));
                        mensaje = resultado ? "Máquina eliminada con éxito." : "Error al eliminar la máquina.";
                    }
                } else if ("actualizar".equals(accion)) {
                    // Actualizar máquina
                    maquina.setId_maquina(Integer.parseInt(request.getParameter("idMaquinaActualizar")));
                    maquina.setNombre(request.getParameter("nuevoNombre"));
                    maquina.setTipo(request.getParameter("nuevoTipo"));
                    maquina.setUbicacion(request.getParameter("nuevaUbicacion"));
                    maquina.setEstado(request.getParameter("nuevoEstado"));

                    boolean resultado = maquina.actualizarMaquina(maquina);
                    mensaje = resultado ? "Máquina actualizada con éxito." : "Error al actualizar la máquina.";
                }
            } else {
                mensaje = "Error al conectar con la base de datos.";
            }
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
        } finally {
            // Aseguramos que siempre se desconecte de la base de datos
            try {
                operacionBD.desconectar();
            } catch (Exception e) {
                // En caso de error al desconectar, no hacer nada
            }
        }
    %>

    <% if (!mensaje.isEmpty()) { %>
        <p><%= mensaje %></p>
    <% } %>

    <!-- Formulario para Agregar Máquina -->
    <h2>Agregar Nueva Máquina</h2>
    <form action="ModMaquinas.jsp" method="post">
        <input type="hidden" name="accion" value="agregar">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required><br><br>

        <label for="tipo">Tipo:</label>
        <input type="text" id="tipo" name="tipo" required><br><br>

        <label for="ubicacion">Ubicación:</label>
        <input type="text" id="ubicacion" name="ubicacion" required><br><br>

        <label for="estado">Estado:</label>
        <input type="text" id="estado" name="estado" required><br><br>

        <input type="submit" value="Agregar Máquina">
    </form>

    <!-- Formulario para Eliminar Máquina -->
    <h2>Eliminar Máquina</h2>
    <form action="ModMaquinas.jsp" method="post">
        <input type="hidden" name="accion" value="eliminar">
        <label for="idMaquina">ID de la Máquina:</label>
        <input type="number" id="idMaquina" name="idMaquina" required><br><br>
        <input type="submit" value="Eliminar Máquina">
    </form>

    <!-- Formulario para Actualizar Máquina -->
    <h2>Actualizar Máquina</h2>
    <form action="ModMaquinas.jsp" method="post">
        <input type="hidden" name="accion" value="actualizar">
        <label for="idMaquinaActualizar">ID de la Máquina:</label>
        <input type="number" id="idMaquinaActualizar" name="idMaquinaActualizar" required><br><br>

        <label for="nuevoNombre">Nuevo Nombre:</label>
        <input type="text" id="nuevoNombre" name="nuevoNombre"><br><br>

        <label for="nuevoTipo">Nuevo Tipo:</label>
        <input type="text" id="nuevoTipo" name="nuevoTipo"><br><br>

        <label for="nuevaUbicacion">Nueva Ubicación:</label>
        <input type="text" id="nuevaUbicacion" name="nuevaUbicacion"><br><br>

        <label for="nuevoEstado">Nuevo Estado:</label>
        <input type="text" id="nuevoEstado" name="nuevoEstado"><br><br>

        <input type="submit" value="Actualizar Máquina">
    </form>

    <!-- Tabla para Mostrar Máquinas -->
    <h2>Lista de Máquinas</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Tipo</th>
                <th>Ubicación</th>
                <th>Estado</th>
            </tr>
        </thead>
        <tbody>
            <% 
                try {
                    if (operacionBD.conectar()) {
                        List<Maquina> listaMaquinas = maquina.consultarMaquina();
                        if (listaMaquinas != null && !listaMaquinas.isEmpty()) {
                            for (Maquina m : listaMaquinas) { %>
                                <tr>
                                    <td><%= m.getId_maquina() %></td>
                                    <td><%= m.getNombre() %></td>
                                    <td><%= m.getTipo() %></td>
                                    <td><%= m.getUbicacion() %></td>
                                    <td><%= m.getEstado() %></td>
                                </tr>
            <%              }
                        } else { %>
                            <tr>
                                <td colspan="5">No hay máquinas registradas.</td>
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
