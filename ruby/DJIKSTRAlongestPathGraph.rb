# There are N network nodes, labelled 1 to N.

# Given times, a list of travel times as directed edges times[i] = (u, v, w), where u is the source node, v is the target node, and w is the time it takes for a signal to travel from source to target.

# Now, we send a signal from a certain node K. How long will it take for all nodes to receive the signal? If it is impossible, return -1.

# Note:
# N will be in the range [1, 100].
# K will be in the range [1, N].
# The length of times will be in the range [1, 6000].
# All edges times[i] = (u, v, w) will have 1 <= u, v <= N and 1 <= w <= 100.


# @param {Integer[][]} times
# @param {Integer} n
# @param {Integer} k
# @return {Integer}

# solution 1
# if you have the shortest path to each vertex from the source, then the longest path is the time it will take for everyone 
#  to get the message

# start with first vertex
# go to all children vertex, if the distance to current vertex + distance to child < childs.distance, then you know that your on the shortest path to that vertex
#  and you want to continue along the path by doing the same process to this childs children
# when you run out of nodes every node is either disconnected or has the shortest path
# the longest shortest path is yout answer (or -1)
def firstSol(times,n,k)
        shortestDist = Hash.new{|h,k| h[k]=99999}
    shortestDist[k]=0
    checkQ = [[k]]
    
    while (!checkQ.empty?)
        curr = checkQ.shift()[0]
        children = get_children(times,curr)
        #  each child is [src,dest,weight]. 
        #  if this.distence + distence to child < child.distence :then: child.distence = this.distence+distence to this.child
        children.each do |child|
            distence_to_child = shortestDist[curr] + child[2]
            child_i = child[1]
            if distence_to_child < shortestDist[child_i]
                shortestDist[child_i] = distence_to_child
                checkQ.concat(get_children(times,child_i).sort)
            end                
        end
    end
  # now if shortestdist.values.length isnt equal to n some nodes are unreachable. Otherwise largest value is how long it will take for everyone to get the signal
    shortestTimes = shortestDist.values
    if (shortestTimes.length != n)
        return -1
    else
        longest = 0
        shortestTimes.each{|time| longest = time if time > longest}
        return longest
    end
    
end

def get_children(times,src)
    times.select{|edge| edge[0] == src}
end

# solution 2
# solution 1 didnt work fast enough, probably becuase get_children need to scan through every edge, so on a dense large N graph it would taker forever
# this solution instead used a linked list style graph, each node has children with weights. 
# same general algorithm
# only special thing is that in the nodeBuilding process I need to keep a list of nodes anyways, so I return that so you
# can return -1 if there is a node that wasnt mentioned ( a node can be disconnected from another node by having no edges and so will not be in the times array given and no node will be built for it)
def network_delay_time(times, n, k)
    nodes = buildNodes(times,k)
    root = nodes[k]
    root.distance = 0
    checkQ = [root]
    while (!checkQ.empty?)
        curr = checkQ.shift()
        curr.children.keys.each do |child|
            curr_to_child_distance = curr.distance + curr.children[child]
            if  curr_to_child_distance < child.distance
                child.distance = curr_to_child_distance
                checkQ.push(child)
            end
        end
    end
    nodeDistances = nodes.values
    if (nodeDistances.length != n)
        return -1
    else
        longest = 0
        nodeDistances.each{|node| time = node.distance;longest = time if time > longest} 
        longest == 999 ? -1 : longest
    end
end


class Vertex

    attr_accessor :children, :distance, :index
    def initialize(index,distance)
        @index = index
        @distance = distance
        @children = {}
    end
    
    def addEdge(vertex,weight)
        @children[vertex] = weight
    end
    def inspect
        [@index,@distance]
    end
end
def buildNodes(times,start)
    nodes=Hash.new{|h,k| h[k] = Vertex.new(k,999)}
    times.each do |time|
       nodes[time[0]].addEdge(nodes[time[1]], time[2])
    end
    
    return nodes
end
