/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.sistemahotel.views;

import br.ufscar.dc.sistemahotel.beans.SiteReserva;
import br.ufscar.dc.sistemahotel.dao.SiteReservaDAO;
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
public class CadastrarSiteReserva implements Serializable {  
    @Resource(name = "jdbc/SiteReservaDBLocal")
    DataSource dataSource;
    
    SiteReserva dadosSiteReserva;
    String confSenha;

    @Inject SiteReservaDAO siteReservaDao;   
    

    public CadastrarSiteReserva() {
        dadosSiteReserva = new SiteReserva();
        confSenha = new String("");
    }
    
    public String validarTudo() throws SQLException, NamingException, IOException{
        String resposta = validarSenha();
        if(resposta.equals("Ok")){
            siteReservaDao.gravarSiteReserva(dadosSiteReserva);
            FacesContext facesContext = FacesContext.getCurrentInstance();
            Flash flash = facesContext.getExternalContext().getFlash();
            flash.setKeepMessages(true);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Site de Reservas "+dadosSiteReserva.getUrl()+" cadastrado com sucesso!"));
        }
        return recomecar();
    }
    
    public SiteReserva getDadosSiteReserva() {
        return dadosSiteReserva;
    }

    public void setDadosSiteReserva(SiteReserva dadosSiteReserva) {
        this.dadosSiteReserva = dadosSiteReserva;
    }
    
    public String getConfSenha(){
        return confSenha;
    }
    
    public void setConfSenha(String confSenha){
        this.confSenha = confSenha;
    }
    
    public void validarUrl(FacesContext context,
            UIComponent toValidate,
            String value) throws SQLException{ 
            if (!(value.endsWith(".com")||value.endsWith(".org")||value.endsWith(".br")||value.endsWith(".net"))) {
            ((UIInput) toValidate).setValid(false);
                FacesMessage message = new FacesMessage("Formato de endereço URL inválido!");
                context.addMessage(toValidate.getClientId(context), message);
            }
            else{
                SiteReserva s = siteReservaDao.buscaSiteReservaPorUrl(value);
                if(s!=null){
                    ((UIInput) toValidate).setValid(false);
                    FacesMessage message = new FacesMessage("Url já cadastrada!");
                    context.addMessage(toValidate.getClientId(context), message);
                }
            }
    }
    
    public void validarTelefone(FacesContext context,
            UIComponent toValidate,
            String value) throws SQLException{ 
            if (!value.matches("[0-9]*")) {
            ((UIInput) toValidate).setValid(false);
                FacesMessage message = new FacesMessage("Telefone deve conter apenas números!");
                context.addMessage(toValidate.getClientId(context), message);
            }
    }
    
    
    public String recomecar() {
        return "menuAdmin?faces-redirect=true";
    }
    
    public String validarSenha() throws SQLException, NamingException, IOException {
        if(!dadosSiteReserva.getSenha().equals(confSenha)){
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
