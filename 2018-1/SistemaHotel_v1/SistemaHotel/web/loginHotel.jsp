<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sistema de Hotel</title>

<link rel="stylesheet" type="text/css" href="estilo.css" />
</head>
<body>
    <a href="index.jsp"><h1>Login Hotel</h1></a>
<hr>
<c:if test="${!empty requestScope.mensagens}">
<ul class="erro">
<c:forEach items="${requestScope.mensagens}" var="mensagem">
<li>${mensagem}</li>
</c:forEach>
</ul>
<hr>
</c:if>

<c:if test="${comando == 'listaPromocoes'}">
    <form action="ValidaLoginHotelServlet" method="post">
    <b>Digite os dados de Login: </b><br/><br/>
    CNPJ: <input name="cnpj" type="text" value="${sessionScope.cnpj}" placeholder="Digite o CNPJ" required/><br/>  <% // POSSO USAR O REQUIRED AQUI? %> 
    Senha: <input name="senha" type="password" placeholder="Digite a senha" value="" required/><br/>
    <input type="submit" value="Entrar"/>
    </form>
</c:if>

<c:if test="${comando == 'promocaoForm'}">
    <form action="ValidaLoginHotelServlet" method="post">
    <b>Digite os dados de Login: </b><br/><br/>
    CNPJ: <input name="cnpj" type="text" value="${sessionScope.cnpj}" placeholder="Digite o CNPJ" required/><br/>  <% // POSSO USAR O REQUIRED AQUI? %> 
    Senha: <input name="senha" type="password" placeholder="Digite a senha" value="" required/><br/>
    <input type="submit" value="Entrar"/>
    </form>
</c:if>


</body>
</html>
