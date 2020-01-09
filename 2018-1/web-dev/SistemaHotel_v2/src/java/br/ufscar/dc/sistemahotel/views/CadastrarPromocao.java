/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.sistemahotel.views;

import br.ufscar.dc.sistemahotel.beans.Promocao;
import br.ufscar.dc.sistemahotel.dao.HotelDAO;
import br.ufscar.dc.sistemahotel.dao.PromocaoDAO;
import br.ufscar.dc.sistemahotel.dao.SiteReservaDAO;
import java.io.IOException;
import java.io.Serializable;
import java.sql.SQLException;
import java.util.List;
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
import br.ufscar.dc.sistemahotel.beans.UsuarioLogado;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@Named
@RequestScoped
public class CadastrarPromocao implements Serializable {
    
    
    @Resource(name = "jdbc/HotelDBLocal")
    DataSource dataSource;
    
    Promocao dadosPromocao;
    String url;
    String dataInicial;
    String dataFinal;
    
    @Inject PromocaoDAO promocaoDao;   
    @Inject HotelDAO hotelDao;
    @Inject SiteReservaDAO siteReservaDao;
    @Inject UsuarioLogado user;
    

    public CadastrarPromocao() {
        dadosPromocao = new Promocao();
    }
    
    public String validarTudo() throws SQLException, NamingException, IOException{
        dadosPromocao.setHotel(hotelDao.buscaHotelPorCnpj(user.getUsername()));
        dadosPromocao.setSiteReserva(siteReservaDao.buscaSiteReservaPorUrl(url));
        String setaData = setarDatas();
        String resposta =  validarDados();
        if(setaData.equals("Ok") && resposta.equals("Ok")){
            promocaoDao.gravarPromocao(dadosPromocao);
            FacesContext facesContext = FacesContext.getCurrentInstance();
            Flash flash = facesContext.getExternalContext().getFlash();
            flash.setKeepMessages(true);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Promoção cadastrada com sucesso!"));
        }
        return recomecar();
    }
    
    public Promocao getDadosPromocao() {
        return dadosPromocao;
    }

    public void setDadosPromocao(Promocao dadosPromocao) {
        this.dadosPromocao = dadosPromocao;
    }
    
    public String getUrl(){
        return url;
    }
    
    public void setUrl(String url){
        this.url = url;
    }
    
    public String getDataInicial() {
        return dataInicial;
    }

    public void setDataInicial(String dataInicial) {
        this.dataInicial = dataInicial;
    }

    public String getDataFinal() {
        return dataFinal;
    }

    public void setDataFinal(String dataFinal) {
        this.dataFinal = dataFinal;
    }
    
    public String recomecar() {
        
        if(user.getTipo().equals("Hotel"))
            return "menuHotel?faces-redirect=true";
        else{
            return "index?faces-redirect=true";
        }
    }
    
    public String validarDados() throws SQLException{
        List<Promocao> promocoesHotel = promocaoDao.listarPromocoesHotel(dadosPromocao.getHotel().getCnpj());
        boolean conflito = false;
        for(int i=0; i<promocoesHotel.size(); i++){
           Promocao atual = promocoesHotel.get(i);
           if(atual.getDataInicial().equals(dadosPromocao.getDataInicial()) && atual.getDataFinal().equals(dadosPromocao.getDataFinal()) && atual.getSiteReserva().getNome().equals(dadosPromocao.getSiteReserva().getNome())){
               FacesContext facesContext = FacesContext.getCurrentInstance();
                Flash flash = facesContext.getExternalContext().getFlash();
                flash.setKeepMessages(true);
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Promoção já cadastrada nessa data! Tente novamente."));
                conflito = true;
                break;
           }
        }
        if(conflito){
            return recomecar();
        }
        else{
            return "Ok";
        }
    }
    
    public String setarDatas(){
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            dadosPromocao.setDataInicial(sdf.parse(dataInicial));
        } catch (ParseException pe) {
                FacesContext facesContext = FacesContext.getCurrentInstance();
                Flash flash = facesContext.getExternalContext().getFlash();
                flash.setKeepMessages(true);
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Data Inicial deve estar no formato dd/mm/aaaa!"));
                return recomecar();
        }
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            dadosPromocao.setDataFinal(sdf.parse(dataFinal));
        } catch (ParseException pe) {
                FacesContext facesContext = FacesContext.getCurrentInstance();
                Flash flash = facesContext.getExternalContext().getFlash();
                flash.setKeepMessages(true);
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("Data Inicial deve estar no formato dd/mm/aaaa!"));
                return recomecar();
        }
        return "Ok";
    }
    
    
    public void validarDataInicial(FacesContext context,
            UIComponent toValidate,
            String value){
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            sdf.parse(value);
        } catch (ParseException pe) {
            ((UIInput) toValidate).setValid(false);
                FacesMessage message = new FacesMessage("Data Inicial deve estar no formato dd/mm/aaaa!");
                context.addMessage(toValidate.getClientId(context), message);
        }
    }
    
    public void validarDataFinal(FacesContext context,
            UIComponent toValidate,
            String value){
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            sdf.parse(value);
        } catch (ParseException pe) {
            ((UIInput) toValidate).setValid(false);
                FacesMessage message = new FacesMessage("Data Final deve estar no formato dd/mm/aaaa!");
                context.addMessage(toValidate.getClientId(context), message);
        }
    }
    
    public void validarPreco(FacesContext context,
            UIComponent toValidate,
            String value){
            System.out.println("VALOR = "+value);
        
    }
    
}
