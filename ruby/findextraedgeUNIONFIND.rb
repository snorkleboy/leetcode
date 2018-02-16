# In this problem, a tree is an undirected graph that is connected and has no cycles.

# The given input is a graph that started as a tree with N nodes (with distinct values 1, 2, ..., N), with one additional edge added. The added edge has two different vertices chosen from 1 to N, and was not an edge that already existed.

# The resulting graph is given as a 2D-array of edges. Each element of edges is a pair [u, v] with u < v, that represents an undirected edge connecting nodes u and v.

# Return an edge that can be removed so that the resulting graph is a tree of N nodes. If there are multiple answers, return the answer that occurs last in the given 2D-array. The answer edge [u, v] should be in the same format, with u < v.

# Example 1:
# Input: [[1,2], [1,3], [2,3]]
# Output: [2,3]
# Explanation: The given undirected graph will be like this:
#   1
#  / \
# 2 - 3
# Example 2:
# Input: [[1,2], [2,3], [3,4], [1,4], [1,5]]
# Output: [1,4]
# Explanation: The given undirected graph will be like this:
# 5 - 1 - 2
#     |   |
#     4 - 3
# Note:
# The size of the input 2D-array will be between 3 and 1000.
# Every integer represented in the 2D-array will be between 1 and N, where N is the size of the input array.

# https://leetcode.com/problems/redundant-connection/description/

# solution

# iterate through the edges and keep and array that keeps track of 'roots'. A graph will have no true root, but you start somewhere, and and keep a list of
# 'super parents'. So if 1-2, 1 is twos parent, if 2-3, 1 is 2 and 3's parent and the parent array looks like [1,1,1]. If a node points to another node with the same super parent, then you are in 
#  a cycle. 

# this isnt a full union find, the union find algorythm keeps a similar kind of data structure, but the root element points to itself, so parent[root]==root.
# all nodes have thier direct parent listed, and you have a cycle when recusive calls like parent[parent[node]] dont reach a root node(a node where parent[node]==node)
 

def find_redundant_connection(edges)
    fromto=(1..edges.length+1).to_a
    edges.each do |edge|
       if (fromto[edge[1]] == fromto[edge[0]])
          return edge 
       else
           fromto[edge[1]] = fromto[edge[0]]
       end
       p fromto
    end
    false
end
