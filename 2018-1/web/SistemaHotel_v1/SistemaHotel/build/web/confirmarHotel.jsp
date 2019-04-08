<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sistema Hotel</title>
<link rel="stylesheet" type="text/css" href="estilo.css" />
</head>
<body>
    <a href="index.jsp"><h1>Cadastrar Hotel</h1></a>

Atenção! Deseja realmente cadastrar seu hotel?
<br/>
Uma vez enviado, você está automaticamente aceitando
pagar R$ 20,00 de inscrição.
<br/><br/>
CPNJ: ${sessionScope.novoHotel.cnpj}<br/>
Nome: ${sessionScope.novoHotel.nome}<br/>
Cidade: ${sessionScope.novoHotel.cidade}<br/>
<br/>
<a href="GravarHotelServlet">Confirmar</a> | 
<a href="hotelForm.jsp">Modificar</a> | 
<a href="index.jsp">Cancelar</a>
</body>
</html>