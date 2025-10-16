let products = [
    {
        description:"Regular white T-shirt",
        price : 30,
        type:"Topwear",
        photo:"./images/whiteTshirt.jpeg"
    },
    {
        description:"Basic white T-shirt",
        price : 40,
        type:"Topwear",
        photo:"./images/whiteShirt.jpeg"
    },
    {
        description:"Beige short skirt",
        price : 49,
        type:"Bottomwear",
        photo:"./images/beigeskirt.jpg"
    },
    {
        description:"Sporty smartwatch",
        price : 99,
        type:"watch",
        photo:"./images/watch.jpg"
    }, {
        description:"Watch",
        price : 89,
        type:"watch",
        photo:"./images/watchF.jpeg"
    },
    {
        description:"Black Jacket",
        price : 89,
        type:"Jacket",
        photo:"./images/blackjacket.jpg"
    },
    {
        description:"Brown Jacket",
        price : 109,
        type:"Jacket",
        photo:"./images/brownjacket.jpg"
    },
    {
        description:"Cosy Jacket ",
        price : 159,
        type:"Jacket",
        photo:"./images/Doudoune.jpeg"
    },
]
for(product of products){
    let card = document.createElement("div")
    card.classList.add("card",product.type,"hide")
    let imgContainer = document.createElement("div")
    imgContainer.classList.add("imageContainer")
    document.getElementById("products").appendChild(card)
    let img = document.createElement("img")
    img.setAttribute("src",product.photo)
    card.appendChild(imgContainer)
    imgContainer.appendChild(img)
    let info = document.createElement("div")
    info.classList.add("Txtcontainer")
    let name = document.createElement("h5")
    name.classList.add("poductName")
    name.innerText = product.description.toUpperCase()
    card.appendChild(name)
    let price  = document.createElement("h5")
    price.innerText = product.price + "$"
    card.appendChild(price)
    // let type  = document.createElement("h5")
    // type.innerText = product.type
    // card.appendChild(type)
    let btnTop = document.querySelector(".btnTop")

}
function filtrerProduct(type){
        let buttons = document.querySelectorAll(".BtnSelect") //retourn une liste 
        let cards = document.querySelectorAll(".card")
        buttons.forEach(button=>{
            if(type.toUpperCase()===button.innerText.toUpperCase()){
                button.classList.add("active")
            }
            else{
                button.classList.remove("active")
            }
        })
        cards.forEach(card =>{
            if(type === "all"){
                card.classList.remove("hide")
            }
            else{
                 if(card.classList.contains(type)){
                card.classList.remove("hide")
            }
            else{
                card.classList.add("hide")
            }
            }
           
        }

        )

}
function search(){
    let val = document.querySelector("input").value.toLowerCase()
    let cards = document.querySelectorAll(".card")
    cards.forEach(card=>{
        let productName  = card.querySelector(".poductName").innerText.toLowerCase()
        if(productName.includes(val)){
            card.classList.remove("hide")
        }
        else{
            card.classList.add("hide")
        }
    }) 
}
window.onload = ()=>{filtrerProduct("all")}

