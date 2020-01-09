/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.sistemahotel.servlets.admin;

import br.ufscar.dc.sistemahotel.beans.Admin;
import br.ufscar.dc.sistemahotel.dao.AdminDAO;
import br.ufscar.dc.sistemahotel.forms.LoginAdminFormBean;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@WebServlet(name = "ValidaLoginAdminServlet", urlPatterns = {"/ValidaLoginAdminServlet"})
public class ValidaLoginAdminServlet extends HttpServlet {
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
        LoginAdminFormBean lafb = new LoginAdminFormBean();
        String comando = (String) request.getSession().getAttribute("comando");
        try {
            // Obs: BeanUtils é uma classe da biblioteca
            // Apache Commons BeanUtils
            // http://commons.apache.org/beanutils/
            BeanUtils.populate(lafb, request.getParameterMap());
            request.getSession().setAttribute("admin", lafb.getUsername());
            AdminDAO adao = new AdminDAO(dataSource);
            Admin a = adao.buscaAdminPorUsername(lafb.getUsername());
            List<String> novasMensagens = new ArrayList<String>();  
            if(a == null){
                novasMensagens.add("Username não encontrado!");
                request.setAttribute("mensagens", novasMensagens);
                request.getRequestDispatcher("loginAdmin.jsp").forward(request, response);
            }
            else if(!a.getSenha().equals(lafb.getSenha())){
                novasMensagens.add("Senha incorreta!");
                request.setAttribute("mensagens", novasMensagens);
                request.getRequestDispatcher("loginAdmin.jsp").forward(request, response);
            }
            else{
                request.setAttribute("admin", a);
                comando = comando+".jsp";
                System.out.println(comando);
                request.getSession().removeAttribute("comando");
                request.getSession().removeAttribute("admin");
                request.getRequestDispatcher(comando).forward(request, response);
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
