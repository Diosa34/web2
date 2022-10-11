package com.github.diosa.servlets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ControllerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("x") != null &&
            request.getParameter("y") != null &&
            request.getParameter("r") != null) {
            getServletContext().getNamedDispatcher("HittingCheckServlet").forward(request, response);
        } else {
            String clear = request.getParameter("clear");
            if (clear != null && clear.equals("true")) {
                getServletContext().getNamedDispatcher("ClearServlet").forward(request, response);
            } else {
                getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
            }
        }
    }
}
