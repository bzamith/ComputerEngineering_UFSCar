/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.sistemahotel.beans;

import java.sql.Date;

/**
 *
 * @author zamith
 */
public class Promocao {
    protected Hotel hotel; 
    protected SiteReserva siteReserva; //Recebe a url como string ou o site de reservas inteiro?
    protected double preco;
    protected Date dataInicial;
    protected Date dataFinal;

    public Hotel getHotel() {
        return hotel;
    }

    public void setHotel(Hotel hotel) {
        this.hotel = hotel;
    }

    public SiteReserva getSiteReserva() {
        return siteReserva;
    }

    public void setSiteReservas(SiteReserva siteReserva) {
        this.siteReserva = siteReserva;
    }

    public double getPreco() {
        return preco;
    }

    public void setPreco(double preco) {
        this.preco = preco;
    }

    public Date getDataInicial() {
        return dataInicial;
    }

    public void setDataInicial(Date dataInicial) {
        this.dataInicial = dataInicial;
    }

    public Date getDataFinal() {
        return dataFinal;
    }

    public void setDataFinal(Date dataFinal) {
        this.dataFinal = dataFinal;
    }
    
}
