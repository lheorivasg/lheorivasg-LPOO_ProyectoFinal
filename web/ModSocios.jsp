<%-- 
    Document   : Socios
    Created on : Jan 18, 2025, 3:11:14 PM
    Author     : Kirig
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="datos.OperacionBD" %>
<%@ page import="modelo.Socio" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Socios del Gimnasio</title>
</head>
<body>

    <h2>Lista de Socios</h2>

    <form action="Socios.jsp" method="post">
        <label for="nombre">Nombre:</label>
        <input type="text" name="nombre" id="nombre" required />
        <label for="telefono">Teléfono:</label>
        <input type="text" name="telefono" id="telefono" />
        <label for="email">Correo Electrónico:</label>
        <input type="email" name="email" id="email" />
        <label for="membresia">Membresía:</label>
        <input type="text" name="membresia" id="membresia" />
        <label for="estado">Estado:</label>
        <input type="text" name="estado" id="estado" />
        <button type="submit" name="accion" value="agregar">Agregar Socio</button>
    </form>

    <c:if test="${not empty socios}">
        <table border="1">
            <thead>
                <tr>
                    <th>ID Socio</th>
                    <th>Nombre</th>
                    <th>Teléfono</th>
                    <th>Email</th>
                    <th>Membresía</th>
                    <th>Estado</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="socio" items="${socios}">
                    <tr>
                        <td>${socio.idSocio}</td>
                        <td>${socio.nombre}</td>
                        <td>${socio.telefono}</td>
                        <td>${socio.email}</td>
                        <td>${socio.membresia}</td>
                        <td>${socio.estado}</td>
                        <td>
                            <a href="editarSocio.jsp?id=${socio.idSocio}">Editar</a>
                            <a href="Socios.jsp?action=eliminar&id=${socio.idSocio}">Eliminar</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <p style="color:red;">${errorMessage}</p>
    </c:if>

</body>
</html>

