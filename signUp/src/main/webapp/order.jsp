<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Order Back end</title>
</head>
<body>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ten_Rates", "root", "Mysql1shot");

        // Get user ID from session (you need to implement this based on your authentication logic)
       Integer userId = (Integer) session.getAttribute("userId");


        // Get form parameters
        String workOrderTitle = request.getParameter("workOrderTitle");
        String workOrderStartDate = request.getParameter("startDate");
        String workOrderEndDate = request.getParameter("endDate");
        String workOrderCategory = request.getParameter("Category");
        String workOrderBudget = request.getParameter("budget");
        String workOrderStatus = request.getParameter("status");
        String description = request.getParameter("description");

        // Insert data into OrderTable
        String sql = "INSERT INTO OrderTable (userId, workOrderTitle, startDate, endDate, " +
                     "category, budget, status, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        pstmt.setString(1, userId.toString());
        pstmt.setString(2, workOrderTitle);
        pstmt.setString(3, workOrderStartDate);
        pstmt.setString(4, workOrderEndDate);
        pstmt.setString(5, workOrderCategory);
        pstmt.setString(6, workOrderBudget);
        pstmt.setString(7, workOrderStatus);
        pstmt.setString(8, description);
        pstmt.executeUpdate();
        

        // Retrieve the generated order_id
        ResultSet generatedKeys = pstmt.getGeneratedKeys();
        if (generatedKeys.next()) {
            int generatedOrderId = generatedKeys.getInt(1);
            //out.println("<h1>Order submitted successfully with order_id: " + generatedOrderId + "</h1>");
            response.sendRedirect("displayOrders.jsp");
            
        } else {
            out.println("<h1>Failed to retrieve generated order_id</h1>");
        }

    } catch (Exception e) {
        out.println(e);
    }
%>

</body>
</html>
