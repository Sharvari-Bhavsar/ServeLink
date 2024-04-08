<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Display Orders</title>
   <link rel="stylesheet" href="style.css">
  
  
</head>
<body >

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ten_Rates", "root", "Mysql1shot");

        // Retrieve orders from the database
        String sql = "SELECT OrderTable.*, UserTable.* FROM OrderTable JOIN UserTable ON OrderTable.userId = UserTable.userId";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        %>
        <h2>All Orders</h2>
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
                    <th>description</th>
                   <th>Status</th>
                  
                    <th>Action</th>
                    <!-- Add other order details fields as needed -->
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
                     
                        <!-- Add other order details fields as needed -->
                      
                        <td>
                            <a  class = "Back"  href="fullOrderDisplay.jsp?orderId=<%= rs.getString("orderId") %>">View More</a>
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
