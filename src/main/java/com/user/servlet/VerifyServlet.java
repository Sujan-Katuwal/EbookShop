package com.user.servlet;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.db.DatabaseUtil;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/verify")
public class VerifyServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String pid = request.getParameter("pid");
        String refId = request.getParameter("refId");
        String amt = request.getParameter("amt");
        String author_name = request.getParameter("author_name");
        String book_name = request.getParameter("book_name");

        String scd = "EPAYTEST";  // Merchant code
        String verifyUrl = "https://uat.esewa.com.np/epay/transrec";
        String totalAmt = amt;

        String verificationUrl = verifyUrl + "?amt=" + totalAmt + "&rid=" + refId + "&pid=" + pid + "&scd=" + scd;

        // Verify the transaction with eSewa
        @SuppressWarnings("deprecation")
		URL url = new URL(verificationUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");

        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String inputLine;
        StringBuilder content = new StringBuilder();
        while ((inputLine = in.readLine()) != null) {
            content.append(inputLine);
        }
        in.close();

        // Get verification response
        String verificationResponse = content.toString();

        // Update the database based on the response
        try (Connection dbConnection = DatabaseUtil.getConnection()) {
            String updateSql = "UPDATE `orders` SET status = ? WHERE pid = ?";
            PreparedStatement stmt = dbConnection.prepareStatement(updateSql);
            if (verificationResponse.contains("success")) {
                stmt.setString(1, "success");
            } else {
                stmt.setString(1, "failure");
            }
            stmt.setString(2, pid);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Display the result of the verification
        response.getWriter().println("Verification Response: " + verificationResponse);
    }
}
