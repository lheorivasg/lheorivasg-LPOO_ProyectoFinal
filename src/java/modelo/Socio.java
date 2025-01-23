/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import datos.OperacionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Equipo 5: Max Alvarez Alvarez, Hugo Rubio Romero y Leonardo Rivas
 * Gutierrez
 */
public class Socio {

    private String idSocio;
    private String nombre;
    private LocalDate fechaNacimiento;
    private String telefono;
    private String email;
    private LocalDate fechaInscripcion;
    private String tipoMembresia;
    private String estado;
    private String duracion;

    private List<String> asistencia;
    private OperacionBD operacionBD;

    public Socio() {
        this.operacionBD = new OperacionBD();
    }

    public Socio(List<String> asistencia) {
        this.asistencia = asistencia;
        this.operacionBD = new OperacionBD();
    }

    public Socio(String idSocio, String nombre, LocalDate fechaNacimiento, String telefono, String email, LocalDate fechaInscripcion, String tipoMembresia, String estado, String duracion) {
        this.idSocio = idSocio;
        this.nombre = nombre;
        this.fechaNacimiento = fechaNacimiento;
        this.telefono = telefono;
        this.email = email;
        this.fechaInscripcion = fechaInscripcion;
        this.tipoMembresia = tipoMembresia;
        this.estado = estado;
        this.duracion = duracion;
        this.asistencia = new ArrayList<>();
        this.operacionBD = new OperacionBD();
    }

    public Socio(String nombre, LocalDate fechaNacimiento, String telefono, String email, LocalDate fechaInscripcion, String tipoMembresia, String estado, String duracion) {
        this.nombre = nombre;
        this.fechaNacimiento = fechaNacimiento;
        this.telefono = telefono;
        this.email = email;
        this.fechaInscripcion = fechaInscripcion;
        this.tipoMembresia = tipoMembresia;
        this.estado = estado;
        this.duracion = duracion;
        this.asistencia = new ArrayList<>();
        this.operacionBD = new OperacionBD();
    }

    public String getIdSocio() {
        return idSocio;
    }

    public void setIdSocio(String idSocio) {
        this.idSocio = idSocio;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public LocalDate getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDate getFechaInscripcion() {
        return fechaInscripcion;
    }

    public void setFechaInscripcion(LocalDate fechaInscripcion) {
        this.fechaInscripcion = fechaInscripcion;
    }

    public String getTipoMembresia() {
        return tipoMembresia;
    }

    public void setTipoMembresia(String tipoMembresia) {
        this.tipoMembresia = tipoMembresia;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getDuracion() {
        return duracion;
    }

    public void setDuracion(String duracion) {
        this.duracion = duracion;
    }

    public List<String> getAsistencia() {
        return asistencia;
    }

    public void setAsistencia(List<String> asistencia) {
        this.asistencia = asistencia;
    }
    
    public int getNumeroDeAsistencias(){
        return asistencia.size();
    }

    @Override
    public String toString() {
        return "Socio" + "idSocio" + idSocio + "nombre" + nombre + "fechaNacimiento=" + fechaNacimiento + "telefono=" + telefono + "email=" + email + "fechaInscripcion=" + fechaInscripcion + "tipoMembresia=" + tipoMembresia + "estado=" + estado + "duracion=" + duracion;
    }

    public boolean agregarSocio(Socio socio) {
    String getMaxIdQuery = "SELECT COALESCE(MAX(id_socio), 0) + 1 AS next_id FROM Socios";
    String insertQuery = "INSERT INTO Socios (id_socio, nombre, fecha_nacimiento, telefono, email, fecha_inscripcion, membresia, estado, duracion) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    try (Connection conexion = OperacionBD.getConnection();
         Statement st = conexion.createStatement();
         ResultSet rs = st.executeQuery(getMaxIdQuery)) {

        if (rs.next()) {
            int nextId = rs.getInt("next_id"); // Obtener el siguiente ID
            socio.setIdSocio(String.valueOf(nextId)); // Asignar el nuevo ID al socio

            try (PreparedStatement ps = conexion.prepareStatement(insertQuery)) {
                ps.setInt(1, nextId); // Establecer el nuevo ID en la inserción
                ps.setString(2, socio.getNombre());
                ps.setDate(3, java.sql.Date.valueOf(socio.getFechaNacimiento()));
                ps.setString(4, socio.getTelefono());
                ps.setString(5, socio.getEmail());
                ps.setDate(6, java.sql.Date.valueOf(socio.getFechaInscripcion()));
                ps.setString(7, socio.getTipoMembresia());
                ps.setString(8, socio.getEstado());
                ps.setString(9, socio.getDuracion());
                ps.executeUpdate();
                return true;
            }
        }
    } catch (SQLException ex) {
        System.out.println("Error al agregar socio: " + ex.getMessage());
    }
    return false;
}

public boolean actualizarSocio(Socio socio) {
    String query = "UPDATE Socios SET nombre = ?, fecha_nacimiento = ?, telefono = ?, email = ?, fecha_inscripcion = ?, membresia = ?, estado = ?, duracion = ? WHERE id_socio = ?";
    try (Connection conexion = OperacionBD.getConnection();
         PreparedStatement ps = conexion.prepareStatement(query)) {
        ps.setString(1, socio.getNombre());
        ps.setDate(2, java.sql.Date.valueOf(socio.getFechaNacimiento()));
        ps.setString(3, socio.getTelefono());
        ps.setString(4, socio.getEmail());
        ps.setDate(5, java.sql.Date.valueOf(socio.getFechaInscripcion()));
        ps.setString(6, socio.getTipoMembresia());
        ps.setString(7, socio.getEstado());
        ps.setString(8, socio.getDuracion());
        ps.setInt(9, Integer.parseInt(socio.getIdSocio()));
        ps.executeUpdate();
        return true;
    } catch (SQLException ex) {
        System.out.println("Error al actualizar socio: " + ex.getMessage());
    }
    return false;
}

public boolean eliminarSocio(String idSocio) {
    String deleteQuery = "DELETE FROM Socios WHERE id_socio = ?";
    try (Connection conexion = OperacionBD.getConnection();
         PreparedStatement ps = conexion.prepareStatement(deleteQuery)) {
        ps.setInt(1, Integer.parseInt(idSocio));
        ps.executeUpdate();
        return true;
    } catch (SQLException ex) {
        System.out.println("Error al eliminar socio: " + ex.getMessage());
    }
    return false;
}

public ArrayList<Socio> consultarSocio() {
    ArrayList<Socio> socios = new ArrayList<>();
    String query = "SELECT * FROM Socios";
    try (Connection conexion = OperacionBD.getConnection();
         Statement st = conexion.createStatement();
         ResultSet rs = st.executeQuery(query)) {
        while (rs.next()) {
            Socio socio = new Socio();
            socio.setIdSocio(rs.getString("id_socio"));
            socio.setNombre(rs.getString("nombre"));
            socio.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
            socio.setTelefono(rs.getString("telefono"));
            socio.setEmail(rs.getString("email"));
            socio.setFechaInscripcion(rs.getDate("fecha_inscripcion").toLocalDate());
            socio.setTipoMembresia(rs.getString("membresia"));
            socio.setEstado(rs.getString("estado"));
            socio.setDuracion(rs.getString("duracion"));
            socios.add(socio);
        }
    } catch (SQLException ex) {
        System.out.println("Error: " + ex.getMessage());
    }
    return socios;
}

}
