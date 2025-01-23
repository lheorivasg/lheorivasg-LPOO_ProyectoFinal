<%-- 
    Document   : Entrenadores
    Created on : Jan 18, 2025, 5:13:46 PM
    Author     : Kirig
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.Entrenador"%>
<%@page import="datos.OperacionBD"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro de Entrenadores</title>
</head>
<body>
    <h1>Acciones con Entrenador</h1>

    <form action="GestionEntrenador.jsp" method="post">
        <h2>Registrar Entrada</h2>
        <label for="idEntrenador">ID Entrenador:</label>
        <input type="number" id="idEntrenador" name="idEntrenador" required><br><br>
        <input type="submit" name="accion" value="registrarEntrada">
    </form>

    <form action="GestionEntrenador.jsp" method="post">
        <h2>Registrar Salida</h2>
        <label for="idEntrenador">ID Entrenador:</label>
        <input type="number" id="idEntrenador" name="idEntrenador" required><br><br>
        <input type="submit" name="accion" value="registrarSalida">
    </form>

    <form action="GestionEntrenador.jsp" method="post">
        <h2>Calcular Horas Trabajadas</h2>
        <label for="idEntrenador">ID Entrenador:</label>
        <input type="number" id="idEntrenador" name="idEntrenador" required><br><br>
        <input type="submit" name="accion" value="calcularHoras">
    </form>

    <form action="GestionEntrenador.jsp" method="post">
        <h2>Modificar Disponibilidad</h2>
        <label for="idEntrenador">ID Entrenador:</label>
        <input type="number" id="idEntrenador" name="idEntrenador" required><br><br>
        <label for="nuevoEstado">Nuevo Estado:</label>
        <input type="text" id="nuevoEstado" name="nuevoEstado" required><br><br>
        <input type="submit" name="accion" value="modificarDisponibilidad">
    </form>

    <form action="GestionEntrenador.jsp" method="post">
        <h2>Modificar Horario</h2>
        <label for="idEntrenador">ID Entrenador:</label>
        <input type="number" id="idEntrenador" name="idEntrenador" required><br><br>
        <label for="nuevoHorario">Nuevo Horario:</label>
        <input type="text" id="nuevoHorario" name="nuevoHorario" required><br><br>
        <input type="submit" name="accion" value="modificarHorario">
    </form>

    <% 
        String mensaje = "";
        Entrenador entrenador = new Entrenador();
        int idEntrenador = Integer.parseInt(request.getParameter("idEntrenador"));
        
        String accion = request.getParameter("accion");

        if ("registrarEntrada".equals(accion)) {
            boolean resultado = entrenador.registrarEntrada(idEntrenador);
            mensaje = resultado ? "Entrada registrada exitosamente." : "Error al registrar la entrada.";
        } else if ("registrarSalida".equals(accion)) {
            boolean resultado = entrenador.registrarSalida(idEntrenador);
            mensaje = resultado ? "Salida registrada exitosamente." : "Error al registrar la salida.";
        } else if ("calcularHoras".equals(accion)) {
            int horas = entrenador.calcularHorasTrabajadas(idEntrenador);
            mensaje = horas >= 0 ? "Horas trabajadas: " + horas : "Error al calcular las horas trabajadas.";
        } else if ("modificarDisponibilidad".equals(accion)) {
            String nuevoEstado = request.getParameter("nuevoEstado");
            boolean resultado = entrenador.modificarDisponibilidad(idEntrenador, nuevoEstado);
            mensaje = resultado ? "Disponibilidad modificada exitosamente." : "Error al modificar la disponibilidad.";
        } else if ("modificarHorario".equals(accion)) {
            String nuevoHorario = request.getParameter("nuevoHorario");
            boolean resultado = entrenador.modificarHorario(idEntrenador, nuevoHorario);
            mensaje = resultado ? "Horario modificado exitosamente." : "Error al modificar el horario.";
        }

        if (!mensaje.isEmpty()) {
    %>
        <p><%= mensaje %></p>
    <% } %>
</body>
</html>

