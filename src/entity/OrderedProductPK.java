package entity;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Id;
import java.io.Serializable;

@Embeddable
public class OrderedProductPK implements Serializable {
    private int customerOrderId;
    private int productId;

    public OrderedProductPK() {
    }

    public OrderedProductPK(int customerOrderId, int productId) {
        this.customerOrderId = customerOrderId;
        this.productId = productId;
    }

    @Basic(optional = false)
    @Column(name = "customer_order_id")
    public int getCustomerOrderId() {
        return customerOrderId;
    }

    public void setCustomerOrderId(int customerOrderId) {
        this.customerOrderId = customerOrderId;
    }

    @Basic(optional = false)
    @Column(name = "product_id")
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        OrderedProductPK that = (OrderedProductPK) o;

        if (customerOrderId != that.customerOrderId) return false;
        if (productId != that.productId) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = customerOrderId;
        result = 31 * result + productId;
        return result;
    }
}
