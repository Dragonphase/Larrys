<%--
  Created by IntelliJ IDEA.
  User: Dragonphase
  Date: 10/06/2015
  Time: 11:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<html>
<head>
    <title>JSP Data Source Test</title>
</head>
    <body>
    <h1>Hello World!</h1>

    <sql:query var="result" dataSource="jdbc/larrys">
        SELECT * FROM category, product
        WHERE category.id = product.category_id
    </sql:query>

    <table border="1">
        <tr>
            <c:forEach var="columnName" items="${result.columnNames}">
                <th><c:out value="${columnName}"/></th>
            </c:forEach>
        </tr>
        <c:forEach var="row" items="${result.rowsByIndex}">
            <tr>
                <c:forEach var="column" items="${row}">
                    <td><c:out value="${column}"/></td>
                </c:forEach>
            </tr>
        </c:forEach>
    </table>
    </body>
</html>
