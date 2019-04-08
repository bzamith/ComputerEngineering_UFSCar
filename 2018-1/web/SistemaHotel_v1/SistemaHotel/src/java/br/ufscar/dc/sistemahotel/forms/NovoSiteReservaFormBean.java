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
public class NovoSiteReservaFormBean {
    private String url, senha, confirmarSenha, nome, telefone;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getConfirmarSenha() {
        return confirmarSenha;
    }

    public void setConfirmarSenha(String confirmarSenha) {
        this.confirmarSenha = confirmarSenha;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }
    
    
    public List<String> validar() {
        List<String> mensagens = new ArrayList<String>();
        if (nome.trim().length() == 0) {
            mensagens.add("Nome não pode ser vazio!");
        }
        if (!senha.equals(confirmarSenha)) {
            mensagens.add("As duas senhas não são iguais. Tente novamente.");
        }
        if(!telefone.matches("[0-9]*")){
            mensagens.add("Formato de Telefone inválido, favor inserir somente numeros. Tente novamente.");
        }
        if(!(url.endsWith(".br")||url.endsWith(".com")||url.endsWith(".net")||url.endsWith(".org"))){
            mensagens.add("Formato de endereço URL inválido. Tente novamente.");
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
