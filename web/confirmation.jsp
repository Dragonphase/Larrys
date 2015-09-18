<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    //Load order details
%>

<h1>Order Comfirmation</h1>

<p>Your order has been successfully processed and will be delivered within 24 hours.</p>

<h3>Order Summary</h3>
<table id="cart" class="table table-hover table-condensed">
    <thead>
    <tr>
        <th style="width:50%">Order Number</th>
        <th style="width:20%">Quantity of Items</th>
        <th style="width:8%">Total Price</th>
    </tr>
    </thead>
    <tbody>
        <c:forEach var="orderedProduct" items="${orderedProducts}" varStatus="iter">
            <tr>
                <td>${products[iter.index].name}</td>
                <td class="quantityColumn">${orderedProduct.quantity}</td>
                <td class="confirmationPriceColumn">&pound;${products[iter.index].price * orderedProduct.quantity}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>