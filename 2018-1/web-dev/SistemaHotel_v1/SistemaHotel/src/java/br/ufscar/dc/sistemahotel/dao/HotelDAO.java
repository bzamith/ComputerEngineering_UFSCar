/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.sistemahotel.dao;

import br.ufscar.dc.sistemahotel.beans.Hotel;
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
public class HotelDAO {

    private final static String CRIAR_HOTEL_SQL = "insert into Hotel"
            + " (cnpj, senha, nome, cidade)"
            + " values (?,?,?,?)";


   private final static String LISTAR_TODOS_HOTEIS = "select"
        + " cnpj, senha, nome, cidade"
        + " from hotel";
    
   private final static String LISTAR_HOTEIS_POR_SELECAO = "select"
        + " cnpj, senha, nome, cidade"
        + " from hotel"
        + " where cidade = ?";
   
   private final static String BUSCA_HOTEL_POR_CNPJ = "select"
        + " senha, nome, cidade"
        + " from hotel"
        + " where cnpj = ?";
    
    DataSource dataSource;


    public HotelDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }
    
    public Hotel gravarHotel(Hotel h) throws SQLException, NamingException {
        try (Connection con = dataSource.getConnection();
                PreparedStatement ps = con.prepareStatement(CRIAR_HOTEL_SQL, Statement.RETURN_GENERATED_KEYS);) {
            ps.setString(1, h.getCnpj());
            ps.setString(2, h.getSenha());
            ps.setString(3, h.getNome());
            ps.setString(4, h.getCidade());
            ps.execute();


            /*try (ResultSet rs = ps.getGeneratedKeys()) {
                rs.next();
                h.setId(rs.getInt(1));
            }*/
        }
        return h;
    }
    
    public List<Hotel> listarTodosHoteis() throws SQLException {
        List<Hotel> ret = new ArrayList<>();
        try (Connection con = dataSource.getConnection();
                PreparedStatement ps = con.prepareStatement(LISTAR_TODOS_HOTEIS)) {

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Hotel h = new Hotel();
                    h.setCnpj(rs.getString("cnpj"));
                    h.setNome(rs.getString("nome"));
                    h.setSenha(rs.getString("senha"));
                    h.setCidade(rs.getString("cidade"));
                    ret.add(h);                }
            }
        }
        return ret;
    }
    
    public List<Hotel> listarHoteisPorSelecao(String selecao) throws SQLException {
        List<Hotel> ret = new ArrayList<>();
        try (Connection con = dataSource.getConnection();
                PreparedStatement ps = con.prepareStatement(LISTAR_HOTEIS_POR_SELECAO)) {

            ps.setString(1, selecao);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Hotel h = new Hotel();
                    h.setCnpj(rs.getString("cnpj"));
                    h.setNome(rs.getString("nome"));
                    h.setSenha(rs.getString("senha"));
                    h.setCidade(rs.getString("cidade"));
                    ret.add(h);                 }
            }
        }
        return ret;
    }
    
    public Hotel buscaHotelPorCnpj(String cnpj) throws SQLException {
        Hotel ret = null;
        try (Connection con = dataSource.getConnection();
                PreparedStatement ps = con.prepareStatement(BUSCA_HOTEL_POR_CNPJ)) {
            
            ps.setString(1, cnpj);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ret = new Hotel();
                    ret.setCnpj(cnpj);
                    ret.setSenha(rs.getString("senha"));
                    ret.setNome(rs.getString("nome"));
                    ret.setCidade(rs.getString("cidade"));

                }
            }
        }
        return ret;
    }
    
}
