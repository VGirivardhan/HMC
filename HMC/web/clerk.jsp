<%-- 
    Document   : process_complaint
    Created on : 06-Dec-2023, 7:01:51 pm
    Author     : Girivardhan
--%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.setMaxInactiveInterval(600);

    if (session.getAttribute("register1") != null && (boolean) session.getAttribute("register1")) {
        out.println("<script>alert('" + session.getAttribute("register") + "');</script>");
        session.setAttribute("register1", false);
    }
    if (session.getAttribute("user_type") == null) {
        response.sendRedirect("login.jsp");
    }
    if (!"clerk".equals(session.getAttribute("user_type"))) {
        response.sendRedirect(session.getAttribute("user_type") + ".jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Clerk</title>
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
                        <span onclick="showTab(1)">Register New Staff</span>
                    </li>
                    <li>
                        <span onclick="showTab(2)">Remove Staff</span>
                    </li>
                    <li>
                        <span onclick="showTab(3)">Staff Leave Form</span>
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
                <!-- Calculate Staff Feeee -->
                <div style="width: 45vw;" id="print">
                    <h3>Staff Salary of This Month</h3>
                    <table class="table table-striped">
                        <thead class="table-primary">
                            <td>TYPE</td>
                            <td>NAME</td>
                            <td>TOTAL WORKING DAYS</td>
                            <td>TOTAL LEAVES</td>
                            <td>SALARY</td>
                        </thead>
                        <tbody>
                            <%!
                                // Method to calculate working days
                                int calculateWorkingDays(String joiningDate, int absent) {
                                    String[] val1 = joiningDate.split("-");
                                    int workingdays;
                                    if (Integer.parseInt(val1[1]) == Integer.parseInt(val1[0]) && Integer.parseInt(val1[0]) == Integer.parseInt(val1[2])) {
                                        workingdays = Integer.parseInt(val1[2]) - absent;
                                    } else {
                                        workingdays = Integer.parseInt(val1[2]);
                                    }
                                    return workingdays;
                                }
                            %>
                            <%!
                                // Method to calculate salary
                                int calculateSalary(String type, int workingDays) {
                                    if ("Gardener".equals(type)) {
                                        return workingDays * 1000;
                                    } else {
                                        return workingDays * 1500;
                                    }
                                }
                            %>
                            <%
                                List<String> array = new ArrayList<>();
                                int i = 0;
                                Connection conn = null;
                                Statement stmt = null;
                                ResultSet result = null;

                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");
                                    stmt = conn.createStatement();
                                    String sql = "SELECT * FROM attendant_and_gardener";
                                    result = stmt.executeQuery(sql);
                                    while (result.next()) {
                                        array.add(result.getString("NAME") + "_" + result.getString("EMAIL_ID") + "_" + result.getString("TYPE") + "_" + result.getString("JOINING_DATE"));
                                        i = i + 1;
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    try {
                                        if (stmt != null) stmt.close();
                                        if (result != null) result.close();
                                        if (conn != null) conn.close();
                                    } catch (Exception se) {
                                        se.printStackTrace();
                                    }
                                }

                                for (String value : array) {
                                    String[] val = value.split("_");
                                    String[] val1 = val[3].split("-");
                                    int absent = 0;
                                    int workingdays = calculateWorkingDays(val[3], absent);
                                    int salary = calculateSalary(val[2], workingdays);
                            %>
                            <tr>
                                <td><%= val[2] %></td>
                                <td><%= val[0] %></td>
                                <td><%= workingdays %></td>
                                <td><%= absent %></td>
                                <td><%= salary %></td>
                            </tr>
                            <%
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
                        <td></td>
                        <td><a class="btn btn-primary" onclick="printing_table()" style="color: white;">Print</a></td>
                    </tr>
                </table>
            </div>
            <div class="tab">
                <!-- Register Temporary staff -->
                <div class="form-group" style="width: 35vw;">
                    <form action="StaffRegistrationServlet" method="post">
                        <fieldset>
                            <h3>Staff Temporary Registration</h3>
                            <div class="form-group">
                                <p>Select Type:</p>
                                <div class="form-group form-check-inline">
                                    <input type="radio" id="gardener" name="staff_type" value="Gardener" checked class="form-check-input">
                                    <label for="gardener" class="form-check-label" for>Gardener</label>
                                </div>
                                <div class="form-group form-check-inline">
                                    <input type="radio" id="attendant" name="staff_type" value="Attendant" class="form-check-input">
                                    <label for="Attendant" class="form-check-label" for>Attendant</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <input type="name" name="staff_name" required placeholder="Name" class="form-control" style="border:1px solid black; font-size: 15px;">
                            </div>
                            <div class="form-group">
                                <input type="email" name="staff_email" required placeholder="Email Id" class="form-control" style="border:1px solid black; font-size: 15px;">
                            </div>
                            <div class="form-group">
                                <input type="number" name="contact" required placeholder="Contact Number" maxlength="10" class="form-control" style="border:1px solid black; -moz-appearance: textfield; font-size: 15px;">
                            </div>
                            <div class="form-group">
                                <input type="submit" name="submit" Value="Register" class="btn btn-primary">
                            </div>
                        </fieldset>
                    </form>
                </div>
            </div>
            <div class="tab">
                <!-- Remove Temporary Staff -->
                <div style="width: 30vw;">
                    <h3>Remove Temporary Staff</h3>
                    <table class="table table-striped table-hover table-md">
                        <thead class="table-primary">
                            <td>TYPE</td>
                            <td>NAME</td>
                            <td>EMAIL</td>
                            <td>CONTACT</td>
                            <td></td>
                        </thead>
                        <tbody>
                            <%
                                Connection connRemove = null;
                                Statement stmtRemove = null;
                                ResultSet resultRemove = null;

                                try {
                                    connRemove = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");
                                    stmtRemove = connRemove.createStatement();
                                    String sqlRemove = "SELECT * FROM attendant_and_gardener ORDER BY TYPE ASC";
                                    resultRemove = stmtRemove.executeQuery(sqlRemove);

                                    while (resultRemove.next()) {
                                        String email = resultRemove.getString("EMAIL_ID");
                                        String type = resultRemove.getString("TYPE");
                            %>
                            <tr>
                                <td><%= type %></td>
                                <td><%= resultRemove.getString("NAME") %></td>
                                <td><%= email %></td>
                                <td><%= resultRemove.getString("CONTACT") %></td>
                                <td><a href='StaffDeletionServlet?email=<%= email %>&type=<%= type %>' class='btn btn-primary'>DELETE</a></td>
                            </tr>
                            <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    try {
                                        if (stmtRemove != null) stmtRemove.close();
                                        if (resultRemove != null) resultRemove.close();
                                        if (connRemove != null) connRemove.close();
                                    } catch (Exception se) {
                                        se.printStackTrace();
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="tab">
                <!-- Staff Leaves Status -->
                <div>
                    <h2>Leave Requests and Responded</h2>
                    <div style="height: auto; overflow: auto;">
                        <table class="table table-borderd table-hover ">
                            <thead class="tableFixHead">
                                <tr class="table-primary">
                                    <th scope="row">TYPE</th>
                                    <th scope="row">NAME</th>
                                    <th scope="row">NO. OF DAYS</th>
                                    <th scope="row">FROM DATE</th>
                                    <th scope="row">STATUS</th>
                                    <th> </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Connection connLeaves = null;
                                    Statement stmtLeaves = null;
                                    ResultSet resultLeaves = null;

                                    try {
                                        connLeaves = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");
                                        stmtLeaves = connLeaves.createStatement();
                                        String sqlLeaves = "SELECT * FROM staff_leaves";
                                        resultLeaves = stmtLeaves.executeQuery(sqlLeaves);

                                        while (resultLeaves.next()) {
                                %>
                                <tr class="table-white">
                                    <td><%= resultLeaves.getString("TYPE") %></td>
                                    <td><%= resultLeaves.getString("NAME") %></td>
                                    <td><%= resultLeaves.getString("NO_OF_DAYS") %></td>
                                    <td><%= resultLeaves.getString("DATES") %></td>
                                    <td id='status_id'><%= resultLeaves.getBoolean("STATUS") ? "Solved" : "Pending" %></td>
                                    <td><a href='StaffLeaveStatusServlet?key=<%= resultLeaves.getString("ID") %>' class='btn btn-link'><%= resultLeaves.getBoolean("STATUS") ? "Approved" : "Pending....." %></a></td>
                                </tr>
                                <%
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        try {
                                            if (stmtLeaves != null) stmtLeaves.close();
                                            if (resultLeaves != null) resultLeaves.close();
                                            if (connLeaves != null) connLeaves.close();
                                        } catch (Exception se) {
                                            se.printStackTrace();
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <script type="text/javascript">
                        var active = 0,
                            tabs = document.getElementsByClassName("tab");

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
                    <script type="text/javascript">
                        function printing_table() {
                            var content = document.getElementById("print").innerHTML;
                            var main_body = document.body.innerHTML;
                            document.body.innerHTML = content;
                            window.print();
                            document.body.innerHTML = main_body;
                        }
                    </script>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
