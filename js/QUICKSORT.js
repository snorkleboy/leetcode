function swap(i,j,arr){
    const temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp
}
function getRandomInt(max) {
  return Math.floor(Math.random() * Math.floor(max));
}

//https://www.geeksforgeeks.org/quick-sort/

//QUICKSORT SOLUTION
//left has everything less than pivot, right everything more than pivot,
//recurse the same process on left and right, answer is [...left,pivot,...right]

//quick sort with making new array
function quickSort (arr){
    if (arr.length < 2 ){
        return arr;
    }
    const pivotEl = arr[0];
    let left = [];
    let right = []
    for(let i =1;i<arr.length;i++){
        arr[i] < pivotEl ?
            left.push(arr[i])
        :
            right.push(arr[i])
        ;     
    }
    left = quickSort(left);
    right = quickSort(right);

    return [...left,pivotEl,...right]
}

//in place, pivot starting from high
function quickSort (arr,low = 0,high = arr.length-1){
    if (low>= high){
        return
    }
    const pivotI = high
    let smallers = 0;
    for (let i = low; i <= high; i++){
        if ( arr[i] < arr[pivotI]){
            swap(low+smallers,i,arr)
            smallers += 1;
        }

    }
    const newPivotI = low+smallers
    swap(pivotI,newPivotI,arr);

    quickSort(arr,low,newPivotI-1);
    quickSort(arr,newPivotI+1,high);
    return arr;

}
//in place from random pivot
// made it work by just swapping the random pivot to the end of the array and then doing the same thing as in the previous version

//eliminates worst case scenario of [1,2,3,4,5...] which would have o(n^2)
counter = 0
function quickSort (arr,low = 0,high = arr.length-1){
    counter++
    if (counter > 20){
        return counter
    }
    if (low>= high){
        return
    }
    const firstPivI = getRandomInt(high-low)+low
    swap(firstPivI,high,arr);
    const pivotI = high
    let smallers = 0;
    for (let i = low; i <= high; i++){
        if ( arr[i] < arr[pivotI]){
            swap(low+smallers,i,arr)
            smallers += 1;
        }

    }
    const newPivotI = low+smallers
    swap(pivotI,newPivotI,arr);

    quickSort(arr,low,newPivotI-1);
    quickSort(arr,newPivotI+1,high);
    return arr;

}




array = [5,2,3,6,4,3,54,64,3]
quickSort(array);
