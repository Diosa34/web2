<%@ page import="com.github.diosa.entities.Shot" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Result</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/result.css">
</head>
<body>
<%--    <div class="image">--%>
<%--        <%--%>
<%--            List<Shot> shots = (List<Shot>) request.getServletContext().getAttribute("shots");--%>
<%--            if (shots != null) {--%>
<%--                if (shots.get(shots.size() - 1).getArea().startsWith("Точка попала")){--%>
<%--                    out.println("<img id='gif' src=" + "${pageContext.request.contextPath}/resourses/jandi-boys-over-flowers-кулачки.gif" + "><br>");--%>
<%--                }--%>
<%--                else {--%>
<%--                    out.println("<img id='gif' src=" + "${pageContext.request.contextPath}/resourses/Со-Хён.gif" + "><br>");--%>
<%--                }--%>
<%--            }--%>
<%--        %>--%>
<%--    </div>--%>
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
                out.println("</tr><br>");
            } else {
                out.println("Запрос неккорректен!!!");
            }
        %>
    </table><br>
    <a href="${pageContext.request.contextPath}/index.jsp">Вернуться к графику</a>
</body>
</html>
