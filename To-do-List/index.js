const text = document.getElementById("input");
const ul = document.getElementById("list-container");
function addtask(){
    if(text.value === ''){
        alert("You must write something!");
    }
    else{
        let li = document.createElement("li");
        li.innerHTML = text.value ;
        ul.appendChild(li);
        let x = document.createElement("span");
        x.innerHTML="\u00d7";
        li.appendChild(x);
        save();
    }
    text.value='';
}
ul.addEventListener("click",function(e){
if(e.target.tagName==="LI"){
    e.target.classList.toggle("checked");
    save();
}
else if(e.target.tagName==="SPAN"){
    e.target.parentElement.remove();
    save();
}
});
function save(){
    localStorage.setItem("data",ul.innerHTML);
}
function show(){
   ul.innerHTML = localStorage.getItem("data");
}
show();