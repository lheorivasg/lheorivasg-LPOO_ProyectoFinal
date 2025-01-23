<%-- 
    Document   : Entrenadores
    Created on : Jan 18, 2025, 5:13:46 PM
    Author     : Kirig
--%>

<%@ page import="modelo.Entrenador" %>
<%@ page import="java.io.PrintWriter" %>

<%
    String accion = request.getParameter("accion");
    String resultado = "Bienvenido a la gestión de entrenadores.";
    
    if (accion != null) {
        try {
            // Convertir el idEntrenador a int
            String idEntrenadorStr = request.getParameter("idEntrenador");
            int idEntrenador = Integer.parseInt(idEntrenadorStr); // Convertimos el idEntrenador a int
            Entrenador entrenador = new Entrenador();

            switch (accion) {
                case "modificarDisponibilidad":
                    String nuevoEstado = request.getParameter("estado");
                    if (nuevoEstado != null && !nuevoEstado.isEmpty()) {
                        if (entrenador.modificarDisponibilidad(idEntrenador, nuevoEstado)) {
                            resultado = "Disponibilidad modificada con éxito.";
                        } else {
                            resultado = "Error al modificar disponibilidad.";
                        }
                    } else {
                        resultado = "El estado no puede estar vacío.";
                    }
                    break;

                case "modificarHorario":
                    String nuevoHorario = request.getParameter("horario");
                    if (nuevoHorario != null && !nuevoHorario.isEmpty()) {
                        if (entrenador.modificarHorario(idEntrenador, nuevoHorario)) {
                            resultado = "Horario modificado con éxito.";
                        } else {
                            resultado = "Error al modificar horario.";
                        }
                    } else {
                        resultado = "El horario no puede estar vacío.";
                    }
                    break;

                case "registrarEntrada":
                    if (entrenador.registrarEntrada(idEntrenador)) {
                        resultado = "Entrada registrada con éxito.";
                    } else {
                        resultado = "Error al registrar entrada.";
                    }
                    break;

                case "registrarSalida":
                    if (entrenador.registrarSalida(idEntrenador)) {
                        resultado = "Salida registrada con éxito.";
                    } else {
                        resultado = "Error al registrar salida.";
                    }
                    break;

                case "calcularHorasTrabajadas":
                    int horas = entrenador.calcularHorasTrabajadas(idEntrenador);
                    if (horas >= 0) {
                        resultado = "Horas trabajadas: " + horas;
                    } else {
                        resultado = "Error al calcular horas trabajadas.";
                    }
                    break;

                default:
                    resultado = "Acción no reconocida.";
            }
        } catch (NumberFormatException e) {
            resultado = "ID Entrenador inválido. Por favor, ingrese un valor válido.";
        } catch (Exception e) {
            resultado = "Ocurrió un error inesperado. Inténtelo nuevamente.";
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Entrenadores</title>
    <!-- Enlazamos el archivo de estilo estilos7.css -->
    <link href="estilos7.css" rel="stylesheet">
</head>
<body>
    <h1>Gestión de Entrenadores</h1>

    <!-- Mostrar resultado -->
    <p><%= resultado %></p>

    <!-- Formularios -->
    <section>
        <h2>Modificar Disponibilidad</h2>
        <form action="gestionarEntrenadores.jsp" method="POST">
            <input type="hidden" name="accion" value="modificarDisponibilidad">
            ID Entrenador: <input type="number" name="idEntrenador" required><br>
            Nuevo Estado:
            <select name="estado" required>
                <option value="">Seleccione</option>
                <option value="Activo">Activo</option>
                <option value="Inactivo">Inactivo</option>
            </select><br>
            <button type="submit">Modificar Disponibilidad</button>
        </form>
    </section>

    <section>
        <h2>Modificar Horario</h2>
        <form action="gestionarEntrenadores.jsp" method="POST">
            <input type="hidden" name="accion" value="modificarHorario">
            ID Entrenador: <input type="number" name="idEntrenador" required><br>
            Nuevo Horario: <input type="text" name="horario" required><br>
            <button type="submit">Modificar Horario</button>
        </form>
    </section>

    <section>
        <h2>Registrar Entrada</h2>
        <form action="gestionarEntrenadores.jsp" method="POST">
            <input type="hidden" name="accion" value="registrarEntrada">
            ID Entrenador: <input type="number" name="idEntrenador" required><br>
            <button type="submit">Registrar Entrada</button>
        </form>
    </section>

    <section>
        <h2>Registrar Salida</h2>
        <form action="gestionarEntrenadores.jsp" method="POST">
            <input type="hidden" name="accion" value="registrarSalida">
            ID Entrenador: <input type="number" name="idEntrenador" required><br>
            <button type="submit">Registrar Salida</button>
        </form>
    </section>

    <section>
        <h2>Calcular Horas Trabajadas</h2>
        <form action="gestionarEntrenadores.jsp" method="POST">
            <input type="hidden" name="accion" value="calcularHorasTrabajadas">
            ID Entrenador: <input type="number" name="idEntrenador" required><br>
            <button type="submit">Calcular Horas Trabajadas</button>
        </form>
    </section>
</body>
</html>


