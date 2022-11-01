let pressedButton = null
function xChoose(button) {
    if (pressedButton !== null) {
        pressedButton.disabled = false
    }
    pressedButton = button
    pressedButton.disabled = true
    document.getElementById("chosen-button").value = button.value
}

let y = null
function validationY(){
    let yElem = document.getElementById("y")
    let warning = document.getElementById("y-warning")
    if (+yElem.value <= 3 && -3 <= +yElem.value) {
        warning.style.display = "none"
        y = yElem.value
    } else {
        warning.innerText = "Координата Y должна быть числом из диапазона (-3; 3)"
        warning.style.display = "inline-block"
        y = null
    }
}

let svg = document.getElementById("svg")
let rWarning = document.getElementById("select-warning")
let points = []

function svgClick(event) {
    let r = document.getElementById("r").value
    if (r !== "Выберите радиус") {
        let svgCoord = svg.getBoundingClientRect() // DOMRect object
        rWarning.style.display = "none"


        let xPartOfSvg = (event.clientX - svgCoord.x)/svgCoord.width // координата(в долях) клика относительно svg
        let yPartOfSvg = (event.clientY - svgCoord.y)/svgCoord.height
        drawPoint((xPartOfSvg) * 600, (yPartOfSvg) * 600)

        let x = (xPartOfSvg - 0.5) * 3 * r
        let y = -1 * (yPartOfSvg - 0.5) * 3 * r
        points.push({x: x, y: y, r: r})
    } else {
        rWarning.innerText = "Невозможно определить координату точки: выберите радиус"
        rWarning.style.display = "inline-block"
    }
}

function drawPoint(x, y){
    svg.innerHTML += "<circle cx='" + x + "' cy='" + y + "' r='7' fill='black'/>"
}

// Отправляем массив точек на сервер
function pointSubmit(path) {
    let arr = JSON.stringify(points);
    let xhr = new XMLHttpRequest();
    let url = new URL(path);
    url.searchParams.set("points", arr);
    url.searchParams.set("count", points.length.toString())
    xhr.open("GET", url, false);
    xhr.send();
}
