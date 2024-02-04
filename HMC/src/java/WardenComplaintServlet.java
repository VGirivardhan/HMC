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

@WebServlet("/warden_complaint")
public class WardenComplaintServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String key = request.getParameter("key");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");

            String sql = "UPDATE complaint SET COM_STATUS=1 WHERE ID=?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, key);

                if (pstmt.executeUpdate() > 0) {
                    session.setAttribute("key", true);
                    session.setAttribute("com_solved", "Complaint Solved");
                } else {
                    session.setAttribute("key", false);
                    session.setAttribute("com_solved", "Complaint not Solved");
                }

                response.sendRedirect("warden.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
