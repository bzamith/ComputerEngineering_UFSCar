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
    <a href="index.jsp"><h1>Login Admin</h1></a>
<hr>
<c:if test="${!empty requestScope.mensagens}">
<ul class="erro">
<c:forEach items="${requestScope.mensagens}" var="mensagem">
<li>${mensagem}</li>
</c:forEach>
</ul>
<hr>
</c:if>

<form action="ValidaLoginAdminServlet" method="post">
<b>Digite os dados de Login: </b><br/><br/>
Username <input name="username" type="text" value="${sessionScope.admin}" placeholder="Digite o Nome de Usuario" required/><br/>  <% // POSSO USAR O REQUIRED AQUI? %> 
Senha: <input name="senha" type="password" placeholder="Digite a Senha" value="" required/><br/>
<input type="submit" value="Entrar"/>
</form>



</body>
</html>
