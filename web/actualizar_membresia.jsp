<%@page import="java.util.List"%>
<%@page import="modelo.Socio"%>
<%@page import="datos.OperacionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestionar Membresía</title>
        <!-- Enlace al nuevo archivo de CSS -->
        <link href="estilos3.css" rel="stylesheet">
    </head>
    <body>
        <h1>Gestionar Membresía</h1>

        <%
            String mensaje = "";
            try {
                String accion = request.getParameter("accion");

                if (accion != null && "enviar".equals(accion)) {
                    String idSocio = request.getParameter("idSocioActualizar");
                    String tipoMembresia = request.getParameter("nuevaMembresia");
                    String estado = request.getParameter("nuevoEstado");
                    String duracion = request.getParameter("nuevoDuracion");

                    if (idSocio != null && !idSocio.isEmpty() && tipoMembresia != null && estado != null && duracion != null) {
                        OperacionBD operacionBD = new OperacionBD();
                        if (operacionBD.conectar()) {
                            Socio socioActualizado = new Socio();
                            socioActualizado.setIdSocio(idSocio);
                            socioActualizado.setTipoMembresia(tipoMembresia);
                            socioActualizado.setEstado(estado);
                            socioActualizado.setDuracion(duracion);

                            boolean resultado = operacionBD.actualizarSocio(socioActualizado);
                            mensaje = resultado ? "Socio actualizado con éxito." : "Error al actualizar el socio.";
                            operacionBD.desconectar();
                        } else {
                            mensaje = "Error al conectar con la base de datos.";
                        }
                    } else {
                        mensaje = "Todos los campos son obligatorios.";
                    }
                }
            } catch (Exception e) {
                mensaje = "Error: " + e.getMessage();
            }
        %>

        <!-- Mostrar mensaje al usuario -->
        <p><%= mensaje%></p>

        <!-- Formulario para gestionar membresía -->
        <form action="" method="post">
            <input type="hidden" name="accion" value="enviar">
            <label for="idSocioActualizar">ID Socio:</label>
            <input type="text" name="idSocioActualizar" size="15" required><br><br>

            <label for="suscribirse">Gestionar Membresía</label><br><br>
            
            <div class="estado-membresia">
                <label for="suscribirse">Suscribirse</label>
                <input type="radio" name="nuevoEstado" id="suscribirse" value="suscribirse" checked>

                <label for="renovar">Renovar</label>
                <input type="radio" name="nuevoEstado" id="renovar" value="renovar">

                <label for="cancelar">Cancelar</label>
                <input type="radio" name="nuevoEstado" id="cancelar" value="cancelar">
            </div><br><br>

            <label for="nuevaMembresia">Tipo de Membresía</label><br><br>

            <div class="tipo-membresia">
                <label for="powerSmart">Power Smart</label>
                <input type="radio" name="nuevaMembresia" id="powerSmart" value="Power Smart" checked>
                <p>Acceso básico a todas las áreas del gimnasio durante horarios estándar. Ideal para nuevos miembros que desean iniciarse en el ejercicio.</p>

                <label for="maxPerformance">Max Performance</label>
                <input type="radio" name="nuevaMembresia" id="maxPerformance" value="Max Performance">
                <p>Acceso total a todas las instalaciones, clases personalizadas y seguimiento mensual.</p>

                <label for="fullFlex">Full Flex</label>
                <input type="radio" name="nuevaMembresia" id="fullFlex" value="Full Flex">
                <p>Acceso ilimitado a todas las instalaciones del gimnasio 24/7 y clases exclusivas con entrenadores.</p>

                <label for="elite">Elite</label>
                <input type="radio" name="nuevaMembresia" id="elite" value="Elite">
                <p>Acceso ilimitado a todas las instalaciones 24/7, clases personalizadas con entrenadores especializados y seguimiento con nutriólogos.</p>
            </div><br>

            <label for="nuevoDuracion">Duración</label><br>
            <select name="nuevoDuracion" id="nuevoDuracion" required>
                <option value="" disabled selected>Selecciona una opción</option>
                <option value="Mensual">Mensual</option>
                <option value="Trimestral">Trimestral</option>
                <option value="Semestral">Semestral</option>
                <option value="Anual">Anual</option>
            </select><br><br>

            <input type="submit" value="Enviar">
        </form>

    </body>
</html>
