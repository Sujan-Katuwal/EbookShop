package com.user.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.db.DBConnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DownloadImageServlet")
public class DownloadImageServlet extends HttpServlet  {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// Dynamically get the image directory path
    private String getImageDirectory(HttpServletRequest request) {
        // Get the real path of the /img directory within the web application
        return getServletContext().getRealPath("/book");
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookId = request.getParameter("bookId");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Fetch the image file name from the database using the bookId
            conn = DBConnect.getConnection();
            String sql = "SELECT image FROM books WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(bookId));
            rs = stmt.executeQuery();

            if (rs.next()) {
                String imageName = rs.getString("image");  // The image file name stored in the database

                // Dynamically get the /img directory path
                String imageDir = getImageDirectory(request);

                // Construct the full path to the image
                File imageFile = new File(imageDir + File.separator + imageName);

                // Check if the file exists
                if (imageFile.exists()) {
                    // Set response headers
                    response.setContentType(getServletContext().getMimeType(imageFile.getName()));
                    response.setHeader("Content-Disposition", "attachment; filename=\"" + imageFile.getName() + "\"");

                    // Send the file to the client
                    FileInputStream inStream = new FileInputStream(imageFile);
                    ServletOutputStream outStream = response.getOutputStream();

                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;

                    while ((bytesRead = inStream.read(buffer)) != -1) {
                        outStream.write(buffer, 0, bytesRead);
                    }

                    inStream.close();
                    outStream.close();
                } else {
                    // Handle file not found case
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
