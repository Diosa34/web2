package com.github.diosa.servlets;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ControllerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String x = request.getParameter("x");
        String y = request.getParameter("y");
        String r = request.getParameter("r");
        String points = request.getParameter("points");

        ServletContext servletContext = getServletContext();

        if ( x != null || y != null || r != null) {
            servletContext.setAttribute("x", x);
            servletContext.setAttribute("y", y);
            servletContext.setAttribute("r", r);
            request.getRequestDispatcher("/AreaCheckServlet").forward(request, response);
        } else if (points != null) {
            servletContext.setAttribute("points", points);
            request.getRequestDispatcher("/AreaCheckServlet").forward(request, response);
        } else {
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
