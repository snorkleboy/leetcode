document.addEventListener("DOMContentLoaded", () => {
    console.log('here')
})
const url = 'https://api.iextrading.com/1.0/stock/aapl/batch?types=quote,news,chart&range=1m&last=1'
// fetch(url).then(res=>res.json()).then(data=> console.log(data))
function myFetchProm(url,method){
    return new Promise((res,rej)=>{
        xhr(url,method, res,rej);
    })
}

function xhr(url, method, success, failure){
    console.log("START XHR")
    var req = new XMLHttpRequest();
    req.onreadystatechange = function (res) {
        console.log("ready state change",req.readyState, req);
        if (req.readyState === 4){
            if (req.status === 200){
                success(req.response)
            } else{
                failure([req.responseText, req.status])
            }    
        }
    }
    req.open(method,url,true);
    req.send();
}
function log(msg){return (e)=>console.log(msg,e)}

myFetchProm(url, "GET")
    .then(data=> JSON.parse(data)).then(res=>log("ok")(res))
    .catch(err=>log("err")(err));

