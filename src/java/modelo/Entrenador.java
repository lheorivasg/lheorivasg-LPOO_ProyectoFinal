/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

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
    public void registrarEntrada(LocalDateTime entrada) {
        this.horaEntrada = entrada;
        System.out.println("Entrada registrada: " + horaEntrada);
    }

    // Registrar salida
    public void registrarSalida(LocalDateTime salida) {
        this.horaSalida = salida;
        System.out.println("Salida registrada: " + horaSalida);
    }

    // Calcular horas trabajadas
    public String calcularHorasTrabajadas() {
        if (horaEntrada != null && horaSalida != null) {
            Duration duracion = Duration.between(horaEntrada, horaSalida);
            long horas = duracion.toHours();
            long minutos = duracion.toMinutes() % 60;
            return horas + " horas y " + minutos + " minutos.";
        } else {
            return "No se han registrado horas de entrada y salida.";
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

