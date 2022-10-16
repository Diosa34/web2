package com.github.diosa.servlets;

import com.github.diosa.entities.Shot;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class AreaCheckServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long startTime = System.nanoTime();
        response.setContentType("text/html;charset=UTF-8");

        Shot shot = getShot(request, startTime);
        List<Shot> shots = (List<Shot>) request.getServletContext().getAttribute("shots");
        if (shots == null) {
            shots = Stream.of(shot).collect(Collectors.toList());
        } else {
            shots.add(shot);
        }
        request.getServletContext().setAttribute("shots", shots);

        getServletContext().getRequestDispatcher("/result.jsp").forward(request, response);
    }

    private Shot getShot(HttpServletRequest request, long startTime) {
        double x = Double.parseDouble(request.getParameter("x"));
        double y = Double.parseDouble(request.getParameter("y"));
        double r = Double.parseDouble(request.getParameter("r"));
        String currentTime = new SimpleDateFormat("HH:mm:ss").format(new Date());
        Shot shot = new Shot(x, y, r);
        shot.checkArea();
        shot.setLocalDateTime(currentTime);
        shot.setExecTime((System.nanoTime() - startTime) / 1000000000d);
        return shot;
    }

}
