/**
 * @param {string} word1
 * @param {string} word2
 * @return {number}
 */
var minDistance = function(word1, word2) {
    if (word1 == word2)        return 0
    if (word1.length == 0)     return word2.length
    if (word2.length == 0)      return word1.length
    let steps = 0;
    console.log(word1.charAt(word1.length) , word2.charAt(word2.length))

    if (word1.charAt(word1.length-1) == word2.charAt(word2.length-1)){
        return minDistance(word1.slice(0,word1.length-1),word2.slice(0,word2.length-1))
    } else{
        const options = [
            1+minDistance(word1.slice(0,word1.length),word2.slice(0,word2.length-1)),
            1+minDistance(word1.slice(0,word1.length-1),word2.slice(0,word2.length)),
            1+minDistance(word1.slice(0,word1.length-1),word2.slice(0,word2.length-1))
        ]
        let min = 9999
        options.forEach(option=>{if (option<min) min = option})
        console.log (min,word1,word2)
        return min
    }
    
};
