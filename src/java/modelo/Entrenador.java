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
 * @author Equipo 5: Max Alvarez Alvarez, Hugo Rubio Romero y Leonardo Rivas Gutierrez
 */
public class Entrenador {
    private String idEntrenador;
    private String nombre;
    private String especialidad;
    private String telefono;
    private String horario;
    private String estado;
    private LocalDateTime horaEntrada;
    private LocalDateTime horaSalida;

    // Constructor completo
    public Entrenador(String idEntrenador, String nombre, String especialidad, String telefono, String horario, String estado) {
        this.idEntrenador = idEntrenador;
        this.nombre = nombre;
        this.especialidad = especialidad;
        this.telefono = telefono;
        this.horario = horario;
        this.estado = estado;
    }

    // Constructor vacío
    public Entrenador() {
    }

    // Registrar entrada
    public boolean registrarEntrada(int idEntrenador) {
        String query = "UPDATE Entrenadores SET hora_entrada = NOW() WHERE id_entrenador = ?";
        try (Connection con = OperacionBD.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setInt(1, idEntrenador);

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

            stmt.setInt(1, idEntrenador);

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

            stmt.setInt(1, idEntrenador);

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
    
    
    public boolean modificarDisponibilidad(int idEntrenador, String nuevoEstado) {
        String query = "UPDATE Entrenadores SET estado = ? WHERE id_entrenador = ?";
        try (Connection con = OperacionBD.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, nuevoEstado);
            stmt.setInt(2, idEntrenador);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }    
    
    
    public boolean modificarHorario(int idEntrenador, String nuevoHorario) {
        String query = "UPDATE Entrenadores SET horario = ? WHERE id_entrenador = ?";
        try (Connection con = OperacionBD.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, nuevoHorario);
            stmt.setInt(2, idEntrenador);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }    
    
    
    //Reescribir actualizar metodo de actualizar para que modifique disponibilidad y horario

    // Getters y setters
    public String getIdEntrenador() {
        return idEntrenador;
    }

    public void setIdEntrenador(String idEntrenador) {
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

    @Override
    public String toString() {
        return "Entrenador{" +
                "idEntrenador='" + idEntrenador + '\'' +
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

