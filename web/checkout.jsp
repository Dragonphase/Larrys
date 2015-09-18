<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script src="js/jquery.validate.js" type="text/javascript"></script>

<script type="text/javascript">

    $(document).ready(function(){
        $("#checkoutForm").validate({
            rules: {
                name: "required",
                email: {
                    required: true,
                    email: true
                },
                phone: {
                    required: true,
                    number: true,
                    minlength: 9
                },
                address: {
                    required: true
                },
                creditcard: {
                    required: true,
                    creditcard: true
                }
            }
        });
    });
</script>

<h1>Checkout</h1>
<c:if test="${!empty orderFailureFlag}">
    <p class="error">We were unable to process your order. Please try again!</p>
</c:if>

<table id="cart" class="table table-hover table-condensed">
    <thead>
        <tr>
            <th style="width:60%">Product</th>
            <th style="width:10%">Price</th>
            <th style="width:8%">Quantity</th>
            <th style="width:22%" class="text-right">Subtotal</th>
        </tr>
    </thead>
    <c:if test="${!empty cart && cart.numberOfItems != 0}">
        <tbody>
            <c:forEach var="cartItem" items="${cart.items}" varStatus="iter">
                <c:set var="product" value="${cartItem.product}" scope="request"/>

                <jsp:include page="jspf/checkout-item.jspf" flush="true">
                    <jsp:param name="name" value="${product.name}"/>
                    <jsp:param name="description" value="${product.description}"/>
                    <jsp:param name="price" value="${product.price}"/>
                    <jsp:param name="quantity" value="${cartItem.quantity}"/>
                </jsp:include>
            </c:forEach>
        </tbody>
    </c:if>
    <tfoot>
        <tr>
            <td colspan="3" class="hidden-xs"></td>
            <td class="hidden-xs text-right">Subtotal: &pound;${cart.subtotal}</td>
        </tr>
        <tr>
            <td>A &pound;${initParam.deliverySurcharge} delivery surcharge is applied to all purchase orders:</td>
            <td colspan="2" class="hidden-xs"></td>
            <td class="hidden-xs text-right">+ &pound;${initParam.deliverySurcharge}</td>
        </tr>
        <tr>
            <td colspan="3" class="hidden-xs"></td>
            <td class="hidden-xs text-right"><strong>Total: &pound;${cart.subtotal + initParam.deliverySurcharge}</strong></td>
        </tr>
    </tfoot>
</table>

<p>In order to purchase the items in your shopping cart, please provide us with the following information:</p>

<c:if test="${!empty validationErrorFlag}">
    <span class="error smallText">Please provide valid entries for the following field(s):

        <c:if test="${!empty nameError}">
            <br><span class="indent"><strong>Name</strong> (e.g., Bilbo Baggins)</span>
        </c:if>
        <c:if test="${!empty emailError}">
            <br><span class="indent"><strong>Email</strong> (e.g., b.baggins@hobbit.com)</span>
        </c:if>
        <c:if test="${!empty phoneError}">
            <br><span class="indent"><strong>Phone</strong> (e.g., 222333444)</span>
        </c:if>
        <c:if test="${!empty addressError}">
            <br><span class="indent"><strong>Address</strong> (e.g., Korunní 56)</span>
        </c:if>
        <c:if test="${!empty townError}">
            <br><span class="indent"><strong>Town / City</strong> (e.g., Manchester)</span>
        </c:if>
        <c:if test="${!empty countyError}">
            <br><span class="indent"><strong>County</strong> (e.g., Lancashire)</span>
        </c:if>
        <c:if test="${!empty postcodeError}">
            <br><span class="indent"><strong>Postcode</strong> (e.g., LL5 1UY)</span>
        </c:if>
        <c:if test="${!empty ccNumberError}">
            <br><span class="indent"><strong>Credit Card Number</strong> (e.g., 1111222233334444)</span>
        </c:if>

    </span>
</c:if>

<form id="checkoutForm" action="<c:url value='confirmation'/>" method="post">
    <table id="checkoutTable" class="table table-hover table-condensed">
        <thead>
            <tr>
                <th style="width:20%"></th>
                <th></th>
                <th style="width:40%"></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Name:</td>
                <td>
                    <input type="text" size="31" maxlength="45" id="name" name="name" value="${param.name}" class="form-control" />
                </td>
                <td colspan="1" class="hidden-xs"></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td>
                    <input type="text" size="31" maxlength="45" id="email" name="email" value="${param.email}" class="form-control" />
                </td>
                <td colspan="1" class="hidden-xs"></td>
            </tr>
            <tr>
                <td>Phone:</td>
                <td>
                    <input type="text" size="31" maxlength="16" id="phone" name="phone" value="${param.phone}" class="form-control" />
                </td>
                <td colspan="1" class="hidden-xs"></td>
            </tr>
            <tr>
                <td>Address:</td>
                <td>
                    <input type="text" size="31" maxlength="64" id="address" name="address" value="${param.address}" class="form-control" />
                </td>
                <td colspan="1" class="hidden-xs"></td>
            </tr>
            <tr>
                <td>Town / City:</td>
                <td>
                    <input type="text" size="31" maxlength="45" id="town" name="town" value="${param.town}" class="form-control" />
                </td>
                <td colspan="1" class="hidden-xs"></td>
            </tr>
            <tr>
                <td>County / Region:</td>
                <td>
                    <input type="text" size="31" maxlength="45" id="county" name="county" value="${param.county}" class="form-control" />
                </td>
                <td colspan="1" class="hidden-xs"></td>
            </tr>
            <tr>
                <td>Postal Code:</td>
                <td>
                    <input type="text" size="31" maxlength="8" id="postcode" name="postcode" value="${param.postcode}" class="form-control" />
                </td>
                <td colspan="1" class="hidden-xs"></td>
            </tr>
            <tr>
                <td>Credit Card Number:</td>
                <td>
                    <input type="text" size="31" maxlength="19" id="creditcard" name="creditcard" value="${param.creditcard}" class="form-control" />
                </td>
                <td colspan="1" class="hidden-xs"></td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="1" class="hidden-xs"></td>
                <td>
                    <input type="submit" value="Place Order" class="btn btn-success btn-block push-right">
                </td>
            </tr>
        </tfoot>
    </table>
</form>