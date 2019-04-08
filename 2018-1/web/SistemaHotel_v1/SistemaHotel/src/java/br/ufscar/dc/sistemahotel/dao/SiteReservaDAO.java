/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.sistemahotel.dao;

/**
 *
 * @author zamith
 */
import br.ufscar.dc.sistemahotel.beans.SiteReserva;
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


public class SiteReservaDAO {

    private final static String CRIAR_SITERESERVA_SQL = "insert into SiteReserva"
            + " (url, senha, nome, telefone)"
            + " values (?,?,?,?)";


    private final static String LISTAR_TODOS_SITERESERVAS = "select"
            + " url, senha, nome, telefone"
            + " from siteReserva";
    

    private final static String BUSCA_SITE_RESERVA_POR_URL = "select"
        + " senha, nome, telefone"
        + " from siteReserva"
        + " where url = ?";
    

    DataSource dataSource;


    public SiteReservaDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }


    public SiteReserva gravarSiteReserva(SiteReserva s) throws SQLException, NamingException {
        try (Connection con = dataSource.getConnection();
                PreparedStatement ps = con.prepareStatement(CRIAR_SITERESERVA_SQL, Statement.RETURN_GENERATED_KEYS);) {
            ps.setString(1, s.getUrl());
            ps.setString(2, s.getSenha());
            ps.setString(3, s.getNome());
            ps.setString(4, s.getTelefone());
            ps.execute();


            /*try (ResultSet rs = ps.getGeneratedKeys()) {
                rs.next();
                p.setId(rs.getInt(1));
            }*/
        }
        return s;
    }


    public List<SiteReserva> listarTodosSiteReserva() throws SQLException, NamingException {
        List<SiteReserva> ret = new ArrayList<>();
        try (Connection con = dataSource.getConnection();
                PreparedStatement ps = con.prepareStatement(LISTAR_TODOS_SITERESERVAS)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SiteReserva s = new SiteReserva();
                    s.setUrl(rs.getString("url"));
                    s.setNome(rs.getString("nome"));
                    s.setSenha(rs.getString("senha"));
                    s.setTelefone(rs.getString("telefone"));
                    ret.add(s);
                }
            }
        }
        return ret;
    }

    
    public SiteReserva buscaSiteReservaPorUrl(String url) throws SQLException {
        SiteReserva ret = null;
        try (Connection con = dataSource.getConnection();
                PreparedStatement ps = con.prepareStatement(BUSCA_SITE_RESERVA_POR_URL)) {
            
            ps.setString(1, url);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ret = new SiteReserva();
                    ret.setUrl(url);
                    ret.setSenha(rs.getString("senha"));
                    ret.setNome(rs.getString("nome"));
                    ret.setTelefone(rs.getString("telefone"));
                }
            }
        }
        return ret;
    }
    
    
}
