package controller;

import cart.ShoppingCart;
import entity.Category;
import entity.Product;
import session.CategoryFacade;
import session.CustomerOrderFacade;
import session.OrderManager;
import session.ProductFacade;
import validate.Validator;

import javax.ejb.EJB;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collection;
import java.util.Map;

@WebServlet(name="ControllerServlet", loadOnStartup = 1, urlPatterns = {"/category", "/addToCart", "/viewCart", "/updateCart", "/checkout", "/purchase"})
public class ControllerServlet extends HttpServlet {

    private String surcharge;

    @EJB
    private CategoryFacade categoryFacade;

    @EJB
    private ProductFacade productFacade;

    @EJB
    private CustomerOrderFacade customerOrderFacade;

    @EJB
    private OrderManager orderManager;

    @Override
    public void init(ServletConfig servletConfig) throws ServletException {
        super.init(servletConfig);

        surcharge = servletConfig.getServletContext().getInitParameter("deliverySurcharge");

        getServletContext().setAttribute("categories", categoryFacade.findAll());
        getServletContext().setAttribute("products", productFacade.findAll());
        getServletContext().setAttribute("orders", customerOrderFacade.findAll());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userPath = request.getServletPath();
        HttpSession session = request.getSession();
        Category selectedCategory;
        Collection<Product> categoryProducts;

        if (userPath.equals("/category")) {
            String categoryId = request.getParameter("id");
            //String categoryName = request.getParameter("name");

            if (categoryId != null) {
                selectedCategory = categoryFacade.find(Integer.parseInt(categoryId));
                //selectedCategory = categoryFacade.findByName(categoryName);
                request.setAttribute("selectedCategory", selectedCategory);

                categoryProducts = selectedCategory.getProductCollection();
                request.setAttribute("categoryProducts", categoryProducts);
            }

        } else if (userPath.equals("/viewCart")) {

            String clear = request.getParameter("clear");

            if (clear != null && clear.equalsIgnoreCase("true")) {
                ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
                cart.clear();
            }

            userPath = "/cart";
        } else if (userPath.equals("/checkout")) {
            ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
            cart.calculateTotal(surcharge);
        }

        String url = userPath + ".jsp";

        try {
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String userPath = request.getServletPath();
        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        Validator validator = new Validator();

        if (userPath.equals("/addToCart")) {
            if (cart == null) {
                cart = new ShoppingCart();
                session.setAttribute("cart", cart);
            }

            String productId = request.getParameter("productId");

            if (!productId.isEmpty()) {
                Product product = productFacade.find(Integer.parseInt(productId));
                cart.addItem(product);
            }

            request.setAttribute("categoryId", request.getParameter("id"));

            userPath = "/cart";
        } else if (userPath.equals("/updateCart")) {
            String productId = request.getParameter("productId");
            String quantity = request.getParameter("quantity");

            boolean invalidEntry = validator.validateQuantity(productId, quantity);

            if (!invalidEntry) {
                Product product = productFacade.find(Integer.parseInt(productId));
                cart.update(product, quantity);
            }

            userPath = "/cart";
        } else if (userPath.equals("/confirmation")) {
            if (cart != null) {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String town = request.getParameter("town");
                String county = request.getParameter("county");
                String postcode = request.getParameter("postcode");
                String ccNumber = request.getParameter("creditcard");

                boolean validationErrorFlag = validator.validateForm(name, email, phone, address, town, county, postcode, ccNumber, request);

                if (validationErrorFlag) {
                    request.setAttribute("validationErrorFlag", validationErrorFlag);
                    userPath = "/checkout";
                } else {
                    int orderId = orderManager.placeOrder(name, email, phone, address, town, county, postcode, ccNumber, cart);
                    System.out.println("ORDER ID IS " + orderId);
                    if (orderId != 0) {
                        cart = null;
                        session.invalidate();
                        Map orderMap = orderManager.getOrderDetails(orderId);

                        request.setAttribute("customer", orderMap.get("customer"));
                        request.setAttribute("products", orderMap.get("products"));
                        request.setAttribute("orderRecord", orderMap.get("orderRecord"));
                        request.setAttribute("orderedProducts", orderMap.get("orderedProducts"));

                        userPath = "/confirmation";
                    } else {
                        userPath = "/checkout";
                        request.setAttribute("orderFailureFlag", true);
                    }
                }
            }
        }

        String url = userPath + ".jsp";

        try {
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}