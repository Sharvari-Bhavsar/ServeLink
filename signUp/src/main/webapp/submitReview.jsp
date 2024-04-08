
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
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect("SignIn.html"); // Redirect to SignIn page
}
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ten_Rates", "root", "Mysql1shot");

        // Get user ID from session (you need to implement this based on your authentication logic)
       Integer userid = (Integer) session.getAttribute("userId");


        // Get form parameters
        String name = request.getParameter("name");
        String rating = request.getParameter("rating");
        String review = request.getParameter("review");

        // Insert data into OrderTable
          String sql = "INSERT INTO Reviews_Table (userId ,rating, review) VALUES (?,  ?,?)";
        PreparedStatement pstm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
      
        pstm.setString(1, userid.toString());
		pstm.setString(2, rating);
		pstm.setString(3, review);
        pstm.executeUpdate();
        

        // Retrieve the generated order_id
        ResultSet generatedKeys = pstm.getGeneratedKeys();
        if (generatedKeys.next()) {
            int generatedReviewId = generatedKeys.getInt(1);
            out.println("<h1>Your ReviewId generarted is successfully  " + generatedReviewId + "</h1>");
            response.sendRedirect("Homepage.html");
            
        } else {
            out.println("<h1>Failed to generate ReviewId</h1>");
        }

    } catch (Exception e) {
        out.println(e);
        out.println("<h1>Failed to save Review</h1>");
    }
%>

</body>
</html>

