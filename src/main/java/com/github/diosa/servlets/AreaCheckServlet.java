package com.github.diosa.servlets;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.diosa.entities.Shot;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp); // необходимо для навигации по страницам
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long startTime = System.nanoTime();
        response.setContentType("text/html;charset=UTF-8");

        if (request.getParameter("x") != null) {
            addPointsToServletContext(request, request.getParameter("x"),
                    request.getParameter("y"), request.getParameter("r"), startTime);
        } else {
            List<Map<String, String>> pointsList = new ObjectMapper().readValue(
                    request.getParameter("points"), new TypeReference<List<Map<String, String>>>(){});
            for (Map<String, String> shot: pointsList) {
                addPointsToServletContext(request, shot.get("x"), shot.get("y"), shot.get("r"), startTime);
            }
        }
        request.getServletContext().getRequestDispatcher("/result.jsp").forward(request, response);
    }

    private void addPointsToServletContext(HttpServletRequest request, String x, String y, String r, long startTime){

        Shot shot = getShot(x, y, r, startTime);
        List<Shot> shots = (List<Shot>) request.getServletContext().getAttribute("shots");
        if (shots == null) {
            shots = Stream.of(shot).collect(Collectors.toList());
        } else {
            shots.add(shot);
        }
        request.getServletContext().setAttribute("shots", shots);
    }

    private Shot getShot(String requestX, String requestY, String requestR, long startTime) {
        double x = 0.0;
        double y = 0.0;
        double r = 0.0;
        Shot shot = new Shot(x, y, r);
        shot.setExecTime(0.0);
        shot.setLocalDateTime("0");
        try {
            x = Double.parseDouble(requestX);
            y = Double.parseDouble(requestY);
            r = Double.parseDouble(requestR);
        } catch (NumberFormatException ex) {
            shot.setArea("Данные некорректны");
            return shot;
        }
        String currentTime = new SimpleDateFormat("HH:mm:ss").format(new Date());
        shot.setX(x);
        shot.setY(y);
        shot.setR(r);
        shot.checkValid();
        if (shot.getValid()) {
            shot.checkArea();
        } else {
            shot.setArea("Данные некорректны");
        }
        shot.setLocalDateTime(currentTime);
        shot.setExecTime((System.nanoTime() - startTime) / 1000000000d);
        return shot;
    }
}
