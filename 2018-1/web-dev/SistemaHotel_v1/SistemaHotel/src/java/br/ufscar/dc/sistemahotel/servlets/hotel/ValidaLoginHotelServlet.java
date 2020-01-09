/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.sistemahotel.servlets.hotel;

import br.ufscar.dc.sistemahotel.beans.Hotel;
import br.ufscar.dc.sistemahotel.beans.SiteReserva;
import br.ufscar.dc.sistemahotel.dao.HotelDAO;
import br.ufscar.dc.sistemahotel.dao.SiteReservaDAO;
import br.ufscar.dc.sistemahotel.forms.LoginHotelFormBean;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.naming.NamingException;
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
@WebServlet(name = "ValidaLoginHotelServlet", urlPatterns = {"/ValidaLoginHotelServlet"})
public class ValidaLoginHotelServlet extends HttpServlet {
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
        LoginHotelFormBean lhfb = new LoginHotelFormBean();
        String comando = (String) request.getSession().getAttribute("comando");
        try {
            // Obs: BeanUtils é uma classe da biblioteca
            // Apache Commons BeanUtils
            // http://commons.apache.org/beanutils/
            BeanUtils.populate(lhfb, request.getParameterMap());
            request.getSession().setAttribute("cnpj", lhfb.getCnpj());
            List<String> mensagens = lhfb.validar();    
            if (mensagens == null) {
                HotelDAO hdao = new HotelDAO(dataSource);
                Hotel h = hdao.buscaHotelPorCnpj(lhfb.getCnpj());
                if(h == null){
                    mensagens.add("CNPJ não encontrado!");
                    request.setAttribute("mensagens", mensagens);
                    request.getRequestDispatcher("loginHotel.jsp").forward(request, response);
                }
                else if(!h.getSenha().equals(lhfb.getSenha())){
                    mensagens.add("Senha incorreta!");
                    request.setAttribute("mensagens", mensagens);
                    request.getRequestDispatcher("loginHotel.jsp").forward(request, response);
                }
                else{
                    SiteReservaDAO sdao = new SiteReservaDAO(dataSource);
                    System.out.println("CHEGUEI ATÉ AQUI");
                    List<SiteReserva> todosSites = sdao.listarTodosSiteReserva();
                    List<String> urls = new ArrayList<>();
                    for(int i=0; i<todosSites.size(); i++){
                        urls.add(todosSites.get(i).getUrl());
                    }
                    request.setAttribute("sites", urls);                    
                    request.setAttribute("hotel", h);
                    comando = comando+".jsp";
                    request.getSession().removeAttribute("comando");
                    request.getSession().removeAttribute("cnpj");
                    request.getRequestDispatcher(comando).forward(request, response);
                }
            } else {
                request.setAttribute("mensagens", mensagens);
                request.getRequestDispatcher("loginHotel.jsp").forward(request, response);
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
