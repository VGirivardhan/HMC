<%-- 
    Document   : student
    Created on : 03-Dec-2023, 3:43:30 pm
    Author     : Girivardhan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <title>STUDENT</title>
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
    .animate-characters {
    background-image: linear-gradient(-225deg, yellow 0%, purple 29%, #ff1361 67%, #DD6E0F 100%);
    background-size: auto auto;
    background-clip: border-box;
    background-size: 200% auto;
    color: #fff;
    background-clip: text;
    text-fill-color: transparent;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    animation: textclip 15s linear infinite;
    display: inline-block;
    }

    @keyframes textclip {
        0% {
            background-position: 200% 0;
        }

        100% {
            background-position: -200% 0;
        }
    }

    @media (max-width: 768px) {
        .content {
            padding: 10px;
        }
    }
</style>
<body>
    <%
    Boolean paymentSuccess = (Boolean) session.getAttribute("paymentSuccess");
    String paymentMessage = (String) session.getAttribute("paymentMessage");

    if (paymentSuccess != null && paymentMessage != null) {
%>
    <script>
        alert("<%= paymentMessage %>");
    </script>
<%
    }
    session.removeAttribute("paymentSuccess");
    session.removeAttribute("paymentMessage");
%>
<div class="wrapper d-flex align-items-stretch">
    <nav id="sidebar" style="background: linear-gradient(to left, #1a2980, #26d0ce);">
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
                    <span onclick="showTab(1)">Complaint</span>
                </li>
                <li>
                    <span onclick="showTab(2)">Pending Dues</span>
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

        <div class="tab animate-characters">
            <!-- -----------------WELCOME PAGE ----------------------->
            <%
                out.println("<h1> WELCOME " + session.getAttribute("username") + "</h1>");
            %>
        </div>
        <div class="tab">

            <!----------------------------- Student Complaints  -----------------------  -->
            <div>
                <h2>Old complaints</h2>
                <div style="height: 30vh; overflow: auto;">
                    <table class="table table-borderd table-hover ">
                        <thead class="tableFixHead">
                        <tr class="table-primary">
                            <th scope="row">COMPLAINT TYPE</th>
                            <th scope="row">COMPLAINT DESCRIPTION</th>
                            <th scope="row">STATUS</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            Connection conn = null;
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");

                                String sql = "SELECT * FROM complaint WHERE EMAIL_ID=?";
                                PreparedStatement statement = conn.prepareStatement(sql);
                                statement.setString(1, session.getAttribute("email").toString());

                                ResultSet result = statement.executeQuery();

                                while (result.next()) {
                                    out.println("<tr class='table-primary'><td>" + result.getString("COM_TYPE") + "</td><td>" + result.getString("COM_DESCP") + "</td><td id='status_id'>" + (result.getBoolean("COM_STATUS") ? "Solved" : "Pending") + "</td></tr>");
                                }
                                conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- -----------Complaint Form-------------->
            <div class="form-row col-auto">
                <form action="complaint.jsp" method="post">
                    <fieldset>
                        <legend>COMPLAINT BOX</legend>
                        <select class="form-control border border-dark" name="complaint_type"
                                style="width: 30vw;">
                            <option>SELECT TYPE OF COMPLAINT</option>
                            <option>MESS</option>
                            <option>ROOM</option>
                            <option>WATER</option>
                            <option>STAFF</option>
                            <option>OTHER</option>
                        </select>
                        <br/>
                        <label style="color: #000;">DESCRIBE YOUR COMPLAINT</label>
                        <br/>
                        <textarea name="comment" class="form-control" rows=5 cols="50"
                                  style="border:solid 1px black; resize: none; width: 30vw;"></textarea>
                        <br/>
                        <input type="submit" name="submit" value="Submit" class="btn btn-primary">
                    </fieldset>
                </form>
            </div>
        </div>
        <div class="tab">
            <!--------------------Pending Dues------------------->
            <h2>PENDING DUES</h2>
            <form action="PaymentServlet" method="post">
                <table class="table table-borderd table-hover">
                    <tbody>
                    <%
//                        Connection conn = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");

                            String sql = "SELECT * FROM student WHERE EMAIL_ID=?";
                            PreparedStatement statement = conn.prepareStatement(sql);
                            statement.setString(1, session.getAttribute("email").toString());

                            ResultSet result = statement.executeQuery();

                            while (result.next()) {
                                int sum = result.getInt("MESS_DUES") + result.getInt("HALL_DUES");
                                if (sum > 0) {
                                    out.println("<tr class='table-warning'><th>MESS DUE</th><th>HALL DUE</th><th>TOTAL</th><th>PAY</th></tr>");
                                    out.println("<tr class='table-primary'><td>" + result.getInt("MESS_DUES") + "</td><td>" + result.getInt("HALL_DUES") + "</td><td>" + sum + "</td><td> <input type='submit' name='pay' value='Pay' class='btn btn-dark'> </td></tr>");
                                } else {
                                    out.println("<h2 align='center'>No Dues</h2>");
                                }
                            }
                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                    </tbody>
                </table>
            </form>
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
                    <th class="table-primary">Hall</th><%
                        out.println("<td>" + session.getAttribute("hall") + "</td>");
                    %>
                </tr>
                <tr>
                    <th class="table-primary">Room Number</th><%
                        out.println("<td>" + session.getAttribute("room") + "</td>");
                    %>
                </tr>
                <tr>
                    <th class="table-primary">Permanent Adress</th><%
                        out.println("<td>" + session.getAttribute("address") + "</td>");
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
        tabs[tab].style.display = "block";
        tabs[active].style.display = "none";
        active = tab;
    }

</script>
<script src="student/css/js/jquery.min.js"></script>
<script src="student/css/js/popper.js"></script>
<script src="student/css/js/bootstrap.min.js"></script>
<script src="student/css/js/main.js"></script>
</body>
</html>

