/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

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

    @Override
    public String toString() {
        return "Maquina:\t" + "id_maquina: " + id_maquina + "\nnombre: " + nombre + "\ttipo: " + tipo + "\tubicacion: " + ubicacion + "\testado: " + estado+"\n";
    }
    
    
    
    
}
