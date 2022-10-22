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
        let coord = svg.getBoundingClientRect() // координаты элемента относительно окна
        rWarning.style.display = "none"
        let x = ((event.clientX - coord.left) / coord.width - 0.5) * 3 * r
        let y = -1 * ((event.clientY - coord.top) / coord.height - 0.5) * 3 * r
        points.push({x: x, y: y, r: r})
    } else {
        rWarning.innerText = "Невозможно определить координату точки"
        rWarning.style.display = "inline-block"
    }
}

function drawPoint(){
    // svg.innerHTML += "<circle cx='100' cy=\"100\" r='7' fill='black'/>"
}

function pointSubmit(x, y){
    document.getElementById("chosen-button").value = x
    document.getElementById("y").value = y
    document.getElementById("submit").click()
}
