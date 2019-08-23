require_relative 'p04_linked_list'
require "byebug"
class HashMap
  attr_accessor :count
  include Enumerable
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    correct_bucket = bucket(key)
    bucket_content = @store[correct_bucket]
    bucket_content.include?(key)  
   # @store[correct_bucket].include?(key.hash)    
  
  end

  def set(key, val)
    if self.include?(key)
      correct_bucket = bucket(key)
      @store[correct_bucket].update(key, val)
    else
      if num_buckets == count
        # debugger
        resize!
      end
      correct_bucket = bucket(key)
      @store[correct_bucket].append(key, val)
      @count += 1
    end
  end

  def get(key)
    correct_bucket = bucket(key)
    return @store[correct_bucket].get(key)
  end

  def delete(key)
    if self.include?(key)
      correct_bucket = bucket(key)
      @store[correct_bucket].remove(key)
      @count -= 1
    end
  end

  def each
    #debugger
    @store.each do | bucket |
      #debugger
      bucket.each do | pairs | 
        yield pairs.key, pairs.val
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { LinkedList.new }
    # debugger
    self.each do |k,v|
      # debugger
      correct_bucket = k.hash % (num_buckets * 2)
      new_store[correct_bucket].append(k,v)
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    hash_key = key.hash
    bucket = hash_key % num_buckets
    return bucket
  end
end
