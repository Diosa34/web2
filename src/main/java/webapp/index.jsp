<%@ page import="com.github.diosa.entities.Shot" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html;charset=utf-8" %>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <title>Graphic</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="header">
    <div class="numbers">
        P32091<br>
        91072
    </div>
    <div class="name">
        Осокина Мария Юрьевна
    </div>
</div>
<div class="center">
    <div class="graphic-part">
        <div class="svg">
            <svg viewBox="0 0 600 600" id="svg" onclick="svgClick(event)">
                <path d="M 300 300
              L 200 300
              L 200 100
              L 300 100
              L 300 200
              A 100 100 0 0 1 400 300
              L 300 400
              L 300 300" stroke="black" fill="#fc805f"></path>
                <line x1="300" y1="0" x2="300" y2="600" stroke="black" stroke-width="3"></line>
                <line x1="0" y1="300" x2="600" y2="300" stroke="black" stroke-width="3"></line>
                <line x1="100" y1="295" x2="100" y2="305" stroke="black" stroke-width="3"></line>
                <text x="90" y="290">-R</text>
                <line x1="200" y1="295" x2="200" y2="305" stroke="black" stroke-width="3"></line>
                <text x="190" y="290">-R/2</text>
                <line x1="400" y1="295" x2="400" y2="305" stroke="black" stroke-width="3"></line>
                <text x="390" y="290">R/2</text>
                <line x1="500" y1="295" x2="500" y2="305" stroke="black" stroke-width="3"></line>
                <text x="490" y="290">R</text>
                <line x1="295" y1="100" x2="305" y2="100" stroke="black" stroke-width="3"></line>
                <text x="310" y="105">R</text>
                <line x1="295" y1="200" x2="305" y2="200" stroke="black" stroke-width="3"></line>
                <text x="310" y="205">R/2</text>
                <line x1="295" y1="400" x2="305" y2="400" stroke="black" stroke-width="3"></line>
                <text x="310" y="405">-R/2</text>
                <line x1="295" y1="500" x2="305" y2="500" stroke="black" stroke-width="3"></line>
                <text x="310" y="505">-R</text>
                <text x="315" y="10">y</text>
                <text x="585" y="285">x</text>
                <polygon points="290,10 300,0 310,10" fill="black"></polygon>
                <polygon points="590,290 600,300 590,310" fill="black"></polygon>
                <%
                    List<Shot> shots = (List<Shot>) request.getServletContext().getAttribute("shots");
                    if (shots != null) {
                        for (Shot i : shots) {
                            if (i.getArea() != "Данные некорректны") {
                                NumberFormat nf = new DecimalFormat("#.########");
                                double x = (((i.getX() / i.getR()) / 3) + 0.5) * 600;
                                double y = (((i.getY() / i.getR()) / -3) + 0.5) * 600;
                                String pointFill = "";
                                if (i.getArea().startsWith("Точка попала")) {
                                    pointFill = Shot.colorMap.get(i.getR());
                                } else {
                                    pointFill = Shot.colorAMap.get(i.getR());
                                }
                                out.println("<circle cx='" + nf.format(x).replace(',', '.') +
                                        "' cy='" + nf.format(y).replace(',', '.') + "' r='7' fill='" + pointFill + "'/>");
                            }
                        }
                    }
                %>
            </svg>
        </div>
        <br>
        <button id="pointsSubmit" value="Проверить попадание точек в область"
                onclick="pointSubmit('http://localhost:8080/${pageContext.request.contextPath}/ControllerServlet')">
            Проверить попадание точек в область</button>
        <span id="select-warning" style="display: none"></span>
    </div>
    <div class="right-block">
        <form method="get" action="${pageContext.request.contextPath}/ControllerServlet" id="form">
            <div class="data">
                X:
                <button type="button" id="btn1" onclick="xChoose(this)" value="-4">-4</button>
                <button type="button" id="btn2" onclick="xChoose(this)" value="-3">-3</button>
                <button type="button" id="btn3" onclick="xChoose(this)" value="-2">-2</button>
                <button type="button" id="btn4" onclick="xChoose(this)" value="-1">-1</button>
                <button type="button" id="btn5" onclick="xChoose(this)" value="0">0</button>
                <button type="button" id="btn6" onclick="xChoose(this)" value="1">1</button>
                <button type="button" id="btn7" onclick="xChoose(this)" value="2">2</button>
                <button type="button" id="btn8" onclick="xChoose(this)" value="3">3</button>
                <button type="button" id="btn9" onclick="xChoose(this)" value="4">4</button>
                <input type="hidden" name="x" id="chosen-button">
                <br>

                Y:
                <label><input type="text" oninput="validationY()" id="y" name="y"></label>
                <br>

                R:
                <select size="1" name="r" id="r">
                    <option value="Выберите радиус" selected>Выберите радиус</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select><br>
                <span id="y-warning" style="display: none"></span>
            </div>
            <br>
            <input id="submit" type="submit">
        </form>
        <br>

        <table class="result-table">
                <%
            if (shots != null) {
              out.println("<tr>");
              out.println("<td>Время</td>");
              out.println("<td>X</td>");
              out.println("<td>Y</td>");
              out.println("<td>R</td>");
              out.println("<td>Попадание</td>");
              out.println("<td>Время<br> обработки<br> запроса</td>");
              out.println("</tr>");
              for (int i = shots.size() - 1; (shots.size() > 10 ) ? i >= shots.size() - 10 : i >= 0; i--) {
                out.println("<tr>");
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
            }
    %>
    </div>
    </table>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/validation/validation.js"></script>
</body>
</html>