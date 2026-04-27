package com.library.servlets;

import com.library.db.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CategoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String genre = request.getParameter("genre");

        if (genre == null || genre.trim().isEmpty()) {
            out.print("[]");
            return;
        }

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM books WHERE genre = ? ORDER BY added_on DESC");
            ps.setString(1, genre.trim());
            ResultSet rs = ps.executeQuery();

            out.print("[");
            int count = 0;
            while (rs.next()) {
                if (count > 0) out.print(",");
                out.print("{\"id\":" + rs.getInt("id") + ",\"title\":\"" + rs.getString("title") + 
                    "\",\"author\":\"" + rs.getString("author") + "\",\"genre\":\"" + rs.getString("genre") + 
                    "\",\"type\":\"" + rs.getString("type") + "\",\"coverUrl\":\"" + rs.getString("cover_url") + 
                    "\",\"available\":" + rs.getBoolean("available") + "}");
                count++;
            }
            out.print("]");

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            out.print("[]");
        }
    }
}
