
 */https://leetcode.com/problems/maximum-gap/description/

Given an unsorted array, find the maximum difference between the successive elements in its sorted form.

Try to solve it in linear time/space.

Return 0 if the array contains less than 2 elements.

You may assume all elements in the array are non-negative integers and fit in the 32-bit signed integer range.

Credits:
Special thanks to @porker2008 for adding this problem and creating all test cases.



the (only?) real solution is to do something like radix sort which has linearish time complexity (definetely in this case where you know that every number has defineite max (32bit int)). If you can sort array in linear time, you just need one more pass to find max-diff between 2 consecutive elements; 

const maximumGap = function(nums) {
//   radix sort nums, then find max dif
    // raxis sort
//     iterate through digits of all entires of nums, sort first digits place, then 10s, then 100s, etx
//     at the end you have a linearish complexity sort
    
    
//     iterate from 1 to log(max(NUMS)), which is basically iterating through digit spot in entries of nums
    const max = Math.max(...nums);
    for(let exp = 1; Math.round(max/exp) > 0; exp = exp * 10){
//         ccount sort current digit spot
        nums = countSort(nums,exp);
    }
    let maxdif = 0
    return nums.reduce((acc,el,i,arr)=>{return Math.max(acc,el-(arr[i-1]||0))},0)
};

// pulls digit out using a devisor (devisor = 1 will get 1's digit. devisor=10 will get 10s digit, etc)
getDigit = (num, devisor) =>Math.round((num/devisor)) % 10


// sorts list by devisor spot digit, as in if devisor is 10 will sort arr by 10s digit spot. 
const countSort = function (arr,devisor){
    const ans = []
    const digits = new Array(10);
//     intitialize digit counters to 0
    for (let i = 0; i < 10; i++){
        digits[i]=0;   
    }
//     count digits
    arr.forEach((el)=>{
        digits[getDigit(el, devisor)] += 1
    });
//     adjust counts
//     every spot will have the idnex of the end of its sequence in the ans array
    for(let i = 1; i<digits.length; i++){
        digits[i] = digits[i] + digits[i-1] 
    }
//     build answer
    // arr.forEach((el)=>{
    for(let i = arr.length-1;i>-1 ; i--){
        const digit = getDigit(arr[i], devisor)
        const arrSpotCount = --digits[digit]
        ans[arrSpotCount] = arr[i];
        
    };
    return ans;
    
}
