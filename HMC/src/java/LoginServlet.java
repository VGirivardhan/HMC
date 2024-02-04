import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user_type = request.getParameter("user_type");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Please check your Email Id and Password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else if (!email.matches("\\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}\\b")) {
            request.setAttribute("error", "Please check your Email Id");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            try {
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");

                String sql = "SELECT * FROM " + user_type + " WHERE EMAIL_ID=? AND PASSWORD=?";
                PreparedStatement statement = conn.prepareStatement(sql);
                statement.setString(1, email);
                statement.setString(2, password);

                ResultSet result = statement.executeQuery();

                if (result.next()) {
                    
                    HttpSession session = request.getSession();

                    
                    session.setAttribute("email", email);
                    session.setAttribute("user_type", user_type);

                    if ("student".equals(user_type)) {
                        
                        session.setAttribute("username", result.getString("NAME"));
                        session.setAttribute("hall", result.getString("HALL"));
                        session.setAttribute("room", result.getString("ROOM"));
                        session.setAttribute("address", result.getString("PERMANENT_ADDRESS"));
                        session.setAttribute("contact", result.getString("CONTACT"));
                    } else if ("warden".equals(user_type)) {
                        
                        session.setAttribute("username", result.getString("NAME"));
                        session.setAttribute("hall", result.getString("HALL"));
                        session.setAttribute("contact", result.getString("CONTACT"));
                    } else {
                       
                        session.setAttribute("username", result.getString("NAME"));
                        session.setAttribute("contact", result.getString("CONTACT"));
                    }

                    
                    session.setAttribute("login", true);

                    
                    response.sendRedirect(user_type + ".jsp");
                } else {
                    request.setAttribute("error", "Entered Password or email is not valid.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }

                conn.close();
            } catch (Exception e) {
                e.printStackTrace(); 
                
                request.setAttribute("error", "An unexpected error occurred. Please try again later.");

               
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        }
    }
}
