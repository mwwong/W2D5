require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'
class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      
        @store.append(key, @store.get(key))
        return @store.get(key)
    else
      if count == @max 
        eject!
      end
      calc!(key)
      @map.set(key, @store.last)#@store.get(key))
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    value = @prc.call(key)
    debugger
    @store.append(key,value)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
    lru_key = @store.first.key
    debugger
    @map.delete(lru_key)
    debugger
    @store.remove(lru_key)
  end
end
