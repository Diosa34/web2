package com.github.diosa.servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.diosa.entities.Shot;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ControllerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp); // необходимо для навигации по страницам
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if ((request.getParameter("x") != null &&
            request.getParameter("y") != null &&
            request.getParameter("r") != null) || (request.getParameter("points") != null)) {
            getServletContext().getRequestDispatcher("/AreaCheckServlet").forward(request, response);
        } else {
            getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
