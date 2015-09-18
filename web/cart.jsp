<h1>Your Shopping Cart</h1>
<c:choose>
    <c:when test="${cart.numberOfItems > 1}">
        <p>Your shopping cart contains ${cart.numberOfItems} items.</p>
    </c:when>
    <c:when test="${cart.numberOfItems == 1}">
        <p>Your shopping cart contains ${cart.numberOfItems} item.</p>
    </c:when>
    <c:otherwise>
        <p>Your shopping cart is empty.</p>
    </c:otherwise>
</c:choose>

<table id="cart" class="table table-hover table-condensed">
    <thead>
        <tr>
            <th style="width:50%">Product</th>
            <th style="width:20%">Price</th>
            <th style="width:8%">Quantity</th>
            <th style="width:10%"></th>
            <th style="width:10%"></th>
        </tr>
    </thead>

    <c:if test="${!empty cart && cart.numberOfItems != 0}">
        <tbody>

        <c:forEach var="cartItem" items="${cart.items}" varStatus="iter">
            <c:set var="product" value="${cartItem.product}" scope="request"/>

            <jsp:include page="jspf/cart-item.jspf" flush="true">
                <jsp:param name="id" value="${product.id}"/>
                <jsp:param name="name" value="${product.name}"/>
                <jsp:param name="description" value="${product.description}"/>
                <jsp:param name="price" value="${product.price}"/>
                <jsp:param name="quantity" value="${cartItem.quantity}"/>
            </jsp:include>
        </c:forEach>
        </tbody>
    </c:if>

    <c:set var="value">
        <c:choose>
            <c:when test="${!empty selectedCategory}">
                category?=${selectedId}
            </c:when>
            <c:otherwise>
                index.jsp
            </c:otherwise>
        </c:choose>
    </c:set>

    <c:url var="url" value="${value}"/>

    <tfoot>
        <tr>
            <td><a href="${url}" class="btn btn-warning"><i class="glyphicon glyphicon-arrow-left"></i> Continue Shopping</a></td>
            <c:if test="${!empty cart && cart.numberOfItems != 0}">
                <td class="hidden-xs"><strong>Total: &pound;${cart.subtotal}</strong></td>
                <td colspan="2" class="hidden-xs"></td>
                <td><a href="checkout.jsp" class="btn btn-success btn-block">Checkout <i class="glyphicon glyphicon-arrow-right"></i></a></td>
            </c:if>
            <td colspan="2" class="hidden-xs"></td>
        </tr>
    </tfoot>
</table>