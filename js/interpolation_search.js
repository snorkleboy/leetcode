https://www.geeksforgeeks.org/interpolation-search/
Interpolation Search
Given a sorted array of n uniformly distributed values arr[], write a function to search for a particular element x in the array.

Linear Search finds the element in O(n) time, Jump Search takes O(√ n) time and Binary Search take O(Log n) time.
The Interpolation Search is an improvement over Binary Search for instances, where the values in a sorted array are uniformly distributed. Binary Search always goes to middle element to check. On the other hand interpolation search may go to different locations according the value of key being searched. For example if the value of key is closer to the last element, interpolation search is likely to start search toward the end side.

To find the position to be searched, it uses following formula.

// The idea of formula is to return higher value of pos
// when element to be searched is closer to arr[hi]. And
// smaller value when closer to arr[lo]
pos = lo + [ (x-arr[lo])*(hi-lo) / (arr[hi]-arr[Lo]) ]

arr[] ==> Array where elements need to be searched
x     ==> Element to be searched
lo    ==> Starting index in arr[]
hi    ==> Ending index in arr[]
Algorithm
Rest of the Interpolation algorithm is same except the above partition logic.

Step1: In a loop, calculate the value of “pos” using the probe position formula.
Step2: If it is a match, return the index of the item, and exit.
Step3: If the item is less than arr[pos], calculate the probe position of the left sub-array. Otherwise calculate the same in the right sub-array.
Step4: Repeat until a match is found or the sub-array reduces to zero.


SOLUTION:
the idea is like binary search, but you find element by thier range the array domain. IE if array is [0..9] and someone asks you if 7 is in the array, you could just look up arr[7], since there is a 1:1 relationship between index positions and values. 

if the array is [10,12,14,16,18,20], there are 5 index positions, and values in the range of 10-20. arr.length/(arr.max-arr.min) = 5/(20-10)=.5 = mapCon will be a ratio of index to value starting at the min.

 

so target - arr.min gets the targets position in the arr range. (target-arr.min) * (arr.length/(arr.max-arr.min) would get you the index position in the array.

if you are searching for 16, (16 - arr.min) * mapCon =  (16-10)*.5 = 3
arr[3] === 6 

function interpolSearch(arr, target){
    if (arr.length < 1){
        return false
    }
    const mapCon = arr.length/(arr[arr.length-1]-arr[0]);
    const mapI = parseInt(mapCon * (target-arr[0]))
    const mappedValue = arr[mapI];
    if (mappedValue === target ){
       return target
    } else if (mappedValue < target){
       return interpolSearch(arr.slice(mapI,arr.length),target)
    } else {
       return interpolSearch(arr.slice(0,mapI),target);
    }
}

 array =  [10, 12, 13, 16, 18, 19, 20, 21, 22, 23,
                  24, 33, 35, 42, 47]

 interpolSearch(array, 15)
