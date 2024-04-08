<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>login</title>
  <link rel ="stylesheet" href ="style.css">
 
</head>
<body>
<%





		String useremail;
		Connection con= null;

		PreparedStatement ps = null;

		ResultSet rs = null;



		String driverName = "com.mysql.cj.jdbc.Driver";

		String url = "jdbc:mysql://localhost:3306/Ten_Rates";

		String user = "root";

		String dbpsw = "Mysql1shot";
		String sql = "select * from UserTable where Rmail=?";
		String mail = request.getParameter("Rmail");

		if((!(mail.equals(null) || mail.equals(""))))

				{

				try{

				Class.forName(driverName);

				con = DriverManager.getConnection(url, user, dbpsw);

				ps = con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);

				ps.setString(1, mail);
				ps.getGeneratedKeys();
				rs = ps.executeQuery();

				if(rs.next())

				{ 

				useremail = rs.getString("Rmail");
				int generatedUserId = rs.getInt("userId");
				
				if(mail.equals(useremail))

				{
					// Assuming you have generated userId and stored it in a variable named generatedUserId
					session.setAttribute("userId", generatedUserId);//we are setting current userid so that we can use it 
					HttpSession session1 = request.getSession(false); // Don't create a new session if it doesn't exist
					if (session != null && session.getAttribute("userId") != null) {
					    int userId = (Integer) session.getAttribute("userId");
					    response.sendRedirect("Homepage.html");
					}
				} 
				}
				else{
				out.println("<h2> Incorrect Email ID</h2>");
				out.println(" <h4> <a href='SignIn.html' target='_self'>Retry</a> </h4>");
				}
				rs.close();

				ps.close(); 

				}

				catch(Exception sqe)

				{

				out.println(sqe);

				} 

				}

				
		%>
				
</body>
</html>