/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datos;

import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelo.*;

/**
 *
 * @author Equipo 5: Max Alvarez Alvarez, Hugo Rubio Romero y Leonardo Rivas
 * Gutierrez
 */
public class OperacionBD {

    private static final String USUARIO = "root";
    private static final String PSWD = "root";
    private static final String URL = "jdbc:mysql://localhost:3306/gimnasio";
    private Connection conexion;

    
        public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USUARIO, PSWD);
    } 
        
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



    // Operaciones para Maquinas


    //Agregado



    private List<String> getAsistencias(String idSocio) {
        List<String> asistencias = new ArrayList<>();
        String query = "SELECT actividad FROM Asistencias WHERE id_socio = ?"; // Obtiene las actividades por socio
        try (PreparedStatement ps = conexion.prepareStatement(query)) {
            ps.setString(1, idSocio);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    asistencias.add(rs.getString("actividad"));
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return asistencias;
    }

}
