package com.library.servlets;

import com.library.db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("user_id");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("INSERT INTO users (user_id, email, password) VALUES (?, ?, ?)");
            ps.setString(1, userId);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.executeUpdate();
            ps.close();
            conn.close();

            request.setAttribute("success", "Account created! Please log in.");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "User ID or Email already exists");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}
