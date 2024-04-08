<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Full Quotation Details</title>
    <link rel="stylesheet" href="style.css">
   
</head>
<body >

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
        if (rs.next()) {
            %>
           
          
            <h2>Quotation Details - <%= rs.getString("workOrderTitle") %></h2>
                <br/>
            <form>
         
            <div id =ordercontainer>
          
            <div class="orderDiv">
           
              <p>Start Date: <%= rs.getString("startDate") %> </p>
             <br/>
              <p>Status: <%= rs.getString("status") %></p>
             <br/>  
               <p>Budget: <%= rs.getString("budget") %></p>
             <br/>
               <p>Category: <%= rs.getString("category") %></p>
             <br/>
              <p>End Date: <%= rs.getString("endDate") %></p>
             <br/> 
             </div>
             
              <div class="orderDiv">
            
             <p>Name: <%= rs.getString("Fname") %> <%= rs.getString("Mname") %> <%= rs.getString("Lname") %></p>
             <br/> 
              <p>Contact1: <%= rs.getString("Contact1") %></p>
             <br/> 
               <p> Contact2: <%= rs.getString("Contact2") %></p>
             <br/>
                <p> Email: <%= rs.getString("Rmail") %></p>
             <br/>
              <p>Quotation: <%= rs.getString("Quotation") %></p>
             <br/>
             </div>
             </div>
           
            </form>
            <%
        } else {
            out.println("<p>Order not found</p>");
        }
    } catch (Exception e) {
        out.println(e);
    }
%>

</body>
</html>
