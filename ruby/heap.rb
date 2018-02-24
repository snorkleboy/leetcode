
class Node
    attr_accessor :connections,:index
    def initialize(k)
        @location = k
        @connections = []
        @inconnections = []
    end
    def destroy!()
        @inconnections.each{|node| node.connections.delete(@location)}
    end
end
#this min heap takes in a proc on init that tells it how to get a value from the objects it stores, the default is just using the value itself upon which > and < will be called

# min heap keeps a binary tree structure organization with log n remove and add functionality.
# the top is always the minimum by however the given block returns value from the objects

#the implimentation is
# starts empty,
# inserting item means putting it into the bottom and heaping-up, which means recursively swapping with is parent until its not out of place relative to its parent. This will maintain heap structure on insert in nlogn
# popping item means taking the bottom item and putting it into the top while popping the old top off. Then you heap-down, which means recuresively swapping the parent with its largest child until its not out of place relative to its children ( or at the bottom). this maintians heap structure in logn time
class MinHeap
    attr_accessor :objects
    def initialize(&proc)
        @valueAt = proc || Proc.new{|val| val}
        @objects = []
    end
    def empty?
       @objects.empty? 
    end
    def push(el)
      @objects.push(el)
      heap_up()
    end
    def pop
        return nil if @objects.empty? 
        return @objects.pop() if @objects.length == 1
        @objects[0],@objects[-1] = @objects[-1],@objects[0]
        root = @objects.pop()
        heap_down(0)
        root
    end
        
    def get_children_i(parent)
        return [parent*2+1, parent*2+2]
    end
    
    def get_parent(child)
        return (child-1)/2
    end
    def valueAt(i)
        i < @objects.length ? @valueAt.call(@objects[i]) : nil
    end
    
    def heap_up()
      child = @objects.length - 1
      parent = get_parent(child)
      while (child != 0 && valueAt(parent) > valueAt(child) )
        @objects[child],@objects[parent] = @objects[parent],@objects[child]
        child = parent
        parent = get_parent(child)
      end
    end
    def heap_down(i)
        j = smallest_child(i)
        if (j == i)
            return true
        else
            @objects[i],@objects[j] = @objects[j],@objects[i]
            heap_down(j)
        end        
    end
    
    def smallest_child(i)
        children = get_children_i(i)
        left = valueAt(children[0])
        right = valueAt(children[1])
        smallest = i
        if (left && left <= valueAt(smallest) )
            smallest = children[0]
        end
        if (right && right <= valueAt(smallest))
            smallest = children[1]
        end
        smallest
    end

end
    
