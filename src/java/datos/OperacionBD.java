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


/**
 *
 * @author Equipo 5: Max Alvarez Alvarez, Hugo Rubio Romero y Leonardo Rivas Gutierrez
 */
public class OperacionBD {

    private static final String USUARIO = "root";
    private static final String PSWD = "root";
    private static final String BD = "escuela";
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
  
    
    
    
    /**
    public ArrayList<Alumno> consultarAlumnos(){
        ArrayList<Alumno> alumnos= new ArrayList<>();
        Statement sentenciaSQL;
        ResultSet rs;
        
        try {
            sentenciaSQL= conexion.createStatement();
            rs=sentenciaSQL.executeQuery("SELECT * FROM alumnos");
            
             while(rs.next()){
                Alumno al= new Alumno();
                al.setMatricula(rs.getString(1));
                al.setNombre(rs.getString(2));
                al.setEdad(rs.getInt(3));
                alumnos.add(al);
            }
            
        } catch (SQLException ex) {
            System.out.println("Error 1: "+ex.getMessage());
        }
        return alumnos;
    }
    
    public boolean agregarAlumno(Alumno alumno){
        boolean estado=false;
        PreparedStatement ps;
        String query="INSERT INTO alumnos VALUES(?,?,?)";
        
        try {
            ps=conexion.prepareStatement(query);
            ps.setString(1, alumno.getMatricula());
            ps.setString(2, alumno.getNombre());
            ps.setInt(3, alumno.getEdad());
            ps.execute();
            estado=true;
        } catch (SQLException ex) {
            System.out.println("Error 1: "+ex.getMessage());
        }
        return estado;
    }
    
    public boolean eliminarAlumno(String matricula){
        boolean estado=false;
        Statement st;
        String query= "DELETE FROM alumnos WHERE matricula='"+matricula+"'";
        
        try {
            st= conexion.createStatement();
            st.executeUpdate(query);
            estado=true;
        } catch (SQLException ex) {
            System.out.println("Error 1: "+ex.getMessage());
        }
        return estado;
    }
    
    public boolean actualizarAlumno(String nombre, String matricula){
        boolean estado=false;
        PreparedStatement ps;
        String query= "UPDATE alumnos SET nombre=? WHERE matricula=?";
        
        try {
            ps=conexion.prepareStatement(query);
            ps.setString(1, nombre);
            ps.setString(2, matricula);
            ps.execute();
            estado=true;
        } catch (SQLException ex) {
           System.out.println("Error 1: "+ex.getMessage());
        }
        return estado;
    }
**/
}
