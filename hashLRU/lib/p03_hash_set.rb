class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !self.include?(key)
      if num_buckets == count
        resize!
      end
      hash_key = key.hash
      @store[hash_key % num_buckets] << hash_key
      @count += 1
    end
  end

  def include?(key)
    hash_key = key.hash
    @store[hash_key % num_buckets].include?(hash_key)
  end

  def remove(key)
    if self.include?(key)
      hash_key = key.hash
      @store[hash_key % num_buckets].delete(hash_key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
  new_store = Array.new(num_buckets * 2) { Array.new }
    self.store.each do | bucket |
      bucket.each do | ele |
        new_store[ele % (num_buckets * 2)] << ele
      end
    end
    @store = new_store
  end
end
