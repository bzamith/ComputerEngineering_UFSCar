/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.sistemahotel.views;

import br.ufscar.dc.sistemahotel.beans.Hotel;
import br.ufscar.dc.sistemahotel.dao.HotelDAO;
import java.sql.SQLException;
import java.util.List;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.inject.Named;
import javax.naming.NamingException;

@Named
@ApplicationScoped
public class ListaHoteis  {
    List<Hotel> listaHoteis;
    
    @Inject HotelDAO hotelDAO;
    
    String selecaoCidade;
    
    public String getSelecaoCidade(){
        return selecaoCidade;
    }
    
    public void setSelecaoCidade(String selecaoCidade){
        this.selecaoCidade = selecaoCidade;
    }
    
    
    public ListaHoteis() {
    }

    public List<Hotel> getListaHoteis() {
        return listaHoteis;
    }
    
    public String verTodosHoteis() throws SQLException  {
        listaHoteis = hotelDAO.listarTodosHoteis();
        return "listaHoteis";
    }
    
    public String verTodosHoteisSelecao() throws SQLException, NamingException {
        listaHoteis = hotelDAO.listarHoteisPorSelecao(selecaoCidade);
        return "listaHoteis";
    }
}
