<%-- 
    Document   : main
    Created on : 03-Dec-2023, 12:43:26 pm
    Author     : Girivardhan
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="jakarta.servlet.*, javax.servlet.http.*"%>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    session.setAttribute("username", username);
    session.setAttribute("password", password);

    String uname = (String) session.getAttribute("username");
    String pw = (String) session.getAttribute("password");
%>

<!DOCTYPE html>
<html>

<head>
    <title>HMC Home</title>
    <link rel="icon" type="image/x-icon" href="images/crown.png">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/card.css">
    <script src="./js/card.js"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <style>
/*    .developer-image {
        height: 200px;  Set the desired height for all images 
        object-fit: cover;  Maintain image aspect ratio 
    }*/
    .accordion-item {
        margin-bottom: 10px;
        border-radius: 15px; /* Increased border-radius for a rounder look */
        overflow: hidden;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    /* Custom styling for accordion header */
    .accordion-header {
        background-color: #3498db;
        color: #fff;
        border-radius: 15px; /* Rounded corners for the header */
    }

    /* Custom styling for accordion button */
    .accordion-button {
        border-radius: 15px; /* Rounded corners for the button */
        transition: background-color 0.3s ease;
    }

    /* Custom styling for accordion body */
    .accordion-body {
        background-color: #f4f4f4;
        padding: 15px;
        border-top: 1px solid #ddd;
        transition: background-color 0.3s ease;
        border-radius: 0 0 15px 15px; /* Rounded bottom corners */
    }

    /* Change background color on hover for better visual feedback */
    .accordion-button:hover {
        background-color: #2e86c1;
    }
</style>

    
</head>

<body data-bs-spy="scroll" data-bs-target=".navbar">
    
</div>

    <nav class="navbar navbar-expand-lg py-1 sticky-top bg-white shadow">
        <div class="container-fluid">
            <a class="navbar-brand" href="#home">
                <h2 class="logo animate-characters">Hall Management Center</h2>

            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#about">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact</a>
                    </li>
                </ul>

                <div class="d-flex align-items-center">
                    <a href="login.jsp" class="btn btn-brand mx-1"><i class="fas fa-sign-in-alt"></i> Login</a>
                    <a href="registration.jsp" class="btn btn-brand mx-1"><i class="fas fa-user"></i> SignUp</a>
                </div>
            </div>
        </div>
    </nav>

    <div id="home" class="carousel slide mb-5" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <div data-bs-target="#home" data-bs-slide-to="0" class="active"></div>
            <div data-bs-target="#home" data-bs-slide-to="1"></div>
            <div data-bs-target="#home" data-bs-slide-to="2"></div>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item vh-100  active">
                <img class="d-block w-100 h-100" src="images/6.jpg" alt="Firstslide">
                <div class="carousel-caption">
                    <h1 class="text-white">WELCOME TO HALL MANAGEMENT CENTER</h1>
                </div>
            </div>
            <div class="carousel-item vh-100 align-items-center justify-content-center">
                <img class="d-block w-100 h-100" src="images/1.jpg" alt="Second slide">
                <div class="carousel-caption">
                    <h1 class="text-white">WELCOME TO HALL MANAGEMENT CENTER</h1>
                </div>
            </div>
            <div class="carousel-item vh-100 align-items-center justify-content-center">
                <img class="d-block w-100 h-100" src="images/4.jpg" alt="Third slide">
                <div class="carousel-caption">
                    <h1 class="text-white">WELCOME TO HALL MANAGEMENT CENTER</h1>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#home" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#home" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
        
        
        
    </div>
    
    
   <div id="about" class="container mb-5">
            <div class="row gy-4 align-items-center">
                <div class="col-lg-6">
                    <img src="images/about.jpg" alt="About">
                </div>
                <div class="col-lg-5 ms-auto">
                    <h1>About us</h1>
                    <section id="introduction" >
                            <p><b>At the heart of our student community lies the robust and efficient Hall Management System, a comprehensive software solution designed to streamline and automate various book-keeping activities associated with our day-to-day operations. Tailored to meet the unique needs of our dynamic hostel environment, this software ensures a seamless and secure management experience for both students and administrators.</b></p>
                        </section>

                        <section id="key-features">
                            <h2 >Key Features:</h2>
                            <ul>
                                <li>Admission Module: Effortlessly manage student admissions, room allotments, and generate personalized room allotment letters.</li>
                                <li>Mess and Rent Management: Simplify the mess charges and room rent calculations, ensuring accurate financial tracking for both students and managers.</li>
                                <li>Amenities and Complaints: Facilitate student complaints through a user-friendly web interface, categorized by type, with quick response features for wardens.</li>
                                <li>Financial Management: Streamline the distribution of annual grants, expenditure tracking, and comprehensive financial reporting.</li>
                                <li>Occupancy Tracking: Real-time monitoring of room occupancy at both hall and overall levels for efficient space management.</li>
                                <li>Salary and Leave Management: Ensure hassle-free salary processing for temporary staff, along with easy leave management.</li>
                                <li>Expense Tracking: Monitor petty expenses seamlessly, maintaining financial transparency for all HMC operations.</li>
                            </ul>
                        </section>

                        <section id="join-us">
                            <h2>Join Us in Streamlining Campus Living:</h2>
                            <p>Experience a new era of hostel management with the IIT Students' Hall Management Center Software. Embrace efficiency, transparency, and security in every aspect of your stay at our esteemed institute.</p>
                            <p>Your seamless living experience starts here.</p>
                        </section>
                    </div>
            </div>
    </div>
    

<div class="container m-5">
    <h1 class="card-section-heading text-center">Our Services</h1>
    <div class="row">
        <!-- Developer Card 1 -->
        <div class="col-md-4">
            <div class="card h-100">
            
                <img src="images/p1.jpg" class="card-img-top developer-image" alt="Developer 1">
                <div class="card-body">
                    <h5 class="card-title">Student Services</h5>
                    <p class="card-text"><ul style="font-size: 22px;">
					<li class="text-left">Using our website student can complaint about any issue like mess,room,staff etc.</li>
					<li class="text-left">Student can check his/her old complaints and also status.</li>
					<li class="text-left">Student can pay dues like mess due or collage due</li>
					<li class="text-left">Student can check dues</li>
				</ul></p>
                </div>
            
            </div>
        </div>

        <!-- Developer Card 2 -->
        <div class="col-md-4">
            <div class="card h-100">
            
                <img src="images/p2.jpg" class="card-img-top developer-image" alt="Developer 2">
                <div class="card-body">
                    <h5 class="card-title">Warden Services</h5>
                    <p class="card-text"><ul  style="font-size: 22px;">
					<li>Warden can check complaints and solve complaints.</li>
					<li>Warden has full accessibility to check room details.</li>
					<li>Warden can solve student problems.</li>
                                        <li>Warden will give access to students</li>
				</ul></p>
                </div>
            
            </div>
        </div>

        

        <!-- Developer Card 4 -->
        <div class="col-md-4">
            <div class="card h-100">
            
                <img src="images/p3.png" class="card-img-top developer-image" alt="Developer 4">
                <div class="card-body">
                    <h5 class="card-title">Clerk Services</h5>
                    <p class="card-text"><ul style="font-size: 22px;">
							<li>Clerk can give leaves to the Gardener and Attendars.</li>
							<li>Clerk can add new Gardeners and Attendars</li>
							<li>Clerk can consolidate the monthly fee of the regular Staff.</li>
						</ul></p>
                </div>
           
            </div>
        </div>
        
        <!-- Developer Card 3 -->
        <div class="col-md-4 mt-5">
            <div class="card h-100">
            
                <img src="images/p4.jpg" class="card-img-top developer-image" alt="Developer 3">
                <div class="card-body">
                    <h5 class="card-title">Mess Manager Services</h5>
                    <p class="card-text"><ul style="font-size: 22px;">
						<li>Mess Manager can check number of student has paid mess fee</li>
						<li>Mess Manager can print the fee paid student.</li>
					</ul></p>
                </div>
            
            </div>
        </div>

        <!-- Developer Card 5 -->
        <div class="col-md-4 mt-5">
            <div class="card h-100">
            
                <img src="images/p5.png" class="card-img-top developer-image" alt="Developer 5">
                <div class="card-body">
                    <h5 class="card-title">Attender and Gardener Services</h5>
                    <p class="card-text"><ul style="font-size: 22px;">
							<li>Attender and Gardener can apply Leaves</li>
							<li>Attender and Gardener can request tools</li>
						</ul></p>
                </div>
            
            </div>
        </div>
    </div>
</div>
<h2 class="accordion-section-heading text-center">Hall Management System Overview</h2>
<div class="accordion accordion-flush m-3" id="accordionFlushExample">
    <div class="accordion-item">
        <h2 class="accordion-header" id="flush-headingOne">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                Student Admission
            </button>
        </h2>
        <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
            <div class="accordion-body">
                After a student takes admission, their name, permanent address, contact telephone number, and photograph are recorded. The student is then allotted a hall and a specific room number. A letter indicating the allotted room is issued to the student.
            </div>
        </div>
    </div>
    <div class="accordion-item">
        <h2 class="accordion-header" id="flush-headingTwo">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
                Mess Charges
            </button>
        </h2>
        <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
            <div class="accordion-body">
                Students incur monthly mess charges. The mess manager inputs the total charges for each student in a month on the mess account.
            </div>
        </div>
    </div>
    <div class="accordion-item">
        <h2 class="accordion-header" id="flush-headingThree">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
                Room Rent and Amenities
            </button>
        </h2>
        <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
            <div class="accordion-body">
                Each room has a fixed room rent. The halls provide certain amenities to the students, such as reading rooms, playrooms, TV rooms, etc. A fixed amount is levied on each student for amenities.
            </div>
        </div>
    </div>
    <div class="accordion-item">
        <h2 class="accordion-header" id="flush-headingFour">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFour" aria-expanded="false" aria-controls="flush-collapseFour">
                Complaints and Requests
            </button>
        </h2>
        <div id="flush-collapseFour" class="accordion-collapse collapse" aria-labelledby="flush-headingFour" data-bs-parent="#accordionFlushExample">
            <div class="accordion-body">
                Students can raise various types of complaints and repair requests using a web browser. These include requests for fused lights, non-functional water taps, non-functional water filters, room repair, etc.
            </div>
        </div>
    </div>

    <div class="accordion-item">
        <h2 class="accordion-header" id="flush-headingFive">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFive" aria-expanded="false" aria-controls="flush-collapseFive">
                Grant Distribution
            </button>
        </h2>
        <div id="flush-collapseFive" class="accordion-collapse collapse" aria-labelledby="flush-headingFive" data-bs-parent="#accordionFlushExample">
            <div class="accordion-body">
                The HMC chairman can distribute the annual grant among the different halls. Wardens of different halls can enter their expenditure details against the allocations.
            </div>
        </div>
    </div>

    <div class="accordion-item">
        <h2 class="accordion-header" id="flush-headingSix">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseSix" aria-expanded="false" aria-controls="flush-collapseSix">
                Staff Management
            </button>
        </h2>
        <div id="flush-collapseSix" class="accordion-collapse collapse" aria-labelledby="flush-headingSix" data-bs-parent="#accordionFlushExample">
            <div class="accordion-body">
                The halls employ attendants and gardeners. The Hall clerk can enter leave details for attendants or gardeners. At the end of every month, a consolidated list of salary payable to each employee is printed out.
            </div>
        </div>
    </div>
</div>



            
    <br><br>

    <footer id="contact">
    <div class="footer-top">
        <div class="container">
            <div class="row">
                <div class="col-lg-4">
                    <div class="contact-info">
                        <h4 class="text-white mb-4">CONTACT</h4>
                        <p class="mb-1"><i class="fas fa-envelope"></i> Email: hmc@iit.ac.in</p>
                        <p class="mb-1"><i class="fas fa-map-marker-alt"></i> Address: Bangalore</p>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="quick-links">
                        <h4 class="text-white mb-4">Connect With Us</h4>
                        <ul class="social-media-list" style="list-style-type: none;padding: 0;">
                            <li><a href="https://www.facebook.com/"><i class="fab fa-facebook-f"></i> Facebook</a></li>
                            <li><a href="https://www.instagram.com/"><i class="fab fa-instagram"></i> Instagram</a></li>
                            <li><a href="https://twitter.com/"><i class="fab fa-twitter"></i> Twitter</a></li>
                            <li><a href="https://www.linkedin.com/"><i class="fab fa-linkedin-in"></i> LinkedIn</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="quick-links">
                        <h4 class="text-white mb-4">Quick Links</h4>
                        <ul class="footer-links" style="list-style-type: none;padding: 0;">
                            <li><a href="#"><i class="fas fa-home"></i> Home</a></li>
                            <li><a href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a></li>
                            <li><a href="#about"><i class="fas fa-info-circle"></i> About Us</a></li>
                            <li><a href="#contact"><i class="fas fa-envelope"></i> Contact Us</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <p class="mb-0 text-white">Copyrights © 2023 HMC, All rights reserved.</p>
                </div>
                <div class="col-lg-6">
                    <p class="mb-0 text-white">Designed By Team: ASTRAL ADVENTURERS</p>
                </div>
            </div>
        </div>
    </div>
</footer>

<script>
    function toggleAccordion(sectionId) {
        var section = document.getElementById(sectionId);
        section.style.display = (section.style.display === 'block') ? 'none' : 'block';
    }
</script>

    
</body>

</html>

