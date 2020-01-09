package br.ufscar.dc.sistemahotel.dao;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import br.ufscar.dc.sistemahotel.beans.Hotel;
import br.ufscar.dc.sistemahotel.beans.SiteReserva;
import br.ufscar.dc.sistemahotel.beans.Promocao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author zamith
 */
public class PromocaoDAO {
  private final static String CRIAR_PROMOCAO_SQL = "insert into Promocao"
            + " (url, cnpj, preco, dataInicial, dataFinal)"
            + " values (?,?,?,?,?)";


   private final static String LISTAR_TODOS_PROMOCOES = "select"                    //DUVIDA
        + " url, cnpj, preco, dataInicial, dataFinal"
        + " from promocao"
        + " from promocao p inner join SiteReserva s on p.sitereserva = s.url"
        + " from promocao p inner join Hotel h on p.hotel = h.cnpj";
    
   private final static String LISTAR_PROMOCOES_POR_SELECAO = "select"
        + " url, cnpj, preco, dataInicial, dataFinal"
        + " from promocao"
        + " where cnpj = ?";
   
   private final static String BUSCA_PROMOCAO_POR_URL = "select"
        + " cnpj, preco, dataInicial, dataFinal"
        + " from promocao"
        + " where url = ?";
   
   private final static String BUSCA_PROMOCAO_POR_CNPJ = "select"
        + " url, preco, dataInicial, dataFinal"
        + " from promocao"
        + " where cnpj = ?";
    
    DataSource dataSource;


    public PromocaoDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }
    
    public Promocao gravarPromocao(Promocao p) throws SQLException, NamingException {
        try (Connection con = dataSource.getConnection();
                PreparedStatement ps = con.prepareStatement(CRIAR_PROMOCAO_SQL, Statement.RETURN_GENERATED_KEYS);) {
            ps.setString(1, p.getSiteReserva().getUrl());
            ps.setString(2, p.getHotel().getCnpj());
            ps.setDouble(3, p.getPreco());
            ps.setDate(4, new java.sql.Date(p.getDataInicial().getTime()));
            ps.setDate(5, new java.sql.Date(p.getDataFinal().getTime()));
            ps.execute();


            /*try (ResultSet rs = ps.getGeneratedKeys()) {
                rs.next();
                h.setId(rs.getInt(1));
            }*/
        }
        return p;
    }
    
    /*public List<Promocao> listarTodosPromocoes() throws SQLException {
        List<Promocao> ret = new ArrayList<>();
        try (Connection con = dataSource.getConnection();
                PreparedStatement ps = con.prepareStatement(LISTAR_TODOS_PROMOCOES)) {

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Promocao p = new Promocao();
                    p.setSiteReserva(rs.getString("url"));
                    p.setHotel(rs.getString("hotel"));
                    p.setDataInicial(rs.getDate("dataInicial"));
                    p.setDataFinal(rs.getDate("dataFinal"));
                    ret.add(p);                
                }
            }
        }
        return ret;
    }*/
    
    /*public List<Promocao> listarTodosPromocoes(String selecao) throws SQLException {
        List<Promocao> ret = new ArrayList<>();
        try (Connection con = dataSource.getConnection();
                PreparedStatement ps = con.prepareStatement(LISTAR_TODOS_PROMOCOES)) {

            ps.setString(1, selecao);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Promocao p = new Promocao();
                    p.setSiteReserva(rs.getString("url"));
                    p.setHotel(rs.getString("hotel"));
                    p.setDataInicial(rs.getDate("dataInicial"));
                    p.setDataFinal(rs.getDate("dataFinal"));
                    ret.add(p);                
                }
            }
        }
        return ret;
    }*/
}
