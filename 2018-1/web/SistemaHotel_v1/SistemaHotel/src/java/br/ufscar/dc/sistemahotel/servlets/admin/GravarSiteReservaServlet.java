package br.ufscar.dc.sistemahotel.servlets.admin;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import br.ufscar.dc.sistemahotel.beans.SiteReserva;
import br.ufscar.dc.sistemahotel.dao.SiteReservaDAO;
import br.ufscar.dc.sistemahotel.forms.NovoSiteReservaFormBean;
import java.io.IOException;
import java.io.PrintWriter;
import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

/**
 *
 * @author zamith
 */
@WebServlet(urlPatterns = {"/GravarSiteReservaServlet"})
public class GravarSiteReservaServlet extends HttpServlet {
    
    @Resource(name="jdbc/SistemaHotelLocal")
    DataSource dataSource;
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        NovoSiteReservaFormBean nsfb = (NovoSiteReservaFormBean) request.getSession().getAttribute("novoSiteReserva");
        request.getSession().removeAttribute("novoSiteReserva");

        SiteReservaDAO sdao = new SiteReservaDAO(dataSource);
        try {
            SiteReserva s = new SiteReserva();
            s.setUrl(nsfb.getUrl());
            s.setSenha(nsfb.getSenha());
            s.setNome(nsfb.getNome());
            s.setTelefone(nsfb.getTelefone());
            s = sdao.gravarSiteReserva(s);
            request.setAttribute("mensagem", "Cadastro realizado com sucesso!");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensagem", e.getLocalizedMessage());
            request.getRequestDispatcher("erro.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
