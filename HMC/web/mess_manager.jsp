<%-- 
    Document   : process_complaint
    Created on : 06-Dec-2023, 6:01:51 pm
    Author     : Girivardhan
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>MESS MANAGER</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="student/css/style.css">
    <style type="text/css">
        .tab {
            display: none;
        }

        .tab.active {
            display: block;
        }
    </style>
</head>
<body>
<div class="wrapper d-flex align-items-stretch">
    <nav id="sidebar" style="background: linear-gradient(to left, #2c3e50, #3498db);">
        <div class="custom-menu">
            <button type="button" id="sidebarCollapse" class="btn btn-primary"><i class="fa fa-bars"></i> </button>
        </div>
        <div class="p-4 pt-5">
            <h1><a href="index.jsp" class="logo">HMC</a></h1>
            <ul class="list-unstyled components mb-5">
                <li class="active">
                    <span onclick="showTab(0)">Home</span>
                </li>
                <li>
                    <span onclick="showTab(1)">Mess Fee Paid Students</span>
                </li>
                <li>
                    <span onclick="showTab(2)">Mess Fee Dues Students</span>
                </li>
                <li>
                    <span onclick="showTab(3)">Profile</span>
                </li>
                <li>
                    <a href="logout.jsp">Logout</a>
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
            <div id="print">
                <h3 align="center">MESS FEE PAID STUDENTS</h3>
                <table class="table table-borderd" style="width: 50vw;" align="center">
                    <thead>
                    <tr class="table-primary">
                        <th scope="row">SLNO</th>
                        <th scope="row">NAME</th>
                        <th scope="row">AMOUNT</th>
                        <th scope="row">DATE</th>
                    </tr>
                    </thead>
                    <tbody class="table-striped">
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");
                            String sql = "SELECT * FROM mess_fee";
                            stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery(sql);
                            while (rs.next()) {
                    %>
                    <tr class='table-white'>
                        <td><%= rs.getInt("ID") %></td>
                        <td><%= rs.getString("NAME") %></td>
                        <td><%= rs.getString("AMOUNT") %></td>
                        <td><%= rs.getString("DATE") %></td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>
            <table>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td align='right'><a class='btn btn-white' style='background:#6495ED;' "color: white;" href="#"
                                         onclick="printing_table()"> Print </a></td>
                </tr>
            </table>
        </div>
        <div class="tab">
            <h3 align="center">MESS DUES STUDENTS</h3>
            <table class="table table-border table-hover " style="width: 50vw;" align="center">
                <thead class="table-primary">
                <th>SLNO</th>
                <th>NAME</th>
                <th>EMAIL ID</th>
                <th>CONTACT</th>
                <th>DUE BALANCE</th>
                </thead>
                <tbody>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");
                        String q = "SELECT * FROM student WHERE MESS_DUES>0";
                        stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(q);
                        int i = 1;
                        while (rs.next()) {
                %>
                <tr class='table-light'>
                    <td><%= i++ %></td>
                    <td><%= rs.getString("NAME") %></td>
                    <td><%= rs.getString("EMAIL_ID") %></td>
                    <td><%= rs.getString("CONTACT") %></td>
                    <td><%= rs.getString("MESS_DUES") %></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
                </tbody>
            </table>
        </div>
        <div class="tab">
            <h1>Profile</h1>
            <table class="table table-borderd table-hover" style="width: 50vw;">
                <tbody>
                <tr>
                    <th class="table-primary">Name</th><%= "<td>" + session.getAttribute("username") + "</td>" %>
                </tr>
                <tr>
                    <th class="table-primary">Email Id</th><%= "<td>" + session.getAttribute("email") + "</td>" %>
                </tr>
                <tr>
                    <th class="table-primary">Contact</th><%= "<td>" + session.getAttribute("contact") + "</td>" %>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script type="text/javascript">
    var active = 0;
    var tabs = document.getElementsByClassName("tab");

    function showTab(tab) {
        if (tab == active) {
            return;
        }

        for (var i = 0; i < tabs.length; i++) {
            tabs[i].classList.remove("active");
        }

        tabs[tab].classList.add("active");
        active = tab;
    }
</script>
<script src="student/css/js/jquery.min.js"></script>
<script src="student/css/js/popper.js"></script>
<script src="student/css/js/bootstrap.min.js"></script>
<script src="student/css/js/main.js"></script>
<script type="text/javascript">
    function printing_table() {
        var content = document.getElementById("print").innerHTML;
        var main_body = document.body.innerHTML;
        document.body.innerHTML = content;
        window.print();
        document.body.innerHTML = main_body;
    }
</script>
</body>
</html>
