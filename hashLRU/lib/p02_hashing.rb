class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    return 1 if self.length <1
    arr_hash = nil
    self.each_with_index do | el, idx |
        if idx == 0 
          arr_hash = el.hash + idx.hash
        else
          arr_hash = arr_hash ^ (el.hash + idx.hash)
        end     
    end
    return arr_hash
  end
end

class String
  def hash
    split_str = self.split("").map(&:ord)
    return split_str.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_hash = 0
    self.each do | k, v|
      hash_hash = hash_hash ^ (k.hash + v.hash)
    end
    if hash_hash.nil?
      return 0
    else 
      return hash_hash
    end
    #0
  end
end
