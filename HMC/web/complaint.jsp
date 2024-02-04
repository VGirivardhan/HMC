<%-- 
    Document   : process_complaint
    Created on : 06-Dec-2023, 6:01:51 pm
    Author     : Girivardhan
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String type = request.getParameter("complaint_type");
        String content = request.getParameter("comment");
        String name = session.getAttribute("username").toString();
        String email = session.getAttribute("email").toString();
        String hall = session.getAttribute("hall").toString();
        String room = session.getAttribute("room").toString();
        int a = 0;

        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");

            String sql = "INSERT INTO complaint(NAME, EMAIL_ID, HALL, ROOM, COM_TYPE, COM_DESCP, COM_STATUS) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, hall);
            statement.setString(4, room);
            statement.setString(5, type);
            statement.setString(6, content);
            statement.setInt(7, a);

            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {
%>
                <script>
                    alert("Complaint registered successfully!");
                    window.location.href = "<%= session.getAttribute("user_type") + ".jsp" %>";
                </script>
<%
            } else {
%>
                <script>
                    alert("Error: Unable to insert data. Your complaint was not registered.");
                    window.location.href = "<%= session.getAttribute("user_type") + ".jsp" %>";
                </script>
<%
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
%>
            <script>
                alert("Error: An unexpected error occurred. Your complaint was not registered.");
                window.location.href = "<%= session.getAttribute("user_type") + ".jsp" %>";
            </script>
<%
        }
    }
%>
