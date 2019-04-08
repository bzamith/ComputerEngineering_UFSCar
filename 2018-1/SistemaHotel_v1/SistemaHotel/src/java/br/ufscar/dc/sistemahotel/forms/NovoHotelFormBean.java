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
public class NovoHotelFormBean {
    private String cnpj, senha, confirmarSenha, nome, cidade;

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

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }
    
    
    public List<String> validar() {
        List<String> mensagens = new ArrayList<String>();
        if (nome.trim().length() == 0) {
            mensagens.add("Nome não pode ser vazio!");
        }
        if (!senha.equals(confirmarSenha)) {
            mensagens.add("As duas senhas não são iguais. Tente novamente.");
        }        
        if(!cnpj.matches("[0-9]*")){
            mensagens.add("Formato de CPNJ inválido, favor inserir somente numeros. Tente novamente.");
        }
        if(cnpj.length()>14||cnpj.length()<14){
            mensagens.add("Formato de CPNJ inválido, ele deve conter 14 digitos. Tente novamente.");
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
