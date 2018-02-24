#Given an integer matrix, find the length of the longest increasing path.
#
#From each cell, you can either move to four directions: left, right, up or down. You may NOT #move diagonally or move outside of the boundary (i.e. wrap-around is not allowed).
#
#Example 1:
#
#nums = [
#  [9,9,4],
#  [6,6,8],
#  [2,1,1]
#]
#Return 4
#The longest increasing path is [1, 2, 6, 9].#
#
#Example 2:

#nums = [
#  [3,4,5],
#  [3,2,6],
#  [2,2,1]
#]
#Return 4
#The longest increasing path is [3, 4, 5, 6]. Moving diagonally is not allowed.

#Credits:
#Special thanks to @dietpepsi for adding this problem and creating all test cases.



# solution
# khahns topological sort counting the steps

#this first translates the matrix into nodes with in and out connections depending on if they can connect to the next node.

#this will be a a cyclical directed graph as every new value has to be larger and so no value will ever lead to a previous value

#then find nodes with 0 connecitons, delete them and their entries in their inconnecionts.connections 

#khans algorithm is usually used for topological sorting, however if you think of the nodes with no out connections as each being the end of a path, counting the number of times you remove all nodes with 0 out connections gets you the number of steps of the longest path

def longest_increasing_path(matrix)
    nodes = Hash.new{|h,k| h[k] = Node.new(k)}
    width = matrix[1].length
    height = matrix.length
    matrix.each_with_index do |row,y|
       row.each_with_index do |val,x|
           node = nodes[[y,x]]
           right = matrix[y][x+1]
           left = matrix[y][x-1]
           # left = nil if (x-1 < 0)
           top = matrix[y+1] ? matrix[y+1][x] : nil
           bottom = matrix[y-1] ? matrix[y-1][x] : nil
           # bottom = nil if (y-1 < 0)
           if (right && right > val)
               node.connections.push(nodes[[y,x+1]])
               nodes[[y,x+1]].inconnections.push(node)
           end
           if ( (x-1)>=0 && left && left > val)
               node.connections.push(nodes[[y,x-1]])
               nodes[[y,x-1]].inconnections.push(node)
           end
           if (top && top > val)
               node.connections.push(nodes[[y+1,x]])
               nodes[[y+1,x]].inconnections.push(node)
           end
           if ( (y-1) >= 0 && bottom && bottom > val)
               node.connections.push(nodes[[y-1,x]])
               nodes[[y-1,x]].inconnections.push(node)
           end              
       end
    end
    nodeArr = nodes.values
    count = 0
    while (!nodeArr.empty?)
        count+=1     
        minNode = nodeArr.select{|node| node.connections.length == 0}
        minNode.each do |node|  
            node.destroy!
            nodeArr.delete(node)
        end
    end
    count
end
class Node
    attr_accessor :connections,:index,:inconnections
    def initialize(index)
        @index = index
        @connections = []
        @inconnections = []
    end
    def destroy!()
        @inconnections.each{|node| node.connections.delete(self)}
    end
    
    def inspect
        p ["index",@index,"connections",@connections.map{|a|a.index},"inconnections",@inconnections.map{|a|a.index}]
    end
end
