const foundWords = []

let length = 0;
let height = 0;
function boggle(words,dict){
    length = words.length;
    height = words[0].length;
    console.log(length,height);
    const visited = [[],[],[]]
    for(let i = 0;i < length; i++){
        for( let j = 0; j<height; j++){
            findWords(words,i,j,dict,"",visited);
        }
    }
}

function findWords(words,i,j,dict,str,visited){

    if ( i < 0 || j < 0 || i >= length || j >= height){
        return
    }
    if (visited[i][j]){
	return
    }


    str += words[i][j] 

    if (dict.has(str)){
        foundWords.push(str);
    }

    const nvisited = visited.slice().map((arr)=>arr.slice())
    nvisited[i][j] = true;
    findWords(words,1+i,j,dict,str,nvisited)
    findWords(words,i,1+j,dict,str,nvisited)
    findWords(words,i-1,j,dict,str,nvisited)
    findWords(words,i,j-1,dict,str,nvisited)
    findWords(words,1+i,1+j,dict,str,nvisited)
    findWords(words,i-1,1+j,dict,str,nvisited)
    findWords(words,i-1,j-1,dict,str,nvisited)
    findWords(words,1+i,j-1,dict,str,nvisited)
    nvisited[i][j] = false;


}

const wrds =[
['G','I','Z'],
['U','E','K'],
['Q','S','E']
]
const dictionary = new Set(["GEEKS", "FOR", "QUIZ", "GO"])
boggle(wrds,dictionary)
console.log(foundWords)
