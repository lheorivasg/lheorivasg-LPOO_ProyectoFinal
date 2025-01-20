/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelo.*;


/**
 *
 * @author Equipo 5: Max Alvarez Alvarez, Hugo Rubio Romero y Leonardo Rivas Gutierrez
 */
public class OperacionBD {

    private static final String USUARIO = "root";
    private static final String PSWD = "root";
    private Connection conexion;

    public boolean conectar() {
        boolean estado = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/gimnasio", USUARIO, PSWD);
            estado = (conexion != null);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return estado;
    }

    public boolean desconectar() {
        try {
            if (conexion != null && !conexion.isClosed()) {
                conexion.close();
                return true;
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return false;
    }

    // Operaciones para Socios
    public ArrayList<Socio> consultarSocio() {
        ArrayList<Socio> socios = new ArrayList<>();
        String query = "SELECT * FROM Socios";
        try (Statement st = conexion.createStatement(); ResultSet rs = st.executeQuery(query)) {
            while (rs.next()) {
                Socio socio = new Socio();
                socio.setIdSocio(rs.getString("id_socio"));
                socio.setNombre(rs.getString("nombre"));
                socio.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
                socio.setTelefono(rs.getString("telefono"));
                socio.setEmail(rs.getString("email"));
                socio.setFechaInscripcion(rs.getDate("fecha_inscripcion").toLocalDate());
                socio.setMembresia(rs.getString("membresia"));
                socio.setEstado(rs.getString("estado"));
                socios.add(socio);
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return socios;
    }

    public boolean agregarSocio(Socio socio) {
        String query = "INSERT INTO Socios (nombre, fecha_nacimiento, telefono, email, fecha_inscripcion, membresia, estado) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conexion.prepareStatement(query)) {
            ps.setString(1, socio.getNombre());
            ps.setDate(2, java.sql.Date.valueOf(socio.getFechaNacimiento()));
            ps.setString(3, socio.getTelefono());
            ps.setString(4, socio.getEmail());
            ps.setDate(5, java.sql.Date.valueOf(socio.getFechaInscripcion()));
            ps.setString(6, socio.getMembresia());
            ps.setString(7, socio.getEstado());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return false;
    }

    public boolean actualizarSocio(Socio socio) {
        String query = "UPDATE Socios SET nombre = ?, fecha_nacimiento = ?, telefono = ?, email = ?, fecha_inscripcion = ?, membresia = ?, estado = ? WHERE id_socio = ?";
        try (PreparedStatement ps = conexion.prepareStatement(query)) {
            ps.setString(1, socio.getNombre());
            ps.setDate(2, java.sql.Date.valueOf(socio.getFechaNacimiento()));
            ps.setString(3, socio.getTelefono());
            ps.setString(4, socio.getEmail());
            ps.setDate(5, java.sql.Date.valueOf(socio.getFechaInscripcion()));
            ps.setString(6, socio.getMembresia());
            ps.setString(7, socio.getEstado());
            ps.setInt(8, Integer.parseInt(socio.getIdSocio()));
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return false;
    }

    public boolean eliminarSocio(String idSocio) {
        String query = "DELETE FROM Socios WHERE id_socio = ?";
        try (PreparedStatement ps = conexion.prepareStatement(query)) {
            ps.setInt(1, Integer.parseInt(idSocio));
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return false;
    }

    // Operaciones para Entrenadores
    public ArrayList<Entrenador> consultarEntrenador() {
        ArrayList<Entrenador> entrenadores = new ArrayList<>();
        String query = "SELECT * FROM Entrenadores";
        try (Statement st = conexion.createStatement(); ResultSet rs = st.executeQuery(query)) {
            while (rs.next()) {
                Entrenador entrenador = new Entrenador();
                entrenador.setIdEntrenador(rs.getString("id_entrenador"));
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

    public boolean agregarEntrenador(Entrenador entrenador) {
        String query = "INSERT INTO Entrenadores (nombre, especialidad, telefono, horario, estado) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conexion.prepareStatement(query)) {
            ps.setString(1, entrenador.getNombre());
            ps.setString(2, entrenador.getEspecialidad());
            ps.setString(3, entrenador.getTelefono());
            ps.setString(4, entrenador.getHorario());
            ps.setString(5, entrenador.getEstado());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return false;
    }

    public boolean actualizarEntrenador(Entrenador entrenador) {
        String query = "UPDATE Entrenadores SET nombre = ?, especialidad = ?, telefono = ?, horario = ?, estado = ? WHERE id_entrenador = ?";
        try (PreparedStatement ps = conexion.prepareStatement(query)) {
            ps.setString(1, entrenador.getNombre());
            ps.setString(2, entrenador.getEspecialidad());
            ps.setString(3, entrenador.getTelefono());
            ps.setString(4, entrenador.getHorario());
            ps.setString(5, entrenador.getEstado());
            ps.setInt(6, Integer.parseInt(entrenador.getIdEntrenador()));
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return false;
    }

    public boolean eliminarEntrenador(String idEntrenador) {
        String query = "DELETE FROM Entrenadores WHERE id_entrenador = ?";
        try (PreparedStatement ps = conexion.prepareStatement(query)) {
            ps.setInt(1, Integer.parseInt(idEntrenador));
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return false;
    }

    // Operaciones para Maquinas
    public ArrayList<Maquina> consultarMaquina() {
        ArrayList<Maquina> maquinas = new ArrayList<>();
        String query = "SELECT * FROM Maquinas";
        try (Statement st = conexion.createStatement(); ResultSet rs = st.executeQuery(query)) {
            while (rs.next()) {
                Maquina maquina = new Maquina();
                maquina.setId_maquina(rs.getString("id_maquina"));
                maquina.setNombre(rs.getString("nombre"));
                maquina.setTipo(rs.getString("tipo"));
                maquina.setUbicacion(rs.getString("ubicacion"));
                maquina.setEstado(rs.getString("estado"));
                maquinas.add(maquina);
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return maquinas;
    }

    public boolean agregarMaquina(Maquina maquina) {
        String query = "INSERT INTO Maquinas (nombre, tipo, ubicacion, estado) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conexion.prepareStatement(query)) {
            ps.setString(1, maquina.getNombre());
            ps.setString(2, maquina.getTipo());
            ps.setString(3, maquina.getUbicacion());
            ps.setString(4, maquina.getEstado());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return false;
    }

    public boolean actualizarMaquina(Maquina maquina) {
        String query = "UPDATE Maquinas SET nombre = ?, tipo = ?, ubicacion = ?, estado = ? WHERE id_maquina = ?";
        try (PreparedStatement ps = conexion.prepareStatement(query)) {
            ps.setString(1, maquina.getNombre());
            ps.setString(2, maquina.getTipo());
            ps.setString(3, maquina.getUbicacion());
            ps.setString(4, maquina.getEstado());
            ps.setInt(5, Integer.parseInt(maquina.getId_maquina()));
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return false;
    }

    public boolean eliminarMaquina(String idMaquina) {
        String query = "DELETE FROM Maquinas WHERE id_maquina = ?";
        try (PreparedStatement ps = conexion.prepareStatement(query)) {
            ps.setInt(1, Integer.parseInt(idMaquina));
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return false;
    }
}
