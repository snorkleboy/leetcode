# Given an array nums containing n + 1 integers where each integer is between 1 and n (inclusive), prove that at least one duplicate number must exist. Assume that there is only one duplicate number, find the duplicate one.

# Note:
# You must not modify the array (assume the array is read only).
# You must use only constant, O(1) extra space.
# Your runtime complexity should be less than O(n2).
# There is only one duplicate number in the array, but it could be repeated more than once.
# Credits:
# Special thanks to @jianchao.li.fighter for adding this problem and creating all test cases.

# SOLUTION

# proof that there must be a repeating number, and that all numbers are valid indexs
#     there are n+1 elementts, and n possible values, atleast 1 value must be repeated atleast once. 
#     of an array of size n will have n-1 possible values, which means that every value will be within (0...array.length).

# algorithm- CYCLE DETECTION

# the idea is to treat it as a linked list like data structure, where every array value
# is a pointer to another array index position. since we are guareenteed atleast on repition, that means that one index position will be linked to twice,
# which will form a cycle. If we use a cycle detection algoriythm to find the start of the cycle we will also have our duplicate value, in N time and 0 space .

# it works by starting two pointers. One will travel at 1 node per iteration, the other at twice that speed, two nodes per iteration. since we are guerenteed a cycle
# and these poitners have different speeds they are guerenteed to interesect, and thier first intersection is as far away from the start of the cycle ( the duplicate value)
# as the beginning of the array is. So one we have the intersection, if you go back to the start and iterate one by one from the start and the intersection point they will
# intersect at the cycle start.

# ie
# If the entire array is a cycle, the pointers speeds would be 1/length and 2/length, so thier difference is 1/length which means
#  it would take a full revolution to meet after the first intersection which would be at the start of the cycle and the duplicate value

#  If the entire arrray is not a cycle, the number of nodes before the start of the cycle get preserved in the offset from the start of the cycle. 
#  so if there are 5 nodes before the start of the cycle the intersection will eventually be 5 nodes before the start of the cycle. since you dont know when you are in 
#  the cycle until you have come back to some point already visited, you wouldnt have known its 5 nodes away.

#  but since the offset is equal to the number of nodes before the start of the cycle, if you walk new ptrs from the start and the intersection point
#  you will get a new intersection point at the cycle start 



def find_duplicate(nums)
    intersection = find_first_meeting(nums)
    find_cycle_start(nums,intersection)
end

def find_first_meeting(list)
    slow = list[0]
    fast = list[0]
    loop do 
        slow = list[slow]
        fast = list[list[fast]]
        break if (slow == fast)
    end 
    fast
end

def find_cycle_start(list,intersection)
    ptr1 = list[0]
    while (ptr1 != intersection)
        intersection = list[intersection]
        ptr1 = list[ptr1]
    end
    ptr1
end

find_duplicate ([1, 2, 3, 4, 5, 6 ,3])