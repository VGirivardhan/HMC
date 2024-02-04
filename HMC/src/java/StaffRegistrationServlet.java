import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/StaffRegistrationServlet")
public class StaffRegistrationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve form parameters
        String name = request.getParameter("staff_name");
        String email = request.getParameter("staff_email");
        String contact = request.getParameter("contact");
        String type = request.getParameter("staff_type");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish database connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");

            // Create SQL query
            String sql = "INSERT INTO attendant_and_gardener(NAME, EMAIL_ID, CONTACT, TYPE, JOINING_DATE, PASSWORD) " +
                         "VALUES (?, ?, ?, ?, ?, 'hmc')";

            // Create prepared statement
            stmt = conn.prepareStatement(sql);

            // Set parameters
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, contact);
            stmt.setString(4, type);
            stmt.setString(5, java.time.LocalDate.now().toString());  // Using Java 8 time API

            // Execute the query
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                session.setAttribute("register", "Successfully Register");
                session.setAttribute("register1", true);
                response.sendRedirect("clerk.jsp");
            } else {
                throw new SQLException("Error in database insertion");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions (log or redirect to an error page)
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            // Close resources in a finally block
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }
}
