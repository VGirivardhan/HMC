<%-- 
    Document   : process_complaint
    Created on : 06-Dec-2023, 6:01:51 pm
    Author     : Girivardhan
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session = request.getSession();
    if (session.getAttribute("payment") != null && (boolean) session.getAttribute("payment")) {
        response.sendRedirect("student.jsp");
    }

    if (session.getAttribute("login") != null && (boolean) session.getAttribute("login")) {
        response.sendRedirect(session.getAttribute("user_type") + ".jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Payment</title>
</head>
<body>
    <form action="PaymentServlet" method="post">
        <!-- Add your form fields here -->
        <input type="submit" name="pay" value="Pay">
    </form>
</body>
</html>
