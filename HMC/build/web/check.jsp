<%-- 
    Document   : process_complaint
    Created on : 06-Dec-2023, 6:01:51 pm
    Author     : Girivardhan
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>

<%
    if (request.getParameter("submit") != null) {
        // Forward the request to the LoginServlet
        request.getRequestDispatcher("LoginServlet").forward(request, response);
    }
%>
