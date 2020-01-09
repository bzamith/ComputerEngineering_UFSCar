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
    <a href="index.jsp"><h1>Cadastrar Site de Reservas</h1></a>
<hr>
<c:if test="${!empty requestScope.mensagens}">
<ul class="erro">
<c:forEach items="${requestScope.mensagens}" var="mensagem">
<li>${mensagem}</li>
</c:forEach>
</ul>
<hr>
</c:if>



<form action="NovoSiteReservaServlet" method="post">
    <b>Digite os dados do Site de Reservas:</b><br/><br/>
    URL: <input name="url" type="text" value="${sessionScope.novoSiteReserva.url}" placeholder="Digite o endereço URL" required/><br/>  <% // POSSO USAR O REQUIRED AQUI? %> 
    Senha: <input name="senha" type="password" placeholder="Cadastre uma senha" value="" required/><br/>
    Confirmar Senha: <input name="confirmarSenha" type="password" value="" placeholder="Digite a senha novamente" required/><br/>
    Nome: <input name="nome" type="text" value="${sessionScope.novoSiteReserva.nome}" placeholder="Digite o Nome do Site" required/><br/>
    Telefone: <input name="telefone" type="text" value="${sessionScope.novoSiteReserva.telefone}" placeholder="Digite seu Telefone" required/><br/>
<input type="submit" value="Cadastrar"/>
</form>
</body>
</html>
