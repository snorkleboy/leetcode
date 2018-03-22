Gets Kth smallest element out of array

solution:

build heap, extract K times, results in (n+klog(n)) time, n to build klog(n) to extract k times


function Heap(arr){
    this.heap = [];
    this.heap = this.makeHeap(arr)
    this.length = ()=>this.heap.length
}
Heap.prototype.makeHeap = function (arr){
    heap = [arr.shift()]
    arr.forEach(el=>{
        heap.push(el);
        heapUp(heap);
    })
    return heap;
}
Heap.prototype.push = function(el){
    this.heap.push(el);
    heapUp(this.heap);
}
Heap.prototype.extractMin = function(){
//     swap first and last elements
    const temp = this.heap[0]
    this.heap[0] = this.heap[this.heap.length-1] ;
    this.heap[this.heap.length-1] = temp;     

//  last element is what used to be root, the minimum;
// pop it off and save it as the answer, then heap down the heap;
    let ans = this.heap.pop();
    heapDown(this.heap);
    return ans;
}


// private heap functions;
function heapDown(arr){
    elI = 0
    let child = getMinChild(0,arr);
    while (child < arr.length && arr[child] < arr[elI]){
        const temp = arr[child]
        arr[child] = arr[elI];
        arr[elI] = temp
        elI = child;
        child = getMinChild(elI,arr);
    }
}
function heapUp(arr){
    let elI = arr.length-1
    let parentI = getParent(elI);
    while (parentI > -1 && arr[elI] < arr[parentI]){
        const temp = arr[parentI]
        arr[parentI] = arr[elI];
        arr[elI] = temp
        elI = parentI;
        parentI = getParent(parentI);
    }
}
function getChilds(i){
    return [i*2+1,i*2+2]
}
function getMinChild(i,arr){
    const childI = getChilds(i)
    if (!arr[childI[0]]) return childI[0]
    if (!arr[childI[1]]) return childI[1]
    return arr[childI[0]] < arr[childI[1]] ? 
        childI[0]
    :
        childI[1];
}
function getParent(i){
    return Math.floor((i-1)/2)
}



// getKmin
// make heap, extract k times, return last value extracted
function getKMin(arr,k){
    let ans = null;
    if (k > arr.length) return ans;
    const heap = new Heap(arr);
    for (let i =0; i< k; i++){
        ans = heap.extractMin();
    } 
    return ans;
}

array = [9,8,7,6,4,7,6,5,3,3];
spot = 1;
(()=> [getKMin(array,spot), array.sort()[spot-1]])()



