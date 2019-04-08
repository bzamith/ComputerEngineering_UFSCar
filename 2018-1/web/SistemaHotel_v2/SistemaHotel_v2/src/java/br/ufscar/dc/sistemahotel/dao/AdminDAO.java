/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.sistemahotel.dao;

import br.ufscar.dc.sistemahotel.beans.Admin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.annotation.Resource;
import javax.enterprise.context.RequestScoped;
import javax.sql.DataSource;

@RequestScoped
public class AdminDAO {

   private final static String BUSCA_ADMIN_POR_USERNAME = "select"
        + " senha"
        + " from admin"
        + " where username = ?";
    
   @Resource(name = "jdbc/HotelDBLocal")
    DataSource dataSource;
    
    public Admin buscaAdminPorUsername(String username) throws SQLException {
        Admin ret = null;
        try (Connection con = dataSource.getConnection();
                PreparedStatement ps = con.prepareStatement(BUSCA_ADMIN_POR_USERNAME)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ret = new Admin();
                    ret.setUsername(username);
                    ret.setSenha(rs.getString("senha"));
                }
            }
        }
        return ret;
    }
    
}
