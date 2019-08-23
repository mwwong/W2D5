class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max, false)

  end

  def insert(num)
    if is_valid?(num)
      @store[num] = true
    else
      raise "Out of bounds"
    end
  end

  def remove(num)
    if is_valid?(num)
    @store[num] = false
    else
      raise "Out of bounds"
    end
  end

  def include?(num)
    if is_valid?(num)
      return @store[num]
    else 
      raise "Out of bounds"
    end
  end

  private

  def is_valid?(num)
    max = @store.length
    (0...max).include?(num)
  end

  def validate!(num)
    #LATER
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] << num
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
     @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !self.include?(num)
      if num_buckets == count
        resize!
      end
      @store[num % num_buckets] << num
      @count += 1
    end
  end

  def remove(num)
    if self.include?(num)
      @store[num % num_buckets].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    #if self.count <
    new_store = Array.new(num_buckets * 2) { Array.new }
    self.store.each do | bucket |
      bucket.each do | num |
        new_store[num % (num_buckets * 2)] << num
      end
    end
    @store = new_store
  end
end
