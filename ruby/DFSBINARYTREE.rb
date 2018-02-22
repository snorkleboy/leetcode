# https://leetcode.com/problems/find-bottom-left-tree-value/description/
# Given a binary tree, find the leftmost value in the last row of the tree.

# Example 1:
# Input:

#     2
#    / \
#   1   3

# Output:
# 1
# Example 2: 
# Input:

#         1
#        / \
#       2   3
#      /   / \
#     4   5   6
#        /
#       7

# Output:
# 7
# Note: You may assume the tree (i.e., the given root node) is not NULL.

# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end
# 
# SOLUTION
# same as finding the height of a tree, but you want to do it from the left so that the first time you check a new depth level you start with the left most node of that depth
# 
# this basically creates a recursive queue of nodes to check, going leftmost first. Every call comes with a Left-bottom-most object, which stores a value and a depth.
# if the depth of the current call is more than the depth of the LBM, then update the lbm with the value and depth of the current node. Then 
#  recurse to the .left and .right node. the first time a new depth is reached the value fo that node is stored in LBM and its going left to right so that 
# value should be the left most. 
# 
# @param {TreeNode} root
# @return {Integer}
def find_bottom_left_value(root)
    dfs(root,0,LBM.new(root.val,0))
end
class LBM
    attr_accessor :value,:depth
    def initialize(value,depth)
        @value = value
        @depth = depth
    end
end
def dfs ( node, depth, lbm)
    if ( node == nil)
        return lbm
    elsif(lbm.depth < depth + 1)
        lbm.depth = depth + 1
        lbm.value = node.val
    end
    dfs(node.left, depth + 1, lbm)
    dfs(node.right, depth + 1, lbm)
    lbm.value
end



# Find Largest Value in Each Tree Row
# You need to find the largest value in each row of a binary tree.

# Example:
# Input: 

#           1
#          / \
#         3   2
#        / \   \  
#       5   3   9 


# solution
# similar to above
# visit each node, keep hash of {level=> value}
# if visited nodes value is more than hash[level] then update it
# 
# 

# Output: [1, 3, 9]

# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @return {Integer[]}
def largest_values(root)
   levels ={0=>root.val}
    recScan(root,0,levels)
end

def recScan(node,depth,levelVals)
    if (node == nil)
        return levelVals
    end
    if (levelVals[depth] == nil || levelVals[depth] < node.val)
        levelVals[depth] = node.val
    end
    recScan(node.left,depth + 1, levelVals)
    recScan(node.right,depth + 1, levelVals)
    levelVals.values
end