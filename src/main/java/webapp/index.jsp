<%@ page import="com.github.diosa.entities.Shot" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Graphic</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="header">
  <div class="numbers">
    P32091<br>
    1313
  </div>
  <div class="name">
    Осокина Мария Юрьевна
  </div>
</div>
<div class="center">
  <div class="graphic-part">
    <div class="svg">
      <svg viewBox="0 0 600 600" width="300px" height="300px" id="svg">
      <path d="M 300 300
              L 200 300
              L 200 100
              L 300 100
              L 300 200
              A 100 100 0 0 1 400 300
              L 300 400
              L 300 300" fill="rgb(51, 153, 255)"></path>
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
<%--      <%--%>
<%--        List<Shot> shots = (List<Shot>) request.getServletContext().getAttribute("shots");--%>
<%--        if (shots != null) {--%>
<%--          NumberFormat nf = new DecimalFormat("#.########");--%>
<%--          out.println("<tr>");--%>
<%--          double x = shots.get(shots.size() - 1).getX();--%>
<%--          double y = shots.get(shots.size() - 1).getY();--%>
<%--          out.println("<circle cx=" + nf.format(x).replace(',', '.') +--%>
<%--                              "cy=" + nf.format(y).replace(',', '.') + " r='2' fill='rgb(252,171,138)'/>");--%>
<%--        }--%>
<%--      %>--%>

      </svg>
    </div>
  </div>
  <div class="right-block">
      <form method="get" action="/controller">
        <div class="data">
          X:
          <button type="button" id="btn1" disabled onclick="xChoose(this)" value="-4">-4</button>
          <button type="button" id="btn2" disabled onclick="xChoose(this)" value="-3">-3</button>
          <button type="button" id="btn3" disabled onclick="xChoose(this)" value="-2">-2</button>
          <button type="button" id="btn4" disabled onclick="xChoose(this)" value="-1">-1</button>
          <button type="button" id="btn5" disabled onclick="xChoose(this)" value="0">0</button>
          <button type="button" id="btn6" disabled onclick="xChoose(this)" value="1">1</button>
          <button type="button" id="btn7" disabled onclick="xChoose(this)" value="2">2</button>
          <button type="button" id="btn8" disabled onclick="xChoose(this)" value="3">3</button>
          <button type="button" id="btn9" disabled onclick="xChoose(this)" value="4">4</button>
          <input type="hidden" name="X" id="chosen-button">
          <br>

          Y:
          <label><input type="text" oninput="validationY()" id="y" name="y"></label>
          <span id="y-warning" style="display: none"></span>
          <br>

          R:
          <p>
            <select size="5" name="R" id="r">
              <option disabled>Выберите радиус</option>
              <option value="1" onchange="rSelect(this)">1</option>
              <option value="2" onchange="rSelect(this)">2</option>
              <option value="3" onchange="rSelect(this)">3</option>
              <option value="4" onchange="rSelect(this)">4</option>
              <option value="5" onchange="rSelect(this)">5</option>
             </select>
            <input type="hidden" name="R" id="selected-elem">
          </p>
        </div>
        <input id="submit" type="submit">
      </form>
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
          for (int i = shots.size() - 1; i >= 0; i--) {
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
    </table>
  </div>
</div>
<script src="validation.js"></script>
</body>
</html>