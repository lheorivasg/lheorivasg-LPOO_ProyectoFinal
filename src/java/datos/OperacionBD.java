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
        String getMaxIdQuery = "SELECT COALESCE(MAX(id_socio), 0) + 1 AS next_id FROM Socios";
        String insertQuery = "INSERT INTO Socios (id_socio, nombre, fecha_nacimiento, telefono, email, fecha_inscripcion, membresia, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Statement st = conexion.createStatement();
                ResultSet rs = st.executeQuery(getMaxIdQuery)) {

            if (rs.next()) {
                int nextId = rs.getInt("next_id"); // Calcular el siguiente ID
                socio.setIdSocio(String.valueOf(nextId));

                // Insertar el socio con el nuevo ID calculado
                try (PreparedStatement ps = conexion.prepareStatement(insertQuery)) {
                    ps.setInt(1, nextId); // ID calculado
                    ps.setString(2, socio.getNombre());
                    ps.setDate(3, java.sql.Date.valueOf(socio.getFechaNacimiento()));
                    ps.setString(4, socio.getTelefono());
                    ps.setString(5, socio.getEmail());
                    ps.setDate(6, java.sql.Date.valueOf(socio.getFechaInscripcion()));
                    ps.setString(7, socio.getMembresia());
                    ps.setString(8, socio.getEstado());
                    ps.executeUpdate();
                    return true;
                }
            }
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
        String deleteQuery = "DELETE FROM Socios WHERE id_socio = ?";
        String resetAutoIncrementQuery = "ALTER TABLE Socios AUTO_INCREMENT = ?";
        try (PreparedStatement ps = conexion.prepareStatement(deleteQuery)) {
            ps.setInt(1, Integer.parseInt(idSocio));
            ps.executeUpdate();

            // Obtener el último ID
            try (Statement st = conexion.createStatement();
                    ResultSet rs = st.executeQuery("SELECT MAX(id_socio) AS max_id FROM Socios")) {
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
        String getMaxIdQuery = "SELECT COALESCE(MAX(id_entrenador), 0) + 1 AS next_id FROM Entrenadores";
        String insertQuery = "INSERT INTO Entrenadores (id_entrenador, nombre, especialidad, telefono, horario, estado) VALUES (?, ?, ?, ?, ?, ?)";

        try (Statement st = conexion.createStatement();
                ResultSet rs = st.executeQuery(getMaxIdQuery)) {

            if (rs.next()) {
                int nextId = rs.getInt("next_id"); // Calcular el siguiente ID
                entrenador.setIdEntrenador(String.valueOf(nextId));

                // Insertar el entrenador con el nuevo ID calculado
                try (PreparedStatement ps = conexion.prepareStatement(insertQuery)) {
                    ps.setInt(1, nextId); // ID calculado
                    ps.setString(2, entrenador.getNombre());
                    ps.setString(3, entrenador.getEspecialidad());
                    ps.setString(4, entrenador.getTelefono());
                    ps.setString(5, entrenador.getHorario());
                    ps.setString(6, entrenador.getEstado());
                    ps.executeUpdate();
                    return true;
                }
            }
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
        String deleteQuery = "DELETE FROM Entrenadores WHERE id_entrenador = ?";
        String resetAutoIncrementQuery = "ALTER TABLE Entrenadores AUTO_INCREMENT = ?";
        try (PreparedStatement ps = conexion.prepareStatement(deleteQuery)) {
            ps.setInt(1, Integer.parseInt(idEntrenador));
            ps.executeUpdate();

            // Obtener el último ID
            try (Statement st = conexion.createStatement();
                    ResultSet rs = st.executeQuery("SELECT MAX(id_entrenador) AS max_id FROM Entrenadores")) {
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
        String getMaxIdQuery = "SELECT COALESCE(MAX(id_maquina), 0) + 1 AS next_id FROM Maquinas";
        String insertQuery = "INSERT INTO Maquinas (id_maquina, nombre, tipo, ubicacion, estado) VALUES (?, ?, ?, ?, ?)";

        try (Statement st = conexion.createStatement();
                ResultSet rs = st.executeQuery(getMaxIdQuery)) {

            if (rs.next()) {
                int nextId = rs.getInt("next_id"); // Calcular el siguiente ID
                maquina.setId_maquina(String.valueOf(nextId));

                // Insertar la máquina con el nuevo ID calculado
                try (PreparedStatement ps = conexion.prepareStatement(insertQuery)) {
                    ps.setInt(1, nextId); // ID calculado
                    ps.setString(2, maquina.getNombre());
                    ps.setString(3, maquina.getTipo());
                    ps.setString(4, maquina.getUbicacion());
                    ps.setString(5, maquina.getEstado());
                    ps.executeUpdate();
                    return true;
                }
            }
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
        String deleteQuery = "DELETE FROM Maquinas WHERE id_maquina = ?";
        String resetAutoIncrementQuery = "ALTER TABLE Maquinas AUTO_INCREMENT = ?";
        try (PreparedStatement ps = conexion.prepareStatement(deleteQuery)) {
            ps.setInt(1, Integer.parseInt(idMaquina));
            ps.executeUpdate();

            // Obtener el último ID
            try (Statement st = conexion.createStatement();
                    ResultSet rs = st.executeQuery("SELECT MAX(id_maquina) AS max_id FROM Maquinas")) {
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

}
