/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.sistemahotel.views;

import br.ufscar.dc.sistemahotel.beans.Promocao;
import br.ufscar.dc.sistemahotel.beans.UsuarioLogado;
import br.ufscar.dc.sistemahotel.dao.PromocaoDAO;
import java.io.Serializable;
import java.sql.SQLException;
import java.util.List;
import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.SessionScoped;
import javax.inject.Inject;
import javax.inject.Named;
import javax.naming.NamingException;

@Named
@SessionScoped
public class ListaPromocoes implements Serializable{
    List<Promocao> listaPromocoes;
    
    @Inject PromocaoDAO promocaoDAO;
    @Inject UsuarioLogado user;
    
    public ListaPromocoes() {}

    public List<Promocao> getListaPromocoes() {
        return listaPromocoes;
    }
    
    public String verPromocoes() throws SQLException, NamingException {
        System.out.println("DEPOIS DE LISTAR = "+user.getTipo());
        if(user.getTipo().equals("Hotel")){
            listaPromocoes = promocaoDAO.listarPromocoesHotel(user.getUsername());
            System.out.println("DEPOIS DE LISTAR = "+listaPromocoes.size());
            return "listaPromocoesHotel";
        }
        else if(user.getTipo().equals("SiteReservas")){
            listaPromocoes = promocaoDAO.listarPromocoesSiteReserva(user.getUsername());
            System.out.println("DEPOIS DE LISTAR = "+listaPromocoes.size());
            return "listaPromocoesSiteReserva";
        }
        return "index";
    }
}
