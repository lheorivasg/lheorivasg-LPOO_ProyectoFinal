/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.time.LocalDate;

/**
 *
 * @author Equipo 5: Max Alvarez Alvarez, Hugo Rubio Romero y Leonardo Rivas Gutierrez
 */
public class Socio {
    private String idSocio;
    private String nombre;
    private LocalDate fechaNacimiento ;
    private String telefono;
    private String email;
    private LocalDate fechaInscripcion;
    private String membresia;
    private String estado;

    public Socio(String idSocio, String nombre, LocalDate fechaNacimiento, String telefono, String email, LocalDate fechaInscripcion, String membresia, String estado) {
        this.idSocio = idSocio;
        this.nombre = nombre;
        this.fechaNacimiento = fechaNacimiento;
        this.telefono = telefono;
        this.email = email;
        this.fechaInscripcion = fechaInscripcion;
        this.membresia = membresia;
        this.estado = estado;
    }

    public Socio() {
    }

    public Socio(String nombre, LocalDate fechaNacimiento, String telefono, String email, LocalDate fechaInscripcion, String membresia, String estado) {
        this.nombre = nombre;
        this.fechaNacimiento = fechaNacimiento;
        this.telefono = telefono;
        this.email = email;
        this.fechaInscripcion = fechaInscripcion;
        this.membresia = membresia;
        this.estado = estado;
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

    public String getMembresia() {
        return membresia;
    }

    public void setMembresia(String membresia) {
        this.membresia = membresia;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    
    
    
    
}
