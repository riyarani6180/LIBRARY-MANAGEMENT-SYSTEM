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

public class BooksServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");
        String search = request.getParameter("search");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps;
            
            if (search != null && !search.trim().isEmpty()) {
                String sql = "SELECT * FROM books WHERE title ILIKE ? OR author ILIKE ? OR genre ILIKE ?";
                ps = conn.prepareStatement(sql);
                String term = "%" + search.trim() + "%";
                ps.setString(1, term);
                ps.setString(2, term);
                ps.setString(3, term);
            } else {
                String sql;
                if (action != null && action.equals("featured")) {
                    sql = "SELECT * FROM books ORDER BY RANDOM() LIMIT 6";
                } else if (action != null && action.equals("latest")) {
                    sql = "SELECT * FROM books ORDER BY added_on DESC LIMIT 4";
                } else {
                    sql = "SELECT * FROM books ORDER BY added_on DESC";
                }
                ps = conn.prepareStatement(sql);
            }
            
            ResultSet rs = ps.executeQuery();

            out.print("[");
            int count = 0;
            while (rs.next()) {
                if (count > 0) out.print(",");
                out.print("{\"id\":" + rs.getInt("id") + ",\"title\":\"" + rs.getString("title") + 
                    "\",\"author\":\"" + rs.getString("author") + "\",\"genre\":\"" + rs.getString("genre") + 
                    "\",\"type\":\"" + rs.getString("type") + "\",\"available\":" + rs.getBoolean("available") + 
                    ",\"coverUrl\":\"" + rs.getString("cover_url") + "\"}");
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
