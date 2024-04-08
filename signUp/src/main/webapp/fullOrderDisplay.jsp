<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Full Order Details</title>
    <link rel="stylesheet" href="style.css">
 
</head>
<body >

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ten_Rates", "root", "Mysql1shot");

        // Retrieve order details based on orderId parameter
        String orderIdParam = request.getParameter("orderId");
        int orderId = Integer.parseInt(orderIdParam);
        
        // Set orderId in the session
        session.setAttribute("orderId", orderId);


        String sql = "SELECT OrderTable.*, UserTable.* FROM OrderTable JOIN UserTable ON OrderTable.userId = UserTable.userId WHERE OrderTable.orderId = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, orderId);
        ResultSet rs = pstmt.executeQuery();
        

        String sqlCount = "SELECT COUNT(*) AS quotationCount FROM QuotationTable WHERE orderId = ?";
        PreparedStatement pstmtCount = conn.prepareStatement(sqlCount);
        pstmtCount.setInt(1, orderId);
        ResultSet rsCount = pstmtCount.executeQuery();

        int quotationCount = 0;
        if (rsCount.next()) {
            quotationCount = rsCount.getInt("quotationCount");
        }
        

        if (rs.next()) {
        	
        	  int userIdFromOrder = rs.getInt("userId");
            %>
           
          
            <h2>Order Details - <%= rs.getString("workOrderTitle") %></h2>
                <br/>
            <form>
         
            <div id =ordercontainer>
          
            <div class="orderDiv">
            <p>Name: <%= rs.getString("Fname") %> <%= rs.getString("Mname") %> <%= rs.getString("Lname") %></p>
             <br/>
              <p>Start Date: <%= rs.getString("startDate") %> </p>
             <br/>
              <p>Status: <%= rs.getString("status") %></p>
             <br/>  
               <p>Budget: <%= rs.getString("budget") %></p>
             <br/>
               <p>Category: <%= rs.getString("category") %></p>
             <br/>
              <p>Number of Quotations: <%= quotationCount %></p>
              <br/>
             </div>
             
              <div class="orderDiv">
             <p>User Type: <%= rs.getString("userType") %></p>
             <br/>
             <p>End Date: <%= rs.getString("endDate") %></p>
             <br/> 
              <p>Description: <%= rs.getString("description") %></p>
             <br/>
            
              </div>
             </div>
             <div id="divcontainer">
               <a href="displayQuotations.jsp?orderId=<%= orderId %>"><button type="button">View All Quotations</button></a>
              <%-- Display button only if the order does not belong to the logged-in user --%>
                <% 
                    Integer userIdFromSession = (Integer) session.getAttribute("userId");
                    if (userIdFromSession != null && userIdFromSession != userIdFromOrder) {
                %>
                
                    <a href="quotation.html"><button type="button">Generate Quotation</button></a>
                <% } %>
                <br/>
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
