package com.library.servlets;

import com.library.db.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ReserveBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookIdStr = request.getParameter("book_id");
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr);
            Connection conn = DBConnection.getConnection();

            PreparedStatement ps = conn.prepareStatement("INSERT INTO reservations (user_id, book_id, status) VALUES (?, ?, 'pending')");
            ps.setString(1, userId);
            ps.setInt(2, bookId);
            ps.executeUpdate();
            ps.close();

            ps = conn.prepareStatement("UPDATE books SET available = FALSE WHERE id = ?");
            ps.setInt(1, bookId);
            ps.executeUpdate();
            ps.close();
            conn.close();

            response.sendRedirect("index.jsp?reserved=true");

        } catch (Exception e) {
            request.setAttribute("error", "Something went wrong");
            request.getRequestDispatcher("reserve.jsp").forward(request, response);
        }
    }
}
