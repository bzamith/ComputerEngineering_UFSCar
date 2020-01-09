<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sistema Hotel</title>
        <link rel="stylesheet" type="text/css" href="estilo.css" />
    </head>
    <body>
        <a href="index.jsp"><h1>Hoteis cadastrados</h1></a>
        <hr>
        <c:if test="${empty requestScope.listaHoteis}">
            <p>Não há hoteis cadastrados na cidade "${selecao}"</p>
        </c:if>
        <c:if test="${!empty requestScope.listaHoteis}">
            <table>
                <tr>
                    <th class="esquerda"><p>CPNJ</p></th>
                    <th><p>Nome</p></th>
                    <th><p>Cidade</p></th>
                </tr>
    
                <c:forEach items="${requestScope.listaHoteis}" var="hotel">
                    <tr>
                        <td class="esquerda"><p>${hotel.cnpj}</p></td>
                        <td><p>${hotel.nome}</p></td>
                        <td></p>${hotel.cidade}</p></td>
                </tr>

                </c:forEach>
            </table>
        </c:if>
    </body>
</html>
