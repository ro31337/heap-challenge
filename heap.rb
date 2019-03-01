class Heap
  def initialize(type = :min)
    @type = type
    if @type == :min
      @heap = [-1.0/0]
      @compare = ->(a,b) { (a.time <=> b.time) < 0 }
    elsif @type == :max
      @heap = [1.0/0]
      @compare = ->(a,b) { (b.time <=> a.time) > 0 }
    else
      raise "Unknown heap type"
    end
    @last = 0
  end
  
  def push(value)
    @last += 1
    @heap[@last] = value
    bubble_up(@last)
    @last
  end
  
  def peek
    @heap[1]
  end
  
  def pop
    return nil if @last == 0
    value = @heap[1]
    @heap[1] = @heap[@last]
    @last -= 1
    bubble_down(1)
    value
  end
  
  def size
    @last
  end
  
private
  def bubble_up(child)
    return if child == 1
    parent_index = parent(child)
    if @compare[@heap[child], @heap[parent_index]]
      @temp = @heap[child]
      @heap[child] = @heap[parent_index]
      @heap[parent_index] = @temp
      bubble_up(parent_index)
    end
  end
  
  def bubble_down(parent_index)
    return if parent_index > parent(@last) 
    left = left_child(parent_index)
    right = right_child(parent_index)
    
    if right > @last
      child = left
    else
      child = @compare[@heap[left], @heap[right]] ? left : right 
    end
    
    if @compare[@heap[child], @heap[parent_index]]
      @temp = @heap[child]
      @heap[child] = @heap[parent_index]
      @heap[parent_index] = @temp
      bubble_down(child)
    end
    
  end
    
  def parent(index)
    index / 2
  end
  
  def left_child(index)
    2 * index
  end
  
  def right_child(index)
    2 * index + 1
  end
end