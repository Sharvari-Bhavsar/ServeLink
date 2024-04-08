<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<%
    // Check if user is signed in
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("SignIn.html"); // Redirect to SignIn page
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ten_Rates", "root", "Mysql1shot");

            String sql = "SELECT OrderTable.*, UserTable.* FROM OrderTable JOIN UserTable ON OrderTable.userId = UserTable.userId WHERE UserTable.userId = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId.toString());
            ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Display My Orders</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>My Orders</h2>
    <br/>
    <table class="order-table">
        <thead>
            <tr>
             
                <th>User Type</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Work Order Title</th>
                <th>Category</th>
                <th>Budget</th>
                <th>Description</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
            while (rs.next()) {
            %>
            <tr>

                <td><%= rs.getString("userType") %></td>
                <td><%= rs.getString("Fname").length() > 15 ? rs.getString("Fname").substring(0, 15) + "..." : rs.getString("Fname") %></td>
                <td><%= rs.getString("Lname").length() > 15 ? rs.getString("Lname").substring(0, 15) + "..." : rs.getString("Lname") %></td>
                <td><%= rs.getString("workOrderTitle").length() > 10 ? rs.getString("workOrderTitle").substring(0, 10) + "..." : rs.getString("workOrderTitle") %></td>
                <td><%= rs.getString("category").length() > 10 ? rs.getString("category").substring(0, 10) + "..." : rs.getString("category") %></td>
                <td><%= rs.getString("budget") %></td>
                <td><%= rs.getString("description").length() > 20 ? rs.getString("description").substring(0, 20) + "..." : rs.getString("description") %></td>
                <td><%= rs.getString("status") %></td>
                <td><a class="Back" href="fullOrderDisplay.jsp?orderId=<%= rs.getString("orderId") %>">View More</a></td>
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
