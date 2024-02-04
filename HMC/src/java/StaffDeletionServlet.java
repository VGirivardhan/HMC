import java.io.IOException;
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

@WebServlet("/StaffDeletionServlet")
public class StaffDeletionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve query parameters
        String email = request.getParameter("email");
        String type = request.getParameter("type");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish database connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");

            // Create SQL query
            String sql = "DELETE FROM attendant_and_gardener WHERE EMAIL_ID=? AND TYPE=?";

            // Create prepared statement
            stmt = conn.prepareStatement(sql);

            // Set parameters
            stmt.setString(1, email);
            stmt.setString(2, type);

            // Execute the query
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                session.setAttribute("register", "Staff Account Deleted.");
                session.setAttribute("register1", true);
                response.sendRedirect("clerk.jsp");
            } else {
                throw new SQLException("No rows affected. Staff account not found.");
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
