<%-- 
    Document   : process_complaint
    Created on : 06-Dec-2023, 6:01:51 pm
    Author     : Girivardhan
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Attendant & Gardener</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="student/css/style.css">
</head>
<style type="text/css">
    .tab{
        display: none;
    }
    .tab:first-child{
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
                    <span onclick="showTab(1)">Leave Form</span>
                </li>
                <li>
                    <span onclick="showTab(2)">Requesting tools</span>
                </li>
                <li>
                    <a href="logout.jsp" > Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5 pt-5">
        <div class="tab">
            <!--=====================================HOME=================================-->
            <h3>Welcome to Hall Management Service</h3>
        </div>
        <div class="tab">
            <!--=====================================LEAVE FORM=================================-->
            <div style="width: 30vw;">
                <h3>Staff Leave Form</h3>
                <form action="LeaveFormServlet" method="post">
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
                        <p>No Of Days:</p>
                        <div class="form-group form-check-inline">
                            <input type="radio" name="no_of_days" checked class="form-check-input" value="1">
                            <label for="1" class="form-check-label" for>1</label>
                        </div>
                        <div class="form-group form-check-inline">
                            <input type="radio" name="no_of_days" class="form-check-input" value="2">
                            <label for="2" class="form-check-label" for>2</label>
                        </div>
                        <div class="form-group form-check-inline">
                            <input type="radio" name="no_of_days" class="form-check-input" value="3">
                            <label for="3" class="form-check-label" for>3</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <p>Reason:</p>
                        <textarea name="reason" rows="4" cols="40" style="resize: none; border:1px solid black; border-radius: 10px;"></textarea>
                    </div>

                    <div class="form-group">
                        <input type="submit" name="submit" value="Submit" class="btn btn-primary">
                    </div>
                </form>
            </div>

            <script>
                <% 
                    Boolean leaveSubmissionResult = (Boolean)session.getAttribute("register1");
                    String message = (String)session.getAttribute("register");
                    if (leaveSubmissionResult != null) { 
                        if (leaveSubmissionResult) { 
                %>
                            alert("<%= message %>");
                <%
                        } else { 
                %>
                            alert("<%= message %>");
                <%
                        }
                    }
                %>
            </script>

        </div>

        <div class="tab">
            <!--=====================================Requesting tools=================================-->
            <h3>Requesting Tools to Use</h3>
            <div style="width: 30vw;">
                <form action="ToolsServlet" method="POST">
                    <!-- ... Your existing tools requested content ... -->

                    <div class="form-group">
                        <input type="submit" name="submit" value="Submit" class="btn btn-primary">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var active=0,tabs=document.getElementsByClassName("tab");
    function showTab(tab){
        if(tab==active){
            return;
        }
        tabs[tab].style.display="block";
        tabs[active].style.display="none";
        active=tab;
    }
</script>

<script src="student/css/js/jquery.min.js"></script>
<script src="student/css/js/popper.js"></script>
<script src="student/css/js/bootstrap.min.js"></script>
<script src="student/css/js/main.js"></script>
</body>
</html>
