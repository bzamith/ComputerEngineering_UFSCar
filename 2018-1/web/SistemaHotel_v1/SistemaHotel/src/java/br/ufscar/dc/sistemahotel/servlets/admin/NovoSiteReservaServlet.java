/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.sistemahotel.servlets.admin;

import br.ufscar.dc.sistemahotel.beans.SiteReserva;
import br.ufscar.dc.sistemahotel.dao.SiteReservaDAO;
import br.ufscar.dc.sistemahotel.forms.NovoSiteReservaFormBean;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import org.apache.commons.beanutils.BeanUtils;

/**
 *
 * @author zamith
 */
@WebServlet(name = "NovoSiteReservaServlet", urlPatterns = {"/NovoSiteReservaServlet"})
public class NovoSiteReservaServlet extends HttpServlet {
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
        request.setCharacterEncoding("UTF-8");
        NovoSiteReservaFormBean nsfb = new NovoSiteReservaFormBean();
        try {
            // Obs: BeanUtils é uma classe da biblioteca
            // Apache Commons BeanUtils
            // http://commons.apache.org/beanutils/
            BeanUtils.populate(nsfb, request.getParameterMap());
            request.getSession().setAttribute("novoSiteReserva", nsfb);
            List<String> mensagens = nsfb.validar();
            SiteReservaDAO sdao = new SiteReservaDAO(dataSource);
            SiteReserva s = sdao.buscaSiteReservaPorUrl(nsfb.getUrl());
            if(s!=null){
                mensagens.add("Endereço URL já cadastrado!");
            }
            if (mensagens == null) {
                request.getRequestDispatcher("confirmarSiteReserva.jsp").forward(request, response);
            } else {
                request.setAttribute("mensagens", mensagens);
                request.getRequestDispatcher("siteReservaForm.jsp").forward(request, response);
            }
        } catch (Exception e) {
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
