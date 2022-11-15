package com.github.diosa.servlets;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.diosa.entities.Shot;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long startTime = System.nanoTime();
        response.setContentType("text/html;charset=UTF-8");

        ServletContext servletContext = getServletContext();
        String x = (String) servletContext.getAttribute("x");
        String y = (String) servletContext.getAttribute("y");
        String r = (String) servletContext.getAttribute("r");
        String points = (String) servletContext.getAttribute("points");

        if (x != null && y != null && r != null) {
            addPointsToServletContext(x, y, r, startTime, true);
            servletContext.setAttribute("countOfNewPoints", 1);
        } else {
            List<Map<String, String>> pointsList = new ObjectMapper().readValue(points, new TypeReference<List<Map<String, String>>>(){});

            for (Map<String, String> shot: pointsList) {
                addPointsToServletContext(shot.get("x"), shot.get("y"), shot.get("r"), startTime, false);
            }
            servletContext.setAttribute("countOfNewPoints", (Integer) pointsList.size());
        }
        request.getRequestDispatcher("/result.jsp").forward(request, response);
    }

    private void addPointsToServletContext(String x, String y, String r, long startTime, boolean form){

        Shot shot = getShot(x, y, r, startTime, form);
        List<Shot> shots = (List<Shot>) getServletContext().getAttribute("shots");
        if (shots == null) {
            shots = Stream.of(shot).collect(Collectors.toList());
        } else {
            shots.add(shot);
        }
        getServletContext().setAttribute("shots", shots);
    }

    private Shot getShot(String requestX, String requestY, String requestR, long startTime, boolean form) {
        double x = 0.0;
        double y = 0.0;
        double r = 0.0;
        Shot shot = new Shot(x, y, r);
        shot.setExecTime(0.0);
        shot.setLocalDateTime("0");
        try {
            x = Double.parseDouble(requestX.replace(",", "."));
            y = Double.parseDouble(requestY.replace(",", "."));
            r = Double.parseDouble(requestR.replace(",", "."));
        } catch (NumberFormatException ex) {
            shot.setArea("Данные некорректны");
            return shot;
        }
        String currentTime = new SimpleDateFormat("HH:mm:ss").format(new Date());
        shot.setX(x);
        shot.setY(y);
        shot.setR(r);

        if (form) {
            shot.checkValidForForm();
        } else {
            shot.checkValidForGraphic();
        }

        if (shot.getValid()) {
            shot.checkArea();
        } else {
            shot.setArea("Координаты не входят в область определения");
        }
        shot.setLocalDateTime(currentTime);
        shot.setExecTime((System.nanoTime() - startTime) / 1000000000d);
        return shot;
    }
}
