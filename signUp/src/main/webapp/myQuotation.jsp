<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<%
    // Check if user is signed in
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("SignIn.html"); // Redirect to SignIn page if not signed in
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ten_Rates", "root", "Mysql1shot");

            String sql = "SELECT OrderTable.*, QuotationTable.* FROM OrderTable JOIN QuotationTable ON OrderTable.orderId = QuotationTable.orderId WHERE QuotationTable.userId = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId); // Set the user ID parameter
            ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Display My Quotation</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>My Quotations</h2>
    <br/>
    <table class="order-table">
        <thead>
            <tr>
              
                <th>Work Order Title</th>
                <th>Category</th>
                <th>Budget</th>
                <th>Status</th>
                <th>Quotation</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
            while (rs.next()) {
            %>
            <tr>
              
                <td><%= rs.getString("workOrderTitle").length() > 10 ? rs.getString("workOrderTitle").substring(0, 10) + "..." : rs.getString("workOrderTitle") %></td>
                <td><%= rs.getString("category").length() > 10 ? rs.getString("category").substring(0, 10) + "..." : rs.getString("category") %></td>
                <td><%= rs.getString("budget") %></td>
                <td><%= rs.getString("status") %></td>
                <td><%= rs.getString("Quotation").length() > 50 ? rs.getString("Quotation").substring(0, 50) + "..." : rs.getString("Quotation") %></td>
                <td><a class="Back" href="fullQuotationDisplay.jsp?orderId=<%= rs.getString("orderId") %>">View More</a></td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>
</body>
</html>
<%
    } catch (Exception e) {
        out.println(e);
    }
}
%>
