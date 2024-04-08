<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>QuotationDetails</title>
</head>
<body>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ten_Rates", "root", "Mysql1shot");

        // Get user ID from session (you need to implement this based on your authentication logic)
       Integer userId = (Integer) session.getAttribute("userId");
       Integer orderId = (Integer) session.getAttribute("orderId");


        // Get form parameters
      
        String Quotation = request.getParameter("Quotation");

        // Insert data into OrderTable
        String sql = "INSERT INTO QuotationTable (orderId,userId,Quotation) VALUES (?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        pstmt.setString(1, orderId.toString());
        pstmt.setString(2, userId.toString());
        pstmt.setString(3, Quotation);
      
        pstmt.executeUpdate();

        // Retrieve the generated Quot_id
        ResultSet generatedKeys = pstmt.getGeneratedKeys();
        if (generatedKeys.next()) {
            int generatedQuotId = generatedKeys.getInt(1);
           // out.println("<h1>Quotation submitted successfully with Quot_id: " + generatedQuotId + "</h1>");
            response.sendRedirect("displayOrders.jsp");
        } else {
            out.println("<h1>Failed to retrieve generated Quot_id</h1>");
        }

    } catch (Exception e) {
        out.println(e);
    }
%>

</body>
</html>
