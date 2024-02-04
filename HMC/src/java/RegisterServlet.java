import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userType = "";
        int hallDues = 0;

        Connection conn = null;
        Statement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HMC", "root", "Girirkv@139");
            stmt = conn.createStatement();

            HttpSession session = request.getSession();

            if (request.getParameter("submit") != null) {
                userType = request.getParameter("user_type");
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String hall = request.getParameter("hall");
                String password = request.getParameter("password");
                String address = request.getParameter("address");
                String contact = request.getParameter("contact");
                String staffType = request.getParameter("staff_type");
                String extra = request.getParameter("customRadioInline11");
                String gender = request.getParameter("customRadioInline12");
                String roomSharing = request.getParameter("customRadioInline1");
                int messDues = 2500;
                int balance = 10000;

                if (extra != null && roomSharing != null) {
                    if (extra.equals("1") && roomSharing.equals("1")) {
                        hallDues = 3500;
                    } else if (extra.equals("1") && roomSharing.equals("0")) {
                        hallDues = 4500;
                    } else if (extra.equals("0") && roomSharing.equals("0")) {
                        hallDues = 4000;
                    } else {
                        hallDues = 3000;
                    }
                }

                if ("warden".equals(userType)) {
                    if (checkUser(conn, email, userType) == 1) {
                        session.setAttribute("exist", "User existed");
                        response.sendRedirect("login.jsp");
                    } else {
                        String sql = "INSERT INTO warden(NAME, EMAIL_ID, PASSWORD, CONTACT, HALL) VALUES(?, ?, ?, ?, ?)";
                        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
                            preparedStatement.setString(1, name);
                            preparedStatement.setString(2, email);
                            preparedStatement.setString(3, password);
                            preparedStatement.setString(4, contact);
                            preparedStatement.setString(5, hall);

                            preparedStatement.executeUpdate();
                        }
                        session.setAttribute("exist", "Successfully Register");
                        response.sendRedirect("login.jsp");
                    }
                } else if ("student".equals(userType)) {
                    String roomNumberQuery = "SELECT MAX(ROOM) FROM student WHERE HALL=?";
                    try (PreparedStatement preparedStatement = conn.prepareStatement(roomNumberQuery)) {
                        preparedStatement.setString(1, hall);

                        ResultSet resultSet = preparedStatement.executeQuery();
                        int roomNumber = 0;
                        if (resultSet.next()) {
                            roomNumber = resultSet.getInt(1);
                        }

                        if (checkUser(conn, email, userType) == 1) {
                            session.setAttribute("exist", "User existed");
                            response.sendRedirect("login.jsp");
                        } else {
                            String insertStudentQuery = "INSERT INTO student(NAME, GENDER, EMAIL_ID, PASSWORD, "
                                    + "PERMANENT_ADDRESS, CONTACT, ROOM, HALL, AMENITIES, MESS_DUES, HALL_DUES, BALANCE, TWIN_SHARE)"
                                    + " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                            try (PreparedStatement preparedStatementInsert = conn.prepareStatement(insertStudentQuery)) {
                                preparedStatementInsert.setString(1, name);
                                preparedStatementInsert.setString(2, gender);
                                preparedStatementInsert.setString(3, email);
                                preparedStatementInsert.setString(4, password);
                                preparedStatementInsert.setString(5, address);
                                preparedStatementInsert.setString(6, contact);
                                preparedStatementInsert.setInt(7, roomNumber + 1);
                                preparedStatementInsert.setString(8, hall);
                                preparedStatementInsert.setString(9, extra);
                                preparedStatementInsert.setInt(10, messDues);
                                preparedStatementInsert.setInt(11, hallDues);
                                preparedStatementInsert.setInt(12, balance);
                                preparedStatementInsert.setString(13, roomSharing);

                                preparedStatementInsert.executeUpdate();
                            }

                            session.setAttribute("exist", "Successfully Registered");
                            response.sendRedirect("login.jsp");
                        }
                    }
                } else if ("attendant_and_gardener".equals(userType)) {
                    if (checkUser(conn, email, userType) == 1) {
                        session.setAttribute("exist", "User existed");
                        response.sendRedirect("login.jsp");
                    } else {
                        String sql = "INSERT INTO attendant_and_gardener(NAME, EMAIL_ID, PASSWORD, CONTACT, TYPE, JOINING_DATE)"
                                + " VALUES(?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
                            preparedStatement.setString(1, name);
                            preparedStatement.setString(2, email);
                            preparedStatement.setString(3, password);
                            preparedStatement.setString(4, contact);
                            preparedStatement.setString(5, staffType);
                            preparedStatement.setDate(6, new java.sql.Date(System.currentTimeMillis()));

                            preparedStatement.executeUpdate();
                        }
                        session.setAttribute("exist", "Successfully Register");
                        response.sendRedirect("login.jsp");
                    }
                } else if ("clerk".equals(userType) || "mess_manager".equals(userType)) {
                    if (checkUser(conn, email, userType) == 1) {
                        session.setAttribute("exist", "User existed");
                        response.sendRedirect("login.jsp");
                    } else {
                        String sql = "INSERT INTO " + userType + "(NAME, EMAIL_ID, PASSWORD, CONTACT)"
                                + " VALUES(?, ?, ?, ?)";
                        dataInsertion(conn, sql, userType, name, email, password, contact);

                        session.setAttribute("exist", "Successfully Registered");
                        response.sendRedirect("login.jsp");
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private int checkUser(Connection conn, String email, String userType) throws SQLException {
        String sql = "SELECT * FROM " + userType + " WHERE EMAIL_ID=?";
        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setString(1, email);

            ResultSet resultSet = preparedStatement.executeQuery();
            int rowcount = 0;
            if (resultSet.next()) {
                rowcount = 1;
            }
            return rowcount;
        }
    }

    private void dataInsertion(Connection conn, String sql, String userType, String name, String email, String password, String contact) throws SQLException {
        try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3, password);
            preparedStatement.setString(4, contact);

            preparedStatement.executeUpdate();
        }
    }
}
