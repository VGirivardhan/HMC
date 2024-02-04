<%@ page import="java.io.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);
    if (userSession != null) {
        userSession.invalidate(); // Invalidate the session
    }
    response.sendRedirect("login.jsp"); // Redirect to the login page
%>
