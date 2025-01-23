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
import java.sql.SQLException;import java.sql.Statement;
;
import java.time.LocalDateTime;
import java.time.Duration;
import java.util.ArrayList;


/**
 *
 * @author Kirig
 */
public class Maquina {

    private String id_maquina;
    private String nombre;
    private String tipo;
    private String ubicacion;
    private String estado;

    public Maquina() {
    }

    public Maquina(String id_maquina, String nombre, String tipo, String ubicacion, String estado) {
        this.id_maquina = id_maquina;
        this.nombre = nombre;
        this.tipo = tipo;
        this.ubicacion = ubicacion;
        this.estado = estado;
    }

    public String getId_maquina() {
        return id_maquina;
    }

    public void setId_maquina(String id_maquina) {
        this.id_maquina = id_maquina;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    
    public ArrayList<Maquina> consultarMaquina() {
        ArrayList<Maquina> maquinas = new ArrayList<>();
        String query = "SELECT * FROM Maquinas";
        try (Connection conexion = OperacionBD.getConnection();
             Statement st = conexion.createStatement();
             ResultSet rs = st.executeQuery(query)) {
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

        try (Connection conexion = OperacionBD.getConnection();
             Statement st = conexion.createStatement();
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
        try (Connection conexion = OperacionBD.getConnection();
             PreparedStatement ps = conexion.prepareStatement(query)) {
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
        try (Connection conexion = OperacionBD.getConnection();
             PreparedStatement ps = conexion.prepareStatement(deleteQuery)) {
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


    
    
    

    @Override
    public String toString() {
        return "Maquina:\t" + "id_maquina: " + id_maquina + "\nnombre: " + nombre + "\ttipo: " + tipo + "\tubicacion: " + ubicacion + "\testado: " + estado + "\n";
    }

}
