<%-- 
    Document   : Entrenadores
    Created on : Jan 18, 2025, 5:13:46 PM
    Author     : Kirig
--%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Gestión de Entrenadores</title>
</head>
<body>
    <h1>Gestión de Entrenadores</h1>

    <!-- Formulario para modificar disponibilidad -->
    <h2>Modificar Disponibilidad</h2>
    <form action="modificarDisponibilidad" method="POST">
        ID Entrenador: <input type="number" name="idEntrenador" required><br>
        Nuevo Estado:
        <select name="estado">
            <option value="Activo">Activo</option>
            <option value="Inactivo">Inactivo</option>
        </select><br>
        <button type="submit">Modificar</button>
    </form>

    <!-- Formulario para modificar horario -->
    <h2>Modificar Horario</h2>
    <form action="modificarHorario" method="POST">
        ID Entrenador: <input type="number" name="idEntrenador" required><br>
        Nuevo Horario: <input type="text" name="horario" required><br>
        <button type="submit">Modificar</button>
    </form>

    <!-- Formulario para registrar entrada -->
    <h2>Registrar Entrada</h2>
    <form action="registrarEntrada" method="POST">
        ID Entrenador: <input type="number" name="idEntrenador" required><br>
        <button type="submit">Registrar Entrada</button>
    </form>

    <!-- Formulario para registrar salida -->
    <h2>Registrar Salida</h2>
    <form action="registrarSalida" method="POST">
        ID Entrenador: <input type="number" name="idEntrenador" required><br>
        <button type="submit">Registrar Salida</button>
    </form>

    <!-- Formulario para calcular horas trabajadas -->
    <h2>Calcular Horas Trabajadas</h2>
    <form action="calcularHorasTrabajadas" method="POST">
        ID Entrenador: <input type="number" name="idEntrenador" required><br>
        <button type="submit">Calcular</button>
    </form>
</body>
</html>
