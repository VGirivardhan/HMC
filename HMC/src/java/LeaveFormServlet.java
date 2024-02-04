import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LeaveFormServlet")
public class LeaveFormServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String type = request.getParameter("staff_type");
        String name = (String) session.getAttribute("username");
        int days = Integer.parseInt(request.getParameter("no_of_days"));
        String reason = request.getParameter("reason");

        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");

            String selectQuery = "SELECT * FROM attendant_and_gardener WHERE EMAIL_ID=?";
            try (PreparedStatement selectStmt = conn.prepareStatement(selectQuery)) {
                selectStmt.setString(1, email);
                ResultSet resultSet = selectStmt.executeQuery();

                if (resultSet.next()) {
                    int currentLeaves = resultSet.getInt("NO_OF_LEAVES");
                    int newLeaves = currentLeaves + days;

                    String insertQuery = "INSERT INTO staff_leaves(TYPE, NAME, EMAIL_ID, NO_OF_DAYS, REASON, DATES, MONTHS) VALUES(?, ?, ?, ?, ?, ?, ?)";
                    String updateQuery = "UPDATE attendant_and_gardener SET NO_OF_DAYS=? WHERE EMAIL_ID=?";

                    try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                            PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                        conn.setAutoCommit(false);

                        insertStmt.setString(1, type);
                        insertStmt.setString(2, name);
                        insertStmt.setString(3, email);
                        insertStmt.setInt(4, days);
                        insertStmt.setString(5, reason);
                        insertStmt.setString(6, getCurrentDate());
                        insertStmt.setString(7, getCurrentMonth());

                        updateStmt.setInt(1, newLeaves);
                        updateStmt.setString(2, email);

                        insertStmt.executeUpdate();
                        updateStmt.executeUpdate();

                        conn.commit();

                        session.setAttribute("register", "Leave Letter Submitted");
                        session.setAttribute("register1", true);
                        response.sendRedirect("attendant_and_gardener.jsp");
                    } catch (SQLException e) {
                        conn.rollback();
                        throw e;
                    }
                } else {
                    session.setAttribute("register", "Staff Not Existed");
                    session.setAttribute("register1", true);
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

    private String getCurrentDate() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.format(new Date());
    }

    private String getCurrentMonth() {
        SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
        return monthFormat.format(new Date());
    }
}
