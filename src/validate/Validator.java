package validate;

import javax.servlet.http.HttpServletRequest;

public class Validator {

    public boolean validateQuantity (String productId, String quantity) {
        boolean errorFlag = false;

        if (!productId.isEmpty() && !quantity.isEmpty()) {
            int i = -1;

            try {
                i = Integer.parseInt(quantity);
            } catch (NumberFormatException nfe) {
                System.out.println("User did not enter a number in the quantity field");
            }

            if (i < 0 || i > 99) {
                errorFlag = true;
            }
        }

        return errorFlag;
    }

    public boolean validateForm(String name,
                                String email,
                                String phone,
                                String address,
                                String town,
                                String county,
                                String postcode,
                                String ccNumber,
                                HttpServletRequest request) {

        boolean errorFlag = false;
        boolean nameError;
        boolean emailError;
        boolean phoneError;
        boolean addressError;
        boolean townError;
        boolean countyError;
        boolean postcodeError;
        boolean ccNumberError;

        if (name == null
                || name.equals("")
                || name.length() > 45) {
            errorFlag = true;
            nameError = true;
            request.setAttribute("nameError", nameError);
        }
        if (email == null
                || email.equals("")
                || !email.contains("@")) {
            errorFlag = true;
            emailError = true;
            request.setAttribute("emailError", emailError);
        }
        if (phone == null
                || phone.equals("")
                || phone.length() < 9) {
            errorFlag = true;
            phoneError = true;
            request.setAttribute("phoneError", phoneError);
        }
        if (address == null
                || address.equals("")
                || address.length() > 64) {
            errorFlag = true;
            addressError = true;
            request.setAttribute("addressError", addressError);
        }
        if (town == null
                || town.equals("")
                || town.length() > 45) {
            errorFlag = true;
            townError = true;
            request.setAttribute("townError", townError);
        }
        if (county == null
                || county.equals("")
                || county.length() > 45) {
            errorFlag = true;
            countyError = true;
            request.setAttribute("countyError", countyError);
        }
        if (postcode == null
                || postcode.equals("")
                || postcode.length() > 8) {
            errorFlag = true;
            postcodeError = true;
            request.setAttribute("postcodeError", postcodeError);
        }
        if (ccNumber == null
                || ccNumber.equals("")
                || ccNumber.length() > 19) {
            errorFlag = true;
            ccNumberError = true;
            request.setAttribute("ccNumberError", ccNumberError);
        }

        return errorFlag;
    }

}