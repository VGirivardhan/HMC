import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (request.getParameter("pay") != null) {
            try {
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hmc", "root", "Girirkv@139");

                String email = (String) session.getAttribute("email");
                String sql = "SELECT * FROM student WHERE EMAIL_ID='" + email + "'";
                Statement stmt = conn.createStatement();
                ResultSet result = stmt.executeQuery(sql);

                if (result.next()) {
                    int sum = result.getInt("HALL_DUES") + result.getInt("MESS_DUES");
                    int newBalance = result.getInt("BALANCE") - sum;

                    String update = "UPDATE student SET MESS_DUES=0, HALL_DUES=0, BALANCE='" + newBalance + "' WHERE EMAIL_ID='" + email + "'";
                    String insert = "INSERT INTO mess_fee(NAME, EMAIL_ID, AMOUNT, DATE) VALUES ('" + result.getString("NAME") + "','" + email + "','" + result.getInt("MESS_DUES") + "', NOW())";

                    if (stmt.executeUpdate(update) > 0 && stmt.executeUpdate(insert) > 0) {
                        // Payment successful
                        session.setAttribute("paymentMessage", "Successfully paid");
                        session.setAttribute("paymentSuccess", true);
                    } else {
                        // Payment unsuccessful
                        session.setAttribute("paymentMessage", "Payment failed");
                        session.setAttribute("paymentSuccess", false);
                    }

                    response.sendRedirect("student.jsp");
                } else {
                    response.getWriter().println("User not found");
                }

                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
