<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Register back end </title>
</head>
<body>

<%
    PreparedStatement pstm;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ten_Rates", "root", "Mysql1shot");

        // Get form parameters
        String userType = request.getParameter("userType");
        String Fname = request.getParameter("Fname");
        String Mname = request.getParameter("Mname");
        String Lname = request.getParameter("Lname");
        String Rmail = request.getParameter("Rmail");
        String Contact1 = request.getParameter("Contact1");
        String Contact2 = request.getParameter("Contact2");
        String AadharNo = request.getParameter("AadharNo");
        String PANno = request.getParameter("PANno");
        String state = request.getParameter("state");
        String city = request.getParameter("city");
        String Pincode = request.getParameter("Pincode");
        String haveLicense = request.getParameter("haveLicense");
        String shopActId = request.getParameter("shopActId");

        

        // Check for NULL values
     
            // Validate all fields are filled
           String sql = "INSERT INTO UserTable (userType, Fname, Mname, Lname, Rmail, Contact1, Contact2, AadharNo, PANno, state, city, Pincode, haveLicense, shopActId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstm.setString(1, userType);
			pstm.setString(2, Fname);
			pstm.setString(3, Mname);
			pstm.setString(4, Lname);
			pstm.setString(5, Rmail);
			pstm.setString(6, Contact1);
			pstm.setString(7, Contact2);
			pstm.setString(8, AadharNo);
			pstm.setString(9, PANno);
			pstm.setString(10, state);
			pstm.setString(11, city);
			pstm.setString(12, Pincode);
			pstm.setString(13, haveLicense);
			pstm.setString(14, shopActId);
			pstm.executeUpdate();

	        // Retrieve the generated user_id
	        ResultSet generatedKeys = pstm.getGeneratedKeys();
	        if (generatedKeys.next()) {
	            int generatedUserId = generatedKeys.getInt(1);
	            //out.println("<h1>Your information is saved successfully with user_id: " + generatedUserId + "Remember this userId</h1>");
	            response.sendRedirect("SignIn.html");
	        } else {
	            out.println("<h1>Please fill in all required fields.</h1>");
	        }
			
		

        } catch (Exception e) {
        out.println(e);
    }
%>

</body>
</html>
