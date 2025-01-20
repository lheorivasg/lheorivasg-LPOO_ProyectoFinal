/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

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

    public Entrenador(String idEntrenador, String nombre, String especialidad, String telefono, String horario, String estado) {
        this.idEntrenador = idEntrenador;
        this.nombre = nombre;
        this.especialidad = especialidad;
        this.telefono = telefono;
        this.horario = horario;
        this.estado = estado;
    }

    public Entrenador() {
    }

    
    
    
    
    
    
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
    
    
    
    
}
