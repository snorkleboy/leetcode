/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} head
 * @param {number} n
 * @return {ListNode}
 */
var removeNthFromEnd = function(head, n) {
    let forwardPtr = head.next
    let backPtr = head
    if (forwardPtr === null){
        return null
    }
    for(let i = 1; i < n ; i++){
        forwardPtr = forwardPtr.next
    }
    if (forwardPtr === null){
        return n===1 ? backPtr : backPtr.next
    }
        console.log(backPtr.val,forwardPtr.val)

    while (forwardPtr.next !== null){
        forwardPtr = forwardPtr.next
        backPtr = backPtr.next
    }
    //backPtr should be pointing to parent of node to delete at this point
    console.log(backPtr.val,forwardPtr.val)
    SliceOut(backPtr)
    return head
};


function SliceOut(grandParent){
    const oldChild = grandParent.next
    const newChild = oldChild.next
    grandParent.next = newChild
    oldChild.next = null
}
