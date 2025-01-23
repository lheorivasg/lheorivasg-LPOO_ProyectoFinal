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
import java.sql.SQLException;;
import java.time.LocalDateTime;
import java.time.Duration;

/**
 *
 * @author Equipo 5: Max Alvarez Alvarez, Hugo Rubio Romero y Leonardo Rivas
 * Gutierrez
 */
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;

public class Entrenador {

    private int idEntrenador;
    private String nombre;
    private String especialidad;
    private String telefono;
    private String horario;
    private String estado;
    private LocalDateTime horaEntrada;
    private LocalDateTime horaSalida;

    // Constructor completo
    public Entrenador(int idEntrenador, String nombre, String especialidad, String telefono, String horario, String estado) {
        this.idEntrenador = idEntrenador;
        this.nombre = nombre;
        this.especialidad = especialidad;
        this.telefono = telefono;
        this.horario = horario;
        this.estado = estado;
    }

    public Entrenador(int idEntrenador, String nombre, String especialidad, String telefono, String horario, String estado, LocalDateTime horaEntrada, LocalDateTime horaSalida) {
        this.idEntrenador = idEntrenador;
        this.nombre = nombre;
        this.especialidad = especialidad;
        this.telefono = telefono;
        this.horario = horario;
        this.estado = estado;
        this.horaEntrada = horaEntrada;
        this.horaSalida = horaSalida;
    }

    public Entrenador(String nombre, String especialidad, String telefono, String horario, String estado, LocalDateTime horaEntrada, LocalDateTime horaSalida) {
        this.nombre = nombre;
        this.especialidad = especialidad;
        this.telefono = telefono;
        this.horario = horario;
        this.estado = estado;
        this.horaEntrada = horaEntrada;
        this.horaSalida = horaSalida;
    }

    public Entrenador(int idEntrenador, String nombre, String especialidad, String telefono, String horario) {
        this.idEntrenador = idEntrenador;
        this.nombre = nombre;
        this.especialidad = especialidad;
        this.telefono = telefono;
        this.horario = horario;
    }
    
    
    

    // Constructor vacío
    public Entrenador() {
    }

    // Registrar entrada
    public boolean registrarEntrada(int idEntrenador) {
        String query = "UPDATE Entrenadores SET hora_entrada = NOW() WHERE id_entrenador = ?";
        try (Connection con = OperacionBD.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setInt(1, idEntrenador);  // Usamos setInt para el idEntrenador como int

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Registrar salida
    public boolean registrarSalida(int idEntrenador) {
        String query = "UPDATE Entrenadores SET hora_salida = NOW() WHERE id_entrenador = ?";
        try (Connection con = OperacionBD.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setInt(1, idEntrenador);  // Usamos setInt para el idEntrenador como int

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Calcular horas trabajadas
    public int calcularHorasTrabajadas(int idEntrenador) {
        String query = "SELECT TIMESTAMPDIFF(HOUR, hora_entrada, hora_salida) AS horas FROM Entrenadores WHERE id_entrenador = ?";
        try (Connection con = OperacionBD.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setInt(1, idEntrenador);  // Usamos setInt para el idEntrenador como int

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("horas");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // En caso de error
    }

    // Modificar disponibilidad
    public boolean modificarDisponibilidad(int idEntrenador, String nuevoEstado) {
        String query = "UPDATE Entrenadores SET estado = ? WHERE id_entrenador = ?";
        try (Connection con = OperacionBD.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, nuevoEstado);
            stmt.setInt(2, idEntrenador);  // Usamos setInt para el idEntrenador como int

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Modificar horario
    public boolean modificarHorario(int idEntrenador, String nuevoHorario) {
        String query = "UPDATE Entrenadores SET horario = ? WHERE id_entrenador = ?";
        try (Connection con = OperacionBD.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, nuevoHorario);
            stmt.setInt(2, idEntrenador);  // Usamos setInt para el idEntrenador como int

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Getters y setters
    public int getIdEntrenador() {
        return idEntrenador;
    }

    public void setIdEntrenador(int idEntrenador) {
        this.idEntrenador = idEntrenador;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEspecialidad() {
        return especialidad;
    }

    public void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getHorario() {
        return horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public LocalDateTime getHoraEntrada() {
        return horaEntrada;
    }

    public void setHoraEntrada(LocalDateTime horaEntrada) {
        this.horaEntrada = horaEntrada;
    }

    public LocalDateTime getHoraSalida() {
        return horaSalida;
    }

    public void setHoraSalida(LocalDateTime horaSalida) {
        this.horaSalida = horaSalida;
    }

public ArrayList<Entrenador> consultarEntrenador() {
    ArrayList<Entrenador> entrenadores = new ArrayList<>();
    String query = "SELECT * FROM Entrenadores";
    try (Connection conexion = OperacionBD.getConnection();
         Statement st = conexion.createStatement();
         ResultSet rs = st.executeQuery(query)) {
        while (rs.next()) {
            Entrenador entrenador = new Entrenador();
            entrenador.setIdEntrenador(rs.getInt("id_entrenador"));
            entrenador.setNombre(rs.getString("nombre"));
            entrenador.setEspecialidad(rs.getString("especialidad"));
            entrenador.setTelefono(rs.getString("telefono"));
            entrenador.setHorario(rs.getString("horario"));
            entrenador.setEstado(rs.getString("estado"));
            entrenadores.add(entrenador);
        }
    } catch (SQLException ex) {
        System.out.println("Error: " + ex.getMessage());
    }
    return entrenadores;
}

public boolean agregarEntrenador() {
    String getMaxIdQuery = "SELECT COALESCE(MAX(CAST(id_entrenador AS UNSIGNED)), 0) + 1 AS next_id FROM Entrenadores";
    String insertQuery = "INSERT INTO Entrenadores (id_entrenador, nombre, especialidad, telefono, horario, estado) VALUES (?, ?, ?, ?, ?, ?)";

    try (Connection conexion = OperacionBD.getConnection();
         Statement st = conexion.createStatement();
         ResultSet rs = st.executeQuery(getMaxIdQuery)) {

        if (rs.next()) {
            int nextId = rs.getInt("next_id");
            this.setIdEntrenador(nextId);

            try (PreparedStatement ps = conexion.prepareStatement(insertQuery)) {
                ps.setInt(1, this.getIdEntrenador());
                ps.setString(2, this.getNombre());
                ps.setString(3, this.getEspecialidad());
                ps.setString(4, this.getTelefono());
                ps.setString(5, this.getHorario());
                ps.setString(6, this.getEstado());
                ps.executeUpdate();
                return true;
            }
        }
    } catch (SQLException ex) {
        System.out.println("Error: " + ex.getMessage());
    }
    return false;
}

public boolean actualizarEntrenador() {
    String query = "UPDATE Entrenadores SET nombre = ?, especialidad = ?, telefono = ?, horario = ?, estado = ? WHERE id_entrenador = ?";
    try (Connection conexion = OperacionBD.getConnection();
         PreparedStatement ps = conexion.prepareStatement(query)) {
        ps.setString(1, this.getNombre());
        ps.setString(2, this.getEspecialidad());
        ps.setString(3, this.getTelefono());
        ps.setString(4, this.getHorario());
        ps.setString(5, this.getEstado());
        ps.setInt(6, this.getIdEntrenador());
        ps.executeUpdate();
        return true;
    } catch (SQLException ex) {
        System.out.println("Error: " + ex.getMessage());
    }
    return false;
}

public boolean eliminarEntrenador(int idEntrenador) {
    String deleteQuery = "DELETE FROM Entrenadores WHERE id_entrenador = ?";
    String resetAutoIncrementQuery = "ALTER TABLE Entrenadores AUTO_INCREMENT = ?";
    try (Connection conexion = OperacionBD.getConnection();
         PreparedStatement ps = conexion.prepareStatement(deleteQuery)) {
        ps.setInt(1, idEntrenador);
        ps.executeUpdate();

        try (Statement st = conexion.createStatement();
             ResultSet rs = st.executeQuery("SELECT MAX(CAST(id_entrenador AS UNSIGNED)) AS max_id FROM Entrenadores")) {
            if (rs.next()) {
                int maxId = rs.getInt("max_id");
                try (PreparedStatement resetPs = conexion.prepareStatement(resetAutoIncrementQuery)) {
                    resetPs.setInt(1, maxId + 1);
                    resetPs.executeUpdate();
                }
            }
        }
        return true;
    } catch (SQLException ex) {
        System.out.println("Error: " + ex.getMessage());
    }
    return false;
}



    
    
    
    @Override
    public String toString() {
        return "Entrenador{" +
                "idEntrenador=" + idEntrenador +
                ", nombre='" + nombre + '\'' +
                ", especialidad='" + especialidad + '\'' +
                ", telefono='" + telefono + '\'' +
                ", horario='" + horario + '\'' +
                ", estado='" + estado + '\'' +
                ", horaEntrada=" + horaEntrada +
                ", horaSalida=" + horaSalida +
                '}';
    }
}

