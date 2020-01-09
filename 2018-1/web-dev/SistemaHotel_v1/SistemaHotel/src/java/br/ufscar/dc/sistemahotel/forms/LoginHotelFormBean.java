/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufscar.dc.sistemahotel.forms;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author zamith
 */
public class LoginHotelFormBean {
    private String cnpj, senha;

    public String getCnpj() {
        return cnpj;
    }

    public void setCnpj(String cnpj) {
        this.cnpj = cnpj;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }
    
    public List<String> validar() {
        List<String> mensagens = new ArrayList<String>();     
        if(!cnpj.matches("[0-9]*")){
            mensagens.add("Formato de CPNJ inválido, favor inserir somente numeros. Tente novamente.");
        }
        
        /*try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            sdf.parse(dataDeNascimento);
        } catch (ParseException pe) {
            mensagens.add("Data de nascimento deve estar no formato dd/mm/aaaa!");
        }
        if (campeao.equalsIgnoreCase(vice)) {
            mensagens.add("Campeão e vice devem ser diferentes!");
        }*/
        return (mensagens.isEmpty() ? null : mensagens);
}

    
}
