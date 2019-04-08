<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sistema Hotel</title>
<link rel="stylesheet" type="text/css" href="estilo.css" />
</head>
<body>
    <a href="index.jsp"><h1>Cadastrar Site de Reservas</h1></a>

Atenção! Deseja realmente cadastrar seu site de reservas?
<br/>
Uma vez enviado, você está automaticamente aceitando
pagar R$ 50,00 de inscrição.
<br/><br/>
URL: ${sessionScope.novoSiteReserva.url}<br/>
Nome: ${sessionScope.novoSiteReserva.nome}<br/>
Telefone: ${sessionScope.novoSiteReserva.telefone}<br/>
<br/>
<a href="GravarSiteReservaServlet">Confirmar</a> | 
<a href="siteReservaForm.jsp">Modificar</a> | 
<a href="index.jsp">Cancelar</a>
</body>
</html>