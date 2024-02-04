<%-- 
    Document   : process_complaint
    Created on : 06-Dec-2023, 6:01:51 pm
    Author     : Girivardhan
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Form</title>
    <script src="registration_src/jquery.min.js"></script>
    <script src="registration_src/bootstrap.min.js"></script>
    <link rel="stylesheet" href="registration_src/bootstrap.min.css">
    <script src="registration_src/gallery.js"></script>
    <link href="https://use.fontawesome.com/releases/v5.0.7/css/all.css" rel="stylesheet">
    <style>
        body {
            background-image: url('images/7.jpg');
            background-size: cover;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: background-image 0.5s ease;
            opacity: 0;
            animation: fadeIn ease-in-out 0.5s forwards;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .main {
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.5);
            max-width: 500px;
        }

        .signup-content {
            text-align: center;
        }

        .form-title {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .custom-select, .form-input {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-input:focus, .custom-select:focus {
            border-color: #007bff;
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.5);
        }

        .extra {
            margin-top: 10px;
        }

        .btn-brand {
            color: #ffffff;
            font-weight: 500;
            border-color: #f58d17;
            background-color: #f58d17;
            transition: all 0.3s ease;
            width: 100%;
            border-radius: 0.25rem;
        }

        .btn-brand:hover {
            border-color: #d37810;
            background-color: #d37810;
            color: #ffffff;
            transform: scale(1.1);
        }

/*        .loginhere {
            margin-top: 20px;
            transition: opacity 0.3s ease;
        }

        .loginhere-link {
            color: #007bff;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .loginhere-link:hover {
            color: #0056b3;
        }*/

        .toggle-password {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            cursor: pointer;
        }
        /* Add this to your existing CSS */
        .form-input,
        .custom-select {
            transition: transform 0.3s ease, box-shadow 0.3s ease, border-color 0.3s ease;
        }

        .form-input:hover,
        .custom-select:hover {
            transform: scale(1.05);
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.5);
            border-color: #007bff;
        }
        .loginhere-link {
        position: relative;
        color: #000000; /* Black text color */
        text-decoration: none;
        transition: color 0.3s ease;
        font-weight: bold;
        }

        .loginhere-link:hover {
            color: #000000; /* Hover text color - Orange */
        }

        .loginhere-link::before {
            content: '';
            position: absolute;
            width: 100%;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: #ffa500; /* Orange underline color */
            visibility: hidden;
            transform: scaleX(0);
            transition: all 0.3s ease-in-out;
        }

        .loginhere-link:hover::before {
            visibility: visible;
            transform: scaleX(1);
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
</head>
<body>

    <div class="main">

        <section class="signup">
            <div class="container">
                <div class="signup-content">
                    <form method="POST" id="signup-form" class="signup-form" action="RegisterServlet">
                        <h1 class="form-title animate-characters">Create account</h1>
                        <select class="custom-select custom-select-lg mb-3" id="categeory" name="user_type">
                            <option value="student">Student</option>
                            <option value="mess_manager">Mess Manager</option>
                            <option value="warden">Warden</option>
                            <option value="clerk">Clerk</option>
                            <option value="attendant_and_gardener">Attendents & Gardenres</option>
                        </select>

                        <div class="form-group">
                            <input type="text" class="form-input" name="name" id="name" placeholder="Your Name" required/>
                        </div>
                        <div class="form-group">
                            <input type="email" class="form-input" name="email" id="email" placeholder="Your Email" required />
                        </div>

                        <div class="row row-space extra ">
                            <div class="col- ml-5 mr-5">
                                <label class="label">Gender</label>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="customRadioInline12" name="customRadioInline12" class="custom-control-input" value="1">
                                    <label class="custom-control-label" for="customRadioInline12">Male</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="customRadioInline23" name="customRadioInline12" class="custom-control-input" value="0">
                                    <label class="custom-control-label" for="customRadioInline23">Female</label>
                                </div>
                            </div>
                            <div class="col- mr-sm-5">
                                <label class="label">Room Sharing</label>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="customRadioInline1" name="customRadioInline1" class="custom-control-input" value="1">
                                    <label class="custom-control-label" for="customRadioInline1">Yes</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="customRadioInline2" name="customRadioInline1" class="custom-control-input" value="0">
                                    <label class="custom-control-label" for="customRadioInline2">No</label>
                                </div>
                            </div>
                            <div class="col-mr-sm-5">
                                <label class="label">Extra Amenities</label>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="customRadioInline11" name="customRadioInline11" class="custom-control-input" value="1">
                                    <label class="custom-control-label" for="customRadioInline11">Yes</label>
                                </div>
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="customRadioInline22" name="customRadioInline11" class="custom-control-input" value="0">
                                    <label class="custom-control-label" for="customRadioInline22">No</label>
                                </div>
                            </div>
                        </div>

                        <div>
                            <select name="hall" id="first-choice" class="custom-select custom-select-lg mt-10 extra">
                                <option value='1'>Hall One</option>
                                <option value='2'>Hall Two</option>
                            </select>
                            <div class="select-dropdown extra"></div>
                        </div>

                        <div>
                            <select name="staff_type" id="first-choice2" class="custom-select custom-select-lg mt-10 extra">
                                <option value='Attendant'>Attendant</option>
                                <option value='Gardener'>Gardener</option>
                            </select>
                            <div class="select-dropdown extra"></div>
                        </div>

                        <div class="form-group">
                            <input type="tel" class="form-input" name="contact" id="contact" placeholder="Contact Number" />
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-input" name="password" id="password" placeholder="Password" required />
                            <span toggle="#password" class="zmdi zmdi-eye field-icon toggle-password"></span>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-input" name="address" id="address" placeholder="Enter Your Address" />
                        </div>

                        <div class="form-group">
                            <input type="submit" name="submit" id="submit" class="form-submit btn btn-brand" value="Sign up"/>
                        </div>
                    </form>
                    <p class="loginhere">
                        Already have an account? <a href="login.jsp" class="loginhere-link">Login here</a>
                    </p>
                </div>
            </div>
        </section>

    </div>

    <script>
    $(document).ready(function () {
        $(".toggle-password").click(function () {
            $(this).toggleClass("zmdi-eye zmdi-eye-off");
            var input = $($(this).attr("toggle"));
            if (input.attr("type") === "password") {
                input.attr("type", "text");
            } else {
                input.attr("type", "password");
            }
        });
    });
</script>



</html>
