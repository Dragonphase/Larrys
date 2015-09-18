<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h1>${selectedCategory.name}</h1>

<table id="cart" class="table table-hover table-condensed">
    <thead>
        <tr>
            <th style="width:75%">Product</th>
            <th style="width:20%">Price</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="product" items="${categoryProducts}" varStatus="iter">
        <jsp:include page="jspf/category-item.jspf" flush="true">
            <jsp:param name="id" value="${product.id}"/>
            <jsp:param name="name" value="${product.name}"/>
            <jsp:param name="description" value="${product.description}"/>
            <jsp:param name="price" value="${product.price}"/>
        </jsp:include>
    </c:forEach>
    </tbody>
    <tfoot>
        <tr>
            <td colspan="1" class="xs-hidden"></td>
            <td><a href="#" class="btn btn-default pull-right"><i class="glyphicon glyphicon-arrow-left"></i> Previous Page</a></td>
            <td><a href="#" class="btn btn-default pull-right">Next Page <i class="glyphicon glyphicon-arrow-right"></i></a></td>
        </tr>
    </tfoot>
</table>