<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Display Quotations</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ten_Rates", "root", "Mysql1shot");

        // Retrieve order details based on orderId parameter
        Integer orderId = (Integer) session.getAttribute("orderId");
        Integer userId = (Integer) session.getAttribute("userId");
        
        

        String sql = "SELECT OrderTable.*, QuotationTable.*, UserTable.Fname, UserTable.Mname, UserTable.Lname, UserTable.Rmail, UserTable.Contact1, UserTable.Contact2 " +
                     "FROM OrderTable " +
                     "JOIN QuotationTable ON OrderTable.orderId = QuotationTable.orderId " +
                     "JOIN UserTable ON QuotationTable.userId = UserTable.userId " +
                     "WHERE OrderTable.orderId = ? AND (OrderTable.userId = ? OR QuotationTable.userId = ?)";

        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, orderId);
        pstmt.setInt(2, userId); // Add this line to filter by user ID
        pstmt.setInt(3, userId); 

        ResultSet rs = pstmt.executeQuery();

        %>
        <h2>All Quotations</h2>
          <br/>
        <table class="order-table">
            <thead>
                <tr>
                
                    <th>Quotation</th>
                    <th>Work Order Title</th>
                    <th>Category</th>
                    <th>Budget</th>
                    <th>Status</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Contact1</th>
                    <th>Contact2</th>
                    <th>Action</th>
                    <!-- Add other order details fields as needed -->
                </tr>
            </thead>
            <tbody>
                <%
                while (rs.next()) {
                    %>
                    <tr>
                      
                        <td><%= rs.getString("Quotation").length() > 50 ? rs.getString("Quotation").substring(0, 50) + "..." : rs.getString("Quotation") %></td>
                        <td><%= rs.getString("workOrderTitle").length() > 10 ? rs.getString("workOrderTitle").substring(0, 10) + "..." : rs.getString("workOrderTitle") %></td>
                        <td><%= rs.getString("category").length() > 10 ? rs.getString("category").substring(0, 10) + "..." : rs.getString("category") %></td>
                        <td><%= rs.getString("budget") %></td>
                        <td><%= rs.getString("status") %></td>
                        <td><%= rs.getString("Fname") %> <%= rs.getString("Mname") %> <%= rs.getString("Lname") %></td>
                        <td><%= rs.getString("Rmail") %></td>
                        <td><%= rs.getString("Contact1") %></td>
                        <td><%= rs.getString("Contact2") %></td>
                        <!-- Add other order details fields as needed -->
                        <td>
                            <a class="Back" href="fullQuotationDisplay.jsp?orderId=<%= rs.getString("orderId") %>">View More</a>
                        </td>
                    </tr>
                    <%
                }
                %>
            </tbody>
        </table>
        <%
    } catch (Exception e) {
        out.println(e);
    }
%>

</body>
</html>
