<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:remove scope="session" var="novoHotel" />
<c:remove scope="session" var="cnpj" />
<c:remove scope="session" var="cidade" />
<c:remove scope="session" var="admin" />
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sistema de Hotel</title>
        <link rel="stylesheet" type="text/css" href="estilo.css" />        
    </head>
    <body>
        <a href="index.jsp"><h1>Sistema Hotel</h1></a>
        <hr>
        <c:if test="${!empty mensagem}">
            ${mensagem}
        <hr>
        </c:if>
        <p>Bem-Vindo ao Sistema de Hotel<p>
        <p>Selecione o Menu Correspondente:</p>     
        
        <h2 onClick="document.getElementById('usuario').style = 'display: block;';">Usuario </h2>
        <div style='display: none;' id='usuario'>
            <a href="VerHoteisServlet">Listar Todos os Hoteis</a><br>
            <u><a onClick="document.getElementById('selecaoCidade').style = 'display: block;';">Listar Hoteis por Cidade</a></u>
            <div style='display: none;' id='selecaoCidade'>
                <form action="EnviaCidadeServlet" method="post">
                &emsp;Cidade: <input name="cidade" type="text" value="${sessionScope.cidade}" placeholder="Nome da Cidade"/>  
                <input type="submit" value="Buscar"/>
                </form>
            </div>
            
            
        </div>
        <h2 onClick="document.getElementById('hotel').style = 'display: block;';">Hotel </h2>
        <div style='display: none;' id='hotel'>
            <a href="LoginHotelServlet?comando=promocaoForm">Criar promoção</a><br>
            <u><a onClick="document.getElementById('selecaoHotel').style = 'display: block;';">Listar Promoções por Hotel</a></u>
            <div style='display: none;' id='selecaoHotel'>
                <form action="LoginHotelServlet?comando=ListarPromocoesHotelServlet" method="post">
                &emsp;CNPJ do Hotel: <input name="cnpj" type="text" value="${sessionScope.cnpj}" placeholder="Digite o CNPJ do Hotel"/>  
                <input type="submit" value="Buscar"/>
                </form>
            </div>
        </div>
         <h2 onClick="document.getElementById('site').style = 'display: block;';">Site de Reservas </h2>
        <div style='display: none;' id='site'>
            <a href="#">Listar Promoções por Site de Reservas</a>
        </div>
         <h2 onClick="document.getElementById('admin').style = 'display: block;';">Administrador </h2>
        <div style='display: none;' id='admin'>
            <a href="LoginAdminServlet?comando=hotelForm">Cadastrar Hotel</a><br>
            <a href="LoginAdminServlet?comando=siteReservaForm">Cadastrar Site de Reservas</a>
        </div>
    </body>
</html>