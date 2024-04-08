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

            String sql = "SELECT Reviews_Table.*, UserTable.* FROM Reviews_Table JOIN UserTable ON Reviews_Table.userId = UserTable.userId WHERE UserTable.userId = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId.toString());
            ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Display My Reviews</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>My Reviews</h2>
    <br/>
    <table class="order-table">
        <thead>
            <tr>
            
              	<th>Name</th>
                <th>Rating</th>
                <th>Review</th>
                <th>Action</th>
               
            </tr>
        </thead>
        <tbody>
            <%
            while (rs.next()) {
            %>
            <tr>
               
                <td><%= rs.getString("Fname") %> <%= rs.getString("Lname") %></td>
                <td><%= rs.getString("rating") %></td>
                <td><%= rs.getString("review").length() > 10 ? rs.getString("review").substring(0, 10) + "..." : rs.getString("review") %></td>
                
                <td><a class="Back" href="fullReviewDisplay.jsp?ReviewId=<%= rs.getString("ReviewId") %>">View More</a></td>
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
