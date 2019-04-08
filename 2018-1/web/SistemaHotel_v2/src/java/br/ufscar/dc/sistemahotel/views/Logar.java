/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.sistemahotel.views;

import br.ufscar.dc.sistemahotel.beans.Admin;
import br.ufscar.dc.sistemahotel.beans.Hotel;
import br.ufscar.dc.sistemahotel.beans.ListaSiteReserva;
import br.ufscar.dc.sistemahotel.beans.Login;
import br.ufscar.dc.sistemahotel.beans.SiteReserva;
import br.ufscar.dc.sistemahotel.beans.UsuarioLogado;
import br.ufscar.dc.sistemahotel.dao.AdminDAO;
import br.ufscar.dc.sistemahotel.dao.HotelDAO;
import br.ufscar.dc.sistemahotel.dao.SiteReservaDAO;
import java.io.IOException;
import java.io.Serializable;
import java.sql.SQLException;
import javax.annotation.Resource;
import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.SessionScoped;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.context.Flash;
import javax.inject.Inject;
import javax.inject.Named;
import javax.naming.NamingException;
import javax.sql.DataSource;


@Named
@SessionScoped
public class Logar implements Serializable {
    
    
    @Resource(name = "jdbc/HotelDBLocal")
    DataSource dataSource;
    
    Login dadosLogin;
    //UIInput campeaoInput;

    @Inject HotelDAO hotelDao;
    @Inject AdminDAO adminDao;
    @Inject SiteReservaDAO siteReservaDao;
    @Inject UsuarioLogado user;
    @Inject ListaSiteReserva lsr;

    public Logar() {
        dadosLogin = new Login();
    }
    
    public String validarTudo() throws SQLException, NamingException, IOException{
        String resultado = validarUsername();
        System.out.println("DEPOIS DE LOGAR = "+resultado);
        if(!resultado.equals(recomecar())){
            user.setTipo(dadosLogin.getTipo());
            System.out.println("DEPOIS DE LOGAR = "+dadosLogin.getTipo());
            System.out.println("DEPOIS DE LOGAR = "+user.getTipo());
            user.setUsername(dadosLogin.getUsername());
            System.out.println("DEPOIS DE LOGAR = "+dadosLogin.getUsername());
            System.out.println("DEPOIS DE LOGAR = "+user.getUsername());
            user.setInfoUsername(infoUsername());
        }
        return resultado;
    }
    
    
    public Login getDadosLogin() {
        return dadosLogin;
    }

    public void setDadosLogin(Login dadosLogin) {
        this.dadosLogin = dadosLogin;
    }
    
    public String validarUsername() throws SQLException, NamingException, IOException {
        if(dadosLogin.getTipo().equals("Hotel") && !dadosLogin.getUsername().matches("[0-9]*")) {
            FacesContext facesContext = FacesContext.getCurrentInstance();
            Flash flash = facesContext.getExternalContext().getFlash();
            flash.setKeepMessages(true);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Formato de CPNJ inválido, favor inserir somente numeros. Tente novamente."));
            return recomecar();
        }
        
        if(dadosLogin.getTipo().equals("Hotel") && !(dadosLogin.getUsername().length() == 14)) {
            FacesContext facesContext = FacesContext.getCurrentInstance();
            Flash flash = facesContext.getExternalContext().getFlash();
            flash.setKeepMessages(true);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Formato de CPNJ inválido, ele deve conter 14 digitos. Tente novamente."));
            
            return recomecar();
        }
               
        if(dadosLogin.getTipo().equals("SiteReservas") && !(dadosLogin.getUsername().endsWith(".br")||dadosLogin.getUsername().endsWith(".com")||dadosLogin.getUsername().endsWith(".net")||dadosLogin.getUsername().endsWith(".org"))) {          
            FacesContext facesContext = FacesContext.getCurrentInstance();
            Flash flash = facesContext.getExternalContext().getFlash();
            flash.setKeepMessages(true);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Formato de endereço URL inválido. Tente novamente."));
            
            return recomecar();
        }
        
        return validarSenha();
        
    }
    
    public String recomecar() {
        FacesContext.getCurrentInstance().getExternalContext().invalidateSession();
        return "index?faces-redirect=true";
    }
    
    public String validarSenha() throws SQLException, NamingException, IOException {
        if(dadosLogin.getTipo().equals("Admin")){
            Admin a = adminDao.buscaAdminPorUsername(dadosLogin.getUsername());
                        
            if(a==null || !a.getSenha().equals(dadosLogin.getSenha())){
                FacesContext facesContext = FacesContext.getCurrentInstance();
                Flash flash = facesContext.getExternalContext().getFlash();
                flash.setKeepMessages(true);
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Username ou senha incorreto(a)."));
            
                return recomecar();
            }
            
            else{
                lsr.setListaSiteReserva(siteReservaDao.listarTodosSiteReserva());
                return("menuAdmin");
            }
        } 
        
        else if(dadosLogin.getTipo().equals("Hotel")){
            Hotel h = hotelDao.buscaHotelPorCnpj(dadosLogin.getUsername());
            if(h==null || !h.getSenha().equals(dadosLogin.getSenha())){
                FacesContext facesContext = FacesContext.getCurrentInstance();
                Flash flash = facesContext.getExternalContext().getFlash();
                flash.setKeepMessages(true);
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Username ou senha incorreto(a)."));
            
                return recomecar();
            }
            
            else{
                lsr.setListaSiteReserva(siteReservaDao.listarTodosSiteReserva());
                return("menuHotel");
            }
        }
        
        else if(dadosLogin.getTipo().equals("SiteReservas")){
            SiteReserva s = siteReservaDao.buscaSiteReservaPorUrl(dadosLogin.getUsername());
            if(s== null || !s.getSenha().equals(dadosLogin.getSenha())){
                FacesContext facesContext = FacesContext.getCurrentInstance();
                Flash flash = facesContext.getExternalContext().getFlash();
                flash.setKeepMessages(true);
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Username ou senha incorreto(a)."));
            
                return recomecar();
            }
            else{
                lsr.setListaSiteReserva(siteReservaDao.listarTodosSiteReserva());
                return("menuSiteReserva");
            }
        }
        
        return recomecar();
    }
    
    public String infoUsername() throws SQLException{
        if(dadosLogin.getTipo().equals("Hotel")){
            return hotelDao.buscaHotelPorCnpj(dadosLogin.getUsername()).getNome();
        }
        else if(dadosLogin.getTipo().equals("SiteReservas")){
            return siteReservaDao.buscaSiteReservaPorUrl(dadosLogin.getUsername()).getNome();
        }
        return "User Not Found";
    }
    
}
