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
    private static final String BD = "gimnasio";
    private static final String URL = "jdbc:mysql://localhost:3306/";
    private Connection conexion;

    /**
     * Establece una conexion a la base de datos
     * 
     * @return true si la conexion fue exitosa, false en caso contrario
     */
    public boolean conectar() {
        boolean estado = false;
        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection(URL+BD, USUARIO, PSWD);
            if(conexion!=null){
                estado=true;
                System.out.println("conectado");
            }
 
        } catch (ClassNotFoundException ex) {
            System.out.println("Error 1: "+ex.getMessage());
        } catch (SQLException ex) {
            System.out.println("Error 2: "+ex.getMessage());
        }
        return estado;
    }
    
    
    /**
     * Cierra la conexion a la base de datos
     * 
     * @return true si la desconexion fue exitosa, false en caso contrario
     */
    public boolean desconectar(){
        boolean estado= false;
        try {
            conexion.close();
            estado=true;
            System.out.println("desconectado");
        } catch (SQLException ex) {
            System.out.println("Error 1: "+ex.getMessage());
        }
        return estado;
    }
  
    
    
    
    
    public ArrayList<Socio> consultarSocio(){
        ArrayList<Socio> socios= new ArrayList<>();
        Statement sentenciaSQL;
        ResultSet rs;
        
        try {
            sentenciaSQL = conexion.createStatement();
            rs = sentenciaSQL.executeQuery("SELECT * FROM socios");

            while (rs.next()) {
                Socio sl = new Socio();
                sl.setIdSocio(rs.getString(1)); // Ajuste: getInt para id_socio
                sl.setNombre(rs.getString(2)); // Nombre
                sl.setFechaNacimiento(rs.getDate(3).toLocalDate()); // Conversión de Date a LocalDate
                sl.setTelefono(rs.getString(4)); // Teléfono
                sl.setEmail(rs.getString(5)); // Email
                sl.setFechaInscripcion(rs.getDate(6).toLocalDate()); // Conversión de Date a LocalDate
                sl.setMembresia(rs.getString(7)); // Membresía
                sl.setEstado(rs.getString(8)); // Estado
                socios.add(sl); // Añadir a la lista
            }
            
        } catch (SQLException ex) {
            System.out.println("Error 1: "+ex.getMessage());
        }
        return socios;
    }
  
     public ArrayList<Entrenador> consultarEntrenador(){
        ArrayList<Entrenador> entrenadores= new ArrayList<>();
        Statement sentenciaSQL;
        ResultSet rs;
        
        try {
            sentenciaSQL = conexion.createStatement();
            rs = sentenciaSQL.executeQuery("SELECT * FROM socios");

            while (rs.next()) {
                Entrenador el = new Entrenador();
                el.setIdEntrenador(rs.getString(1)); // Ajuste: getInt para id_socio
                el.setNombre(rs.getString(2)); // Nombre
                el.setEspecialidad(rs.getString(3)); // Conversión de Date a LocalDate
                el.setTelefono(rs.getString(4)); // Teléfono
                el.setHorario(rs.getString(5)); // Email
                el.setEstado(rs.getString(6)); // Estado
                entrenadores.add(el); // Añadir a la lista
            }
            
        } catch (SQLException ex) {
            System.out.println("Error 1: "+ex.getMessage());
        }
        return entrenadores;
    }   
    
     
    public ArrayList<Maquina> consultarMaquinas() {
        ArrayList<Maquina> maqList = new ArrayList<>();
        Statement sentenciaSQL;
        ResultSet rs;

        try {
            sentenciaSQL = conexion.createStatement();
            rs = sentenciaSQL.executeQuery("SELECT * FROM Maquinas");

            while (rs.next()) {
                Maquina maq = new Maquina();

                maq.setId_maquina(rs.getInt(1));
                maq.setNombre(rs.getString(2));
                maq.setTipo(rs.getString(3));
                maq.setUbicacion(rs.getString(4));
                maq.setEstado(rs.getString(5));

                maqList.add(maq);

            }

        } catch (SQLException ex) {
            System.out.println("Error 1: " + ex.getMessage());
        }
        System.out.println("Número de máquinas recuperadas: " + maqList.size());
        return maqList;
    }     

    
    public boolean agregarSocio(Socio socio){
        boolean estado=false;
        PreparedStatement ps;
        String query="INSERT INTO Socios VALUES(?,?,?)";
        
        try {
            ps=conexion.prepareStatement(query);
            ps.setString(1, socio.getIdSocio());
            ps.setString(2, socio.getNombre());
            ps.setDate(3, java.sql.Date.valueOf(socio.getFechaNacimiento()));
            ps.setString(4, socio.getTelefono());
            ps.setString(5, socio.getEmail());
            ps.setDate(6, java.sql.Date.valueOf(socio.getFechaInscripcion()));
            ps.setString(7, socio.getMembresia());
            ps.setString(8, socio.getEstado());
            ps.execute();
            estado=true;
        } catch (SQLException ex) {
            System.out.println("Error 1: "+ex.getMessage());
        }
        return estado;
    }
    
    public boolean eliminarSocio(String idSocio){
        boolean estado=false;
        Statement st;
        String query= "DELETE FROM alumnos WHERE matricula='"+idSocio+"'";
        
        try {
            st= conexion.createStatement();
            st.executeUpdate(query);
            estado=true;
        } catch (SQLException ex) {
            System.out.println("Error 1: "+ex.getMessage());
        }
        return estado;
    }

  
    public boolean actualizarSocio(Socio socio){
        boolean estado=false;
        PreparedStatement ps;
        String query= "UPDATE Socios SET nombre=? WHERE id_socio=?";
        
        try {
            ps=conexion.prepareStatement(query);
            ps.setString(1, socio.getIdSocio());
            ps.setString(2, socio.getNombre());
            ps.setDate(3, java.sql.Date.valueOf(socio.getFechaNacimiento()));
            ps.setString(4, socio.getTelefono());
            ps.setString(5, socio.getEmail());
            ps.setDate(6, java.sql.Date.valueOf(socio.getFechaInscripcion()));
            ps.setString(7, socio.getMembresia());
            ps.setString(8, socio.getEstado());

            ps.execute();
            estado=true;
        } catch (SQLException ex) {
           System.out.println("Error 1: "+ex.getMessage());
        }
        return estado;
    }

}
