package com.emp.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
//import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.text.AbstractDocument.Content;

//import org.apache.catalina.connector.Response;

import com.emp.dao.EmpDao;
import com.emp.jdbc.DBConnect;
import com.google.protobuf.Method;
import com.sendgrid.*;
import com.sendgrid.helpers.mail.objects.Email;



@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
//        System.out.println(email);

        // Database connection
        try (Connection con = DBConnect.getConnection()) {
            EmpDao eDao = new EmpDao(con);

            if (eDao.validateEmail(username, email)) {
                // Generate OTP
                String otp = generateOTP();
//                System.out.println("OTP is : "+otp);
                HttpSession session = request.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("username", username);
                session.setAttribute("email", email);

               // Send OTP to user's email
                sendEmail(email, otp);

                request.getRequestDispatcher("verifyotp.jsp").forward(request, response);
//                response.sendRedirect("verifyotp.jsp");
            } else {
            	request.setAttribute("msg", "Error");
            	request.getRequestDispatcher("forgotpwd.jsp").forward(request, response);
//                response.sendRedirect("forgotpwd.jsp?message=Invalid Username or Email");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "An error occurred. Please try again.");
        	request.getRequestDispatcher("forgotpwd.jsp").forward(request, response);
//            response.sendRedirect("forgotpwd.jsp?message=An error occurred. Please try again.");
        }
    }

    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    public static void sendEmail(String to, String otp) throws MessagingException {
        String from = "kananth494@gmail.com";
        final String username = "kananth494@gmail.com";
        final String password = "bwcu ypxs axgs fmcb"; // Use an App Password if less secure apps are disabled

        // SMTP server information
        String host = "smtp.gmail.com";
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");

        // Get the Session object
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            // Create a default MimeMessage object
            Message message = new MimeMessage(session);

            // Set From: header field
            message.setFrom(new InternetAddress(from));

            // Set To: header field
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));

            // Set Subject: header field
            message.setSubject("Email Verification");

            // Create the verification link
            String verificationLink = "http://localhost:8080/EmpManagement/verifyotp.jsp";

            // Set the actual message
            String htmlContent = "<p>Click the link below to verify your email: "+to+"</p><br>"
            		+"<p>Your OTP :  "+otp+"</p> <br>"
                               + "\n<a href=\"" + verificationLink + "\">Verify Email</a>";

            message.setContent(htmlContent, "text/html");

            // Send the message
            Transport.send(message);

//            System.out.println("Email sent successfully with OTP link");

        } catch (MessagingException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    
    
    
  

}
