<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Display My Reviews</title>
    <link rel="stylesheet" href="style.css">
    <style>
        /* Style for the popup */
      .totalRating{
      margin-left:20px;
      margin-bottom:5px;
      s}
    </style>
</head>
<body>
    <h2>My Reviews</h2>
    <br/>
    <button class ="totalRating" onclick="showCumulativeRatingPopup()">Show Total Rating</button>
    
    <table class="order-table">
        <thead>
            <tr>
                <th>userId</th>
              	<th>Name</th>
                <th>Rating</th>
                <th>Review</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ten_Rates", "root", "Mysql1shot");

                String sql = "SELECT Reviews_Table.*, UserTable.* FROM Reviews_Table JOIN UserTable ON Reviews_Table.userId = UserTable.userId ";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery();
                
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("userId") %></td>
                <td><%= rs.getString("Fname") %> <%= rs.getString("Lname") %></td>
                <td><%= rs.getInt("rating") %></td>
                <td><%= rs.getString("review").length() > 10 ? rs.getString("review").substring(0, 10) + "..." : rs.getString("review") %></td>
                <td><a class="Back" href="fullReviewDisplay.jsp?ReviewId=<%= rs.getString("ReviewId") %>">View More</a></td>
            </tr>
            <% 
                }
                rs.close();
                pstmt.close();
                conn.close();
            } catch (Exception e) {
                out.println(e);
            }
            %>
        </tbody>
    </table>

    <!-- Popup for Cumulative Rating -->
    <div class="popup" id="cumulativeRatingPopup">
      <span class="close" onclick="closeCumulativeRatingPopup()">&times;</span>
        <h3>Total Rating</h3>
        <% 
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ten_Rates", "root", "Mysql1shot");
            String sql = "SELECT AVG(rating) AS avgRating FROM Reviews_Table";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                double cumulativeRating = rs.getDouble("avgRating");
                int starRating = (int) Math.round(cumulativeRating); // Round the cumulative rating to the nearest integer
                
                // Display cumulative rating using stars
                out.print("<p>Total Rating: ");
                for (int i = 0; i < 5; i++) {
                    if (i < starRating) {
                        out.print("<span class='stars'>&#9733;</span>"); // Filled star
                    } else {
                        out.print("<span class='stars'>&#9734;</span>"); // Empty star
                    }
                }
                out.print("</p>");
            }
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            out.println(e);
        }
        %>
    </div>

    <script>
        function showCumulativeRatingPopup() {
            var popup = document.getElementById("cumulativeRatingPopup");
            popup.style.display = "block";
        }
        
        function closeCumulativeRatingPopup() {
            var popup = document.getElementById("cumulativeRatingPopup");
            popup.style.display = "none";
        }
    </script>
     <script src="script.js"></script>
</body>
</html>
