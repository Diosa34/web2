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
        ServletContext servletContext = getServletContext();
        servletContext.setAttribute("x", request.getParameter("x"));
        servletContext.setAttribute("y", request.getParameter("y"));
        servletContext.setAttribute("r", request.getParameter("r"));
        servletContext.setAttribute("points", request.getParameter("points"));

        if (servletContext.getAttribute("x") != null &&
            servletContext.getAttribute("y") != null &&
            servletContext.getAttribute("r") != null) {
            request.getRequestDispatcher("/AreaCheckServlet").forward(request, response);
        } else if (servletContext.getAttribute("points") != null) {
            request.getRequestDispatcher("/AreaCheckServlet").forward(request, response);
        } else {
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
