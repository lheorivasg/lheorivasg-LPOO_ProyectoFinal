/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Equipo 5: Max Alvarez Alvarez, Hugo Rubio Romero y Leonardo Rivas
 * Gutierrez
 */
public class Socio {

    private String idSocio;
    private String nombre;
    private LocalDate fechaNacimiento;
    private String telefono;
    private String email;
    private LocalDate fechaInscripcion;
    private String tipoMembresia;
    private String estado;
    private String duracion;

    private List<String> asistencia;

    public Socio() {
    }

    public Socio(List<String> asistencia) {
        this.asistencia = asistencia;
    }

    public Socio(String idSocio, String nombre, LocalDate fechaNacimiento, String telefono, String email, LocalDate fechaInscripcion, String tipoMembresia, String estado, String duracion) {
        this.idSocio = idSocio;
        this.nombre = nombre;
        this.fechaNacimiento = fechaNacimiento;
        this.telefono = telefono;
        this.email = email;
        this.fechaInscripcion = fechaInscripcion;
        this.tipoMembresia = tipoMembresia;
        this.estado = estado;
        this.duracion = duracion;
        this.asistencia = new ArrayList<>();
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

    public String getTipoMembresia() {
        return tipoMembresia;
    }

    public void setTipoMembresia(String tipoMembresia) {
        this.tipoMembresia = tipoMembresia;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getDuracion() {
        return duracion;
    }

    public void setDuracion(String duracion) {
        this.duracion = duracion;
    }

    public List<String> getAsistencia() {
        return asistencia;
    }

    public void setAsistencia(List<String> asistencia) {
        this.asistencia = asistencia;
    }
    
    public int getNumeroDeAsistencias(){
        return asistencia.size();
    }

    @Override
    public String toString() {
        return "Socio" + "idSocio" + idSocio + "nombre" + nombre + "fechaNacimiento=" + fechaNacimiento + "telefono=" + telefono + "email=" + email + "fechaInscripcion=" + fechaInscripcion + "tipoMembresia=" + tipoMembresia + "estado=" + estado + "duracion=" + duracion;
    }

    public void registrarAsistencia(String actividad) {
        String registro = "Actividad" + actividad + "-Fecha: " + LocalDate.now().toString();
        this.asistencia.add(registro);
    }

}
