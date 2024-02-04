<!DOCTYPE html>
<html lang="en">

<head>
    <title>HMC Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/style.css">

    <style>
        body {
            min-height: 100vh;
            background-image: url('images/1.jpg');
            background-size: cover;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .btn-brand {
            color: #ffffff;
            font-weight: 500;
            border-color: #f58d17;
            background-color: #f58d17;
            transition: all 0.3s ease;
        }

        .btn-brand:hover {
            border-color: #d37810;
            background-color: #d37810;
            color: #ffffff;
            transform: scale(1.1);
        }

        .border {
            position: relative;
            overflow: hidden;
            transition: box-shadow 0.3s ease, transform 0.3s ease;
        }

        .border:hover {
            transform: scale(1.05);
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
        }

        .form-floating input,
        .form-floating select {
            transition: box-shadow 0.3s ease, transform 0.3s ease;
            width: 100%;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border-radius: 0.25rem;
        }

        .form-floating input:hover,
        .form-floating select:hover {
            transform: scale(1.05);
            box-shadow: 0 0 10px rgba(255, 223, 0, 0.8);
        }

        .signup-container {
            max-width: 400px;
        }

        .signup-container .btn {
            width: 100%;
            border-radius: 0.25rem;
        }

        .signup-link {
            position: relative;
            color: #000000;
            /* Black text color */
            text-decoration: none;
            transition: color 0.3s ease;
            font-weight: bold;
        }

        .signup-link:hover {
            color: #000000;
            /* Hover text color - Orange */
        }

        .signup-link::before {
            content: '';
            position: absolute;
            width: 100%;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: #ffa500;
            /* Orange underline color */
            visibility: hidden;
            transform: scaleX(0);
            transition: all 0.3s ease-in-out;
        }

        .signup-link:hover::before {
            visibility: visible;
            transform: scaleX(1);
        }

        .sparkle {
            position: absolute;
            width: 10px;
            height: 10px;
            background-color: #ffd700;
            /* Yellow color, change it accordingly */
            border-radius: 50%;
            opacity: 0;
            animation: sparkleAnimation 1s infinite;
        }

        @keyframes sparkleAnimation {
            0% {
                opacity: 0;
            }
            50% {
                opacity: 1;
            }
            100% {
                opacity: 0;
            }
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

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const formFields = document.querySelectorAll('.form-floating input, .form-floating select');

            formFields.forEach(field => {
                field.addEventListener('mouseover', function () {
                    const sparkle = document.createElement('div');
                    sparkle.classList.add('sparkle');
                    field.appendChild(sparkle);

                    setTimeout(() => {
                        sparkle.remove();
                    }, 1000);
                });
            });
        });
    </script>
</head>

<body>
    <%
    String existMessage = (String) session.getAttribute("exist");
    if (existMessage != null && !existMessage.isEmpty()) {
%>
    <script>
        alert("<%= existMessage %>");
    </script>
<%
    }
    session.removeAttribute("exist"); // Clear the attribute after displaying the message
%>
    <div class="border rounded p-5 bg-white bg-opacity-50 shadow-sm signup-container">
        <h2 class="intro-text text-center animate-characters"><a href="index.jsp">Welcome to Hall Management Center</a></h2>
        <form action="LoginServlet" method="POST">
            <div class="form-floating form-group mt-3">
                <select id="UserType" class="form-select" aria-label="Default select example" name="user_type">
                    <option name="student" value="student">STUDENT</option>
                    <option name="warden" value="warden">WARDEN</option>
                    <option name="mess_manager" value="mess_manager">MESS MANAGER</option>
                    <option name="clerk" value="clerk">CLERK</option>
                    <option name="clerk" value="attendant_and_gardener">ATTENDANT & GARDENER</option>
                </select>
                <label for="User Type" class="form-label">User Type:</label>
            </div>
            <div class="form-floating form-group mt-3">
                <input type="text" id="username" name="email" placeholder="Enter Email" class="form-control" required>
                <label for="username" class="form-label">Email:</label>
            </div>
            <span id="email1" class="text-danger fw-bold fst-italic"></span>
            <div class="form-floating form-group mt-3">
                <input type="password" id="password" name="password" placeholder="Enter Password" class="form-control"
                    required>
                <label for="password" class="form-label">Password:</label>
            </div>
            <span id="pwd1" class="text-danger fw-bold fst-italic"></span>

            <div class="text-center mt-3">
                <button type="submit" name="submit" class="btn btn-brand" value="Log In">Log In</button>
            </div>

            <span class="mr-auto mt-3"><p>If you don't have an account yet</p><a href="registration.jsp"
                    class="signup-link">Sign Up</a></span>
        </form>
    </div>
</body>

</html>
