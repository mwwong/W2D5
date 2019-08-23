require 'byebug'
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.

    # self.prev = self.next
  end
end

class LinkedList
  include Enumerable
  attr_reader :Sentinel, :nodes, :head, :tail
  def initialize
    @head = Node.new
    @tail= Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    ##gger
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    head_next = head.next
    return head_next == tail 
  end

  def get(key)
    search_node = head
    until search_node == tail
      return search_node.val if search_node.key == key
      search_node = search_node.next
    end
    return nil
  end

  def include?(key)
    search_node = head
    until search_node == tail
      return true if search_node.key == key
      search_node = search_node.next
    end
    return false
  end

  def append(key, val)
    before_tail = @tail.prev
    append_node = Node.new(key, val)
    before_tail.next = append_node
    append_node.prev = before_tail
    append_node.next = @tail
    @tail.prev = append_node
  end

  def update(key, val)
     if self.include?(key)
        search_node = head
        until search_node == tail
          if search_node.key == key
            search_node.val = val
          end
          search_node = search_node.next
        end
      end
  end

  def remove(key)
    search_node = head
    until search_node == tail
      if search_node.key == key
        search_node.prev.next = search_node.next
        search_node.next.prev = search_node.prev
      end
      search_node = search_node.next
    end
  end

  def each
    search_node = first
    until search_node == tail
      yield search_node
      search_node = search_node.next
    end
  end

  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
