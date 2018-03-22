binary search

function binSearch(arr,target){
    if (arr.length<1) return false
    const mp = parseInt(arr.length/2)
    const mpEl = arr[mp]
    if ( mpEl === target){
        return mpEl
    } else if (mpEl > target){
        return binSearch(arr.slice(0,mp),target);
    } else{
        return binSearch(arr.slice(mp+1,arr.length),target);
    }
   
}


ar = [1,2,3,4,5,6,7,8,9,10,11]
console.log(binSearch(ar,4))
