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
    if (isNaN(yElem.value) || yElem.value === "" || +yElem.value <= -3 || 3 <= +yElem.value) {
        warning.innerText = "Координата Y должна быть числом из диапазона (-3; 3)"
        warning.style.display = "inline-block"
        y = null
    } else {
        warning.style.display = "none"
        y = yElem.value
    }
}

let selectedElem = null
function rSelect(elem){
    selectedElem = elem
    document.getElementById("selected-elem").value = elem.value
}

let svg = document.getElementById("svg").getBoundingClientRect() // координаты мыши относительно окна
let rWarning = document.getElementById("select-warning")

svg.onclick = function (event) {
    if (isRSelected()) {
        rWarning.style.display = "none"
        let x = event.clientX - svg.left
        let y = event.clientY - svg.top
        let url = new URL('/controller');
        url.searchParams.set("x", x);
        url.searchParams.set("y", y);
        let xhr = new XMLHttpRequest();
        xhr.open("GET", url, false);
        xhr.send();
    } else {
        rWarning.innerText = "Невозможно определить координату точки"
        rWarning.style.display = "inline-block"
    }
}

function isRSelected() {
    let rElem = document.getElementById("select")
    return (isNaN(rElem.value) || rElem.value === "" || +rElem.value <= 0 || 6 <= +rElem.value)
}

