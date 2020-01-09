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
    <a href="index.jsp"><h1>Cadastrar Hotel</h1></a>
<hr>
<c:if test="${!empty requestScope.mensagens}">
<ul class="erro">
<c:forEach items="${requestScope.mensagens}" var="mensagem">
<li>${mensagem}</li>
</c:forEach>
</ul>
<hr>
</c:if>



<form action="NovoHotelServlet" method="post">
    <b>Digite os dados do Hotel:</b><br/><br/>
    CNPJ: <input name="cnpj" type="text" value="${sessionScope.novoHotel.cnpj}" placeholder="Digite seu CNPJ" required/><br/>  <% // POSSO USAR O REQUIRED AQUI? %> 
    Senha: <input name="senha" type="password" placeholder="Cadastre uma senha" value="" required/><br/>
    Confirmar Senha: <input name="confirmarSenha" type="password" value="" placeholder="Digite a senha novamente" required/><br/>
    Nome: <input name="nome" type="text" value="${sessionScope.novoHotel.nome}" placeholder="Digite o Nome do Hotel" required/><br/>
    Cidade: <input name="cidade" type="text" value="${sessionScope.novoHotel.cidade}" placeholder="Digite sua Cidade" required/><br/>
<input type="submit" value="Cadastrar"/>
</form>
</body>
</html>
