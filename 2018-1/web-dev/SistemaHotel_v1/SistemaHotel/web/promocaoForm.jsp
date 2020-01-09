<%-- 
    Document   : promocaoForm
    Created on : Apr 15, 2018, 10:43:48 PM
    Author     : zamith
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sistema de Hotel</title>

<link rel="stylesheet" type="text/css" href="estilo.css" />
</head>
<body>
    <a href="index.jsp"><h1>Cadastrar Promoção</h1></a>
<hr>
        
        <form action="NovaPromocaoServlet" method="post">
        <b>Digite os dados de Cadastro: </b><br/><br/>
        
        Site de Reservas: <input name="url" list="sitesUrls" type="text">
        <datalist id="sitesUrls">
            <c:forEach var="sites" items="${sites}">
                <option value="${sites}">
            </c:forEach>
        </datalist> <br/>
        Data Inicial: <input name="dataInicial" type="text" value="" placeholder="Digite a Data Inicial" required/><br/>  <% // POSSO USAR O REQUIRED AQUI? %> 
        Data Final: <input name="dataFinal" type="text" value="" placeholder="Digite a Data Final" required/><br/>
        Preço: <input name="preco" type="text" value="" placeholder="Digite o Preço" required/><br/>
        
        <input type="submit" value="Cadastrar"/>
        
        </form>
    </body>
</html>
