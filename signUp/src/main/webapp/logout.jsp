<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout Page</title>
     <link rel ="stylesheet" href ="style.css">
</head>
<body>
    
    
    <%-- Checking if the session exists and invalidating it --%>
    <% 
    if (request.getSession(false) != null) {
        request.getSession().invalidate();
    %>
        <h2 class="logoutmessage">You have been successfully logged out.</h2>
    <%
    } else {
    %>
        <h2 class="logoutmessage" >You are not currently logged in.</h2>
    <%
    }
    %>
    
    <h2><a  href="SignIn.html">Login Again</a></h2>
</body>
</html>
