/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function addToFridge(){
    var ledDiv = document.getElementById("lednicka");
    var tmp = document.createElement("span");
    tmp.setAttribute("class", "label");
    var text = document.createTextNode("ingredience");
    tmp.appendChild(text);
    ledDiv.appendChild(tmp);
}
