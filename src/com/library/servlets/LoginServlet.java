package com.library.servlets;

import com.library.db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT user_id FROM users WHERE email = ? AND password = ?");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("userId", rs.getString("user_id"));
                session.setAttribute("userName", rs.getString("user_id"));
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            request.setAttribute("error", "Something went wrong");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
