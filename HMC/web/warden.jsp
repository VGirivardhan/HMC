<%-- 
    Document   : process_complaint
    Created on : 06-Dec-2023, 6:01:51 pm
    Author     : Girivardhan
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>WARDEN</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="student/css/style.css">
</head>
<style type="text/css">
    .tab {
        display: none;
    }

    .tab:first-child {
        display: block;
    }
</style>

<body>
<div class="wrapper d-flex align-items-stretch">
    <nav id="sidebar" style="background: linear-gradient(to left, #000046, #1cb5e0);">
        <div class="custom-menu">
            <button type="button" id="sidebarCollapse" class="btn btn-primary"><i class="fa fa-bars"></i> </button>
        </div>
        <div class="p-4 pt-5">
            <h1><a href="index.jsp" class="logo">HMC</a></h1>
            <ul class="list-unstyled components mb-5">
                <li class="active">
                    <span onclick="showTab(0)">Home</span>
                <li>
                    <span onclick="showTab(1)">View Complaint</span>
                </li>
                <li>
                    <span onclick="showTab(2)">Hall & Room Details</span>
                </li>
                <li>
                    <span onclick="showTab(3)">Tools Status</span>
                </li>
                <li>
                    <span onclick="showTab(4)">Profile</span>
                </li>
                <li>
                    <a href="logout.jsp"> Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5 pt-5">

        <div class="tab">
            <h3>Welcome to Hall Management Center</h3>
        </div>
        <div class="tab">
            <h3>Complaints</h3>
            <!-- ------------------View Complaints---------------------------->
            <table class="table table-border table-hover">
                <thead class="table-primary">
                <th>SLNO</th>
                <th>COMPLAINNER</th>
                <th>COMPLAINT TYPE</th>
                <th>COMPLAINT DESCRIPTION</th>
                <th>STATUS</th>
                <th></th>
                </thead>
                <%
                    Connection conn = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");

                        String q = "SELECT * FROM warden WHERE EMAIL_ID=?";
                        PreparedStatement pstmt = conn.prepareStatement(q);
                        pstmt.setString(1, session.getAttribute("email").toString());
                        ResultSet result = pstmt.executeQuery();
                        if (result.next()) {
                            String hall = result.getString("HALL");
                            String sql = "SELECT * FROM complaint WHERE HALL=?";
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setString(1, hall);
                            ResultSet rs = pstmt.executeQuery();
                            while (rs.next()) {
                                out.println("<tr class='table-striped'><td>" + rs.getString("ID") + "</td><td>" +
                                        rs.getString("NAME") + "</td><td>" + rs.getString("COM_TYPE") + "</td><td>" +
                                        rs.getString("COM_DESCP") + "</td><td>" +
                                        (rs.getBoolean("COM_STATUS") ? "Solved" : "Pending....") + "</td><td><a href='WardenComplaintServlet?key=" +
                                        rs.getString("ID") + "' class='btn btn-link'>" +
                                        (rs.getBoolean("COM_STATUS") ? "" : "Click to Solve") + "</a></td></tr>");
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (conn != null) {
                            try {
                                conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                %>
            </table>
        </div>
        <div class="tab">
            <%
                out.println("<h2 align='center'>Hall   " + session.getAttribute("hall") + "</h2>");
            %>
            <table class="table table-border table-hover">
                <thead>
                <th class="table-primary">SLNO</th>
                <th class="table-primary">ROOM NUMBER</th>
                <th class="table-primary">NAME</th>
                <th class="table-primary">ROOM SHARED</th>
                <th class="table-primary">CONTACT</th>
                </thead>
                <%
                    conn = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");

                        String sql = "SELECT * FROM student WHERE HALL=? ORDER BY ROOM ASC";
                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, session.getAttribute("hall").toString());
                        ResultSet rs = pstmt.executeQuery();
                        if (rs.next()) {
                            int i = 1;
                            do {
                                out.println("<tr class='table-light'><td>" + i + "</td><td>" + rs.getString("ROOM") + "</td><td>" +
                                        rs.getString("NAME") + "</td><td>" + (rs.getBoolean("TWIN_SHARE") ? "Yes" : "No") + "</td><td>" +
                                        rs.getString("CONTACT") + "</td></tr>");
                                i++;
                            } while (rs.next());
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (conn != null) {
                            try {
                                conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                %>
            </table>
        </div>
        <div class="tab">
            <!--===============================Requesting tools-->
            <div style="width: 30vw;">
                <h3>Tools Requested</h3>
                <table class="table table-striped table-hover table-md">
                    <thead class="table-primary">
                    <td>NAME</td>
                    <td>TOOLS</td>
                    <td>STATUS</td>
                    </thead>
                    <%
                        conn = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");

                            String sql = "SELECT * FROM tools";
                            PreparedStatement pstmt = conn.prepareStatement(sql);
                            ResultSet rs = pstmt.executeQuery();
                            while (rs.next()) {
                                out.println("<tr><td>" + rs.getString("NAME") + "</td><td>" +
                                        rs.getString("TOOL") + "</td><td><a href='ToolStatusServlet?key=" +
                                        rs.getString("ID") + "' class='btn btn-link'>" +
                                        (rs.getBoolean("STATUS") ? "Approved" : "Pending") + "</a></td></tr>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (conn != null) {
                                try {
                                    conn.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    %>
                </table>
            </div>
        </div>
        <div class="tab">
            <h1>Profile</h1>
            <table class="table table-borderd table-hover" style="width: 50vw;">
                <tbody>
                <tr>
                    <th class="table-primary">Name</th><%
                        out.println("<td>" + session.getAttribute("username") + "</td>");
                    %>
                </tr>
                <tr>
                    <th class="table-primary">Email Id</th><%
                        out.println("<td>" + session.getAttribute("email") + "</td>");
                    %>
                </tr>
                <tr>
                    <th class="table-primary">Contact</th><%
                        out.println("<td>" + session.getAttribute("contact") + "</td>");
                    %>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script type="text/javascript">
    var active = 0, tabs = document.getElementsByClassName("tab");

    function showTab(tab) {
        if (tab == active) {
            return;
        }
        for (var i = 0; i < tabs.length; i++) {
            tabs[i].style.display = "none";
        }
        tabs[tab].style.display = "block";
        active = tab;
    }
</script>

<%
    Boolean key = (Boolean)session.getAttribute("key");
    String comSolvedMessage = (String)session.getAttribute("com_solved");
%>

<script>
    <% if (key != null && key) { %>
        alert("<%= comSolvedMessage %>");
    <% } else if (key != null && !key) { %>
        alert("<%= comSolvedMessage %>");
    <% } %>
</script>

<script src="student/css/js/jquery.min.js"></script>
<script src="student/css/js/popper.js"></script>
<script src="student/css/js/bootstrap.min.js"></script>
<script src="student/css/js/main.js"></script>
</body>
</html>
