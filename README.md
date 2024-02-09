<!--
Document   : main
Created on : 03-Dec-2023, 12:43:26 pm
Author     : Girivardhan
-->

# HMC Home

[![icon](images/crown.png)](#)

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.1/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>


<style>
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
                <img class="d-block w-100 h-100" src="HMC/web/images/6.jpg" alt="Firstslide">
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
    <!-- About section content -->
</div>

<div class="container m-5">
    <!-- Services section content -->
</div>

<h2 class="accordion-section-heading text-center">Hall Management System Overview</h2>
<div class="accordion accordion-flush m-3" id="accordionFlushExample">
    <!-- Accordion content -->
</div>

<footer id="contact">
    <!-- Footer content -->
</footer>

<script>
    // JavaScript scripts
</script>
