<%@ page import="com.github.diosa.entities.Shot" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %><%--
  Created by IntelliJ IDEA.
  User: Diosa
  Date: 12.10.2022
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Result</title>
</head>
<body>
    <table class="result-table">
        <tr class="table-header">
            <td>Дата</td>
            <td>X</td>
            <td>Y</td>
            <td>R</td>
            <td>Попадание</td>
            <td>Время обработки запроса</td>
        </tr>
        <%
            List<Shot> shots = (List<Shot>) request.getServletContext().getAttribute("shots");
            if (shots != null) {
                out.println("<tr>");
                double x = shots.get(shots.size() - 1).getX();
                double y = shots.get(shots.size() - 1).getY();
                double r = shots.get(shots.size() - 1).getR();
                NumberFormat nf = new DecimalFormat("#.########");
                out.println("<td><b>" + shots.get(shots.size() - 1).getLocalDateTime() + "</b></td>");
                out.println("<td>" + nf.format(x).replace(",", ".") + "</td>");
                out.println("<td>" + nf.format(y).replace(",", ".") + "</td>");
                out.println("<td>" + nf.format(r).replace(",", ".") + "</td>");
                out.println("<td>" + shots.get(shots.size() - 1).getArea() + "</td>");
                out.println("<td><b>" + nf.format(shots.get(shots.size() - 1).getExecTime()).replace(",", ".") + "</b></td>");
                out.println("</tr>");
            }
        %>
    </table>
    <a href="/index.jsp">Вернуться к графику</a>
</body>
</html>
