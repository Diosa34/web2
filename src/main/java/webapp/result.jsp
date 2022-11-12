<%@ page import="com.github.diosa.entities.Shot" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Result</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/result.css">
</head>
<body>
    <table class="result-table">
        <%
            List<Shot> shots = (List<Shot>) request.getServletContext().getAttribute("shots");
            if (shots != null) {
                out.println("<tr>");
                out.println("<td>Время</td>");
                out.println("<td>X</td>");
                out.println("<td>Y</td>");
                out.println("<td>R</td>");
                out.println("<td>Попадание</td>");
                out.println("<td>Время обработки</td>");
                out.println("</tr>");
                out.println("<tr>");
                int countOfNewPoints = 1;
                Integer paramCount = (Integer) request.getServletContext().getAttribute("countOfNewPoints");
                if (paramCount != null) {
                    countOfNewPoints = paramCount;
                }
                for (int i = shots.size() - 1; (shots.size() - countOfNewPoints) <= i; i--) {
                    double x = shots.get(i).getX();
                    double y = shots.get(i).getY();
                    double r = shots.get(i).getR();
                    NumberFormat nf = new DecimalFormat("#.########");
                    out.println("<td><b>" + shots.get(i).getLocalDateTime() + "</b></td>");
                    out.println("<td>" + nf.format(x).replace(",", ".") + "</td>");
                    out.println("<td>" + nf.format(y).replace(",", ".") + "</td>");
                    out.println("<td>" + nf.format(r).replace(",", ".") + "</td>");
                    out.println("<td>" + shots.get(i).getArea() + "</td>");
                    out.println("<td><b>" + nf.format(shots.get(i).getExecTime()).replace(",", ".") + "</b></td>");
                    out.println("</tr>");
                }
            } else {
                out.println("Запрос неккорректен!!!");
            }
        %>
    </table><br>
    <a href="${pageContext.request.contextPath}/index.jsp">Вернуться к графику</a>
</body>
</html>
