<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Full Order Details</title>
    <link rel="stylesheet" href="style.css">
    <style>
    .stars {
            color: gold;
            font-size: 25px;
        }
    </style>
 
</head>
<body >

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ten_Rates", "root", "Mysql1shot");

        // Retrieve order details based on orderId parameter
        String ReviewIdParam = request.getParameter("ReviewId");
        int ReviewId = Integer.parseInt(ReviewIdParam);
        
        // Set orderId in the session
        session.setAttribute("ReviewId", ReviewId);


        String sql = "SELECT Reviews_Table.*, UserTable.* FROM Reviews_Table JOIN UserTable ON Reviews_Table.userId = UserTable.userId WHERE Reviews_Table.ReviewId = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, ReviewId);
        ResultSet rs = pstmt.executeQuery();
        

      
        

        if (rs.next()) {
        	
        	  int userIdFromOrder = rs.getInt("userId");
            %>
           
          
            <h2>Reviewer- <%= rs.getString("Fname") %> <%= rs.getString("Lname") %></h2>
                <br/>
            <form>
         
            <div id="ordercontainer">
          
            <div class="orderDiv">
          
              <p>Name: <%= rs.getString("Fname") %> <%= rs.getString("Mname") %> <%= rs.getString("Lname") %></p>
             <br/>
              <p>Rating: <% 
                    int rating = rs.getInt("rating");
                    for (int i = 0; i < 5; i++) {
                        if (i < rating) {
                            out.print("<span class='stars'>&#9733;</span>");
                        } else {
                            out.print("<span class='stars'>&#9734;</span>");
                        }
                    }
                %></p>
             <br/>
             
             </div>
             
              <div class="orderDiv">
                <p>Review: <%= rs.getString("review") %></p>
             <br/>  
            
              </div>
             </div>
           
            </form>
            <%
        } else {
            out.println("<p>Review not found</p>");
        }
    } catch (Exception e) {
        out.println(e);
    }
%>

</body>
</html>
