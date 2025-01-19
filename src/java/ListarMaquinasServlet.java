/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import datos.OperacionBD;
import modelo.Maquina;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author max-1
 */
@WebServlet(urlPatterns = {"/ListarMaquinas"})

public class ListarMaquinasServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OperacionBD controlador = new OperacionBD();
        controlador.conectar();
        ArrayList<Maquina> maquinas = controlador.consultarMaquinas();
        controlador.desconectar();

        // Pasa la lista al JSP
        request.setAttribute("listMaq", maquinas);
        request.getRequestDispatcher("Maquinas.jsp").forward(request, response);
    }
}

