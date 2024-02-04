import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ToolsServlet")
public class ToolsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String name = (String) session.getAttribute("username");
        String[] selectedTools = request.getParameterValues("checkbox");

        String tools = "";
        if (selectedTools != null && selectedTools.length > 0) {
            tools = String.join(" ", selectedTools);
        }

        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");

            String insertQuery = "INSERT INTO tools(NAME, EMAIL_ID, TOOL) VALUES (?, ?, ?)";

            try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                insertStmt.setString(1, name);
                insertStmt.setString(2, email);
                insertStmt.setString(3, tools);

                if (insertStmt.executeUpdate() > 0) {
                    session.setAttribute("error", "Success");
                    response.sendRedirect("attendant_and_gardener.jsp");
                } else {
                    session.setAttribute("error", "Error");
                    response.sendRedirect("attendant_and_gardener.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
