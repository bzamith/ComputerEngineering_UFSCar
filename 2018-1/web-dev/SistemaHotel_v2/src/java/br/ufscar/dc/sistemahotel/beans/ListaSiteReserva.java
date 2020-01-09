/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.sistemahotel.beans;

import java.io.Serializable;
import java.util.List;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Named;

/**
 *
 * @author root
 */
@Named
@ApplicationScoped
public class ListaSiteReserva implements Serializable{
    List<SiteReserva> listaSiteReserva;

    public List<SiteReserva> getListaSiteReserva() {
        return listaSiteReserva;
    }

    public void setListaSiteReserva(List<SiteReserva> listaSiteReserva) {
        this.listaSiteReserva = listaSiteReserva;
    }
    
}
