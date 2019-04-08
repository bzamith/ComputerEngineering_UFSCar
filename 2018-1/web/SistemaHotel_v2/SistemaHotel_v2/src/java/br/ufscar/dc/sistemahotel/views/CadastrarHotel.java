/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.sistemahotel.views;

import br.ufscar.dc.sistemahotel.beans.Hotel;
import br.ufscar.dc.sistemahotel.dao.HotelDAO;
import java.io.IOException;
import java.io.Serializable;
import java.sql.SQLException;
import javax.annotation.Resource;
import javax.enterprise.context.RequestScoped;
import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.component.UIInput;
import javax.faces.context.FacesContext;
import javax.faces.context.Flash;
import javax.inject.Inject;
import javax.inject.Named;
import javax.naming.NamingException;
import javax.sql.DataSource;


@Named
@RequestScoped
public class CadastrarHotel implements Serializable {
    
    
    @Resource(name = "jdbc/HotelDBLocal")
    DataSource dataSource;
    
    Hotel dadosHotel;
    String confSenha;

    @Inject HotelDAO hotelDao;   
    

    public CadastrarHotel() {
        dadosHotel = new Hotel();
        confSenha = new String("");
    }
    
    public String validarTudo() throws SQLException, NamingException, IOException{
        String resposta =  validarSenha();
        if(resposta.equals("Ok")){
          hotelDao.gravarHotel(dadosHotel);
          FacesContext facesContext = FacesContext.getCurrentInstance();
          Flash flash = facesContext.getExternalContext().getFlash();
          flash.setKeepMessages(true);
          FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Hotel "+dadosHotel.getNome()+" cadastrado com sucesso!"));  
        }
        return recomecar();
    }
    
    public Hotel getDadosHotel() {
        return dadosHotel;
    }

    public void setDadosHotel(Hotel dadosHotel) {
        this.dadosHotel = dadosHotel;
    }
    
    public String getConfSenha(){
        return confSenha;
    }
    
    public void setConfSenha(String confSenha){
        this.confSenha = confSenha;
    }
    
    public void validarCnpj(FacesContext context,
            UIComponent toValidate,
            String value) throws SQLException{ 
            if (!value.matches("[0-9]*")) {
            ((UIInput) toValidate).setValid(false);
                FacesMessage message = new FacesMessage("CNPJ deve conter apenas números!");
                context.addMessage(toValidate.getClientId(context), message);
            }
            else if(value.length()>14 || value.length()<14) {
            ((UIInput) toValidate).setValid(false);
                FacesMessage message = new FacesMessage("CNPJ deve conter 14 digitos numéricos!");
                context.addMessage(toValidate.getClientId(context), message);
            }        
            else{
                Hotel h = hotelDao.buscaHotelPorCnpj(value);
                if(h!=null){
                    ((UIInput) toValidate).setValid(false);
                    FacesMessage message = new FacesMessage("CNPJ já cadastrado!");
                    context.addMessage(toValidate.getClientId(context), message);
                }
            }
    }
    
    public String recomecar() {
        return "menuAdmin?faces-redirect=true";
    }
    
    public String validarSenha() throws SQLException, NamingException, IOException {
        if(!dadosHotel.getSenha().equals(confSenha)){
            FacesContext facesContext = FacesContext.getCurrentInstance();
            Flash flash = facesContext.getExternalContext().getFlash();
            flash.setKeepMessages(true);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Senhas digitadas diferentes!"));
            
            return recomecar();
        } 
        
        else{
            return "Ok";
        }
    }
    
}
