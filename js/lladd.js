/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} l1
 * @param {ListNode} l2
 * @return {ListNode}
 */
var addTwoNumbers = function(l1, l2){
    addNumbers(l1,l2)
    return l1
}

function addNumbers(l1,l2,carry = 0) {
    if (!l1 && ! l2){
        return 0
    }
    l1.val = l1.val + l2.val + carry
    carry = 0;
    if ( l1.val > 9){
        carry = 1;
        l1.val = l1.val - 10
    }
    addNumbers(l1.next,l2.next,carry)
};
