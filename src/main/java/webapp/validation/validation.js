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
