module Enumerable
  def my_each
    return to_enum (:my_each) unless block_given?

    arr = self
    arr = arr.to_a if arr.class == Range
    arr = arr.to_a if arr.class == Hash

    for item in arr
      yield item
    end
    self
  end

  #array = [1, 2, 3, 4]
  #array.my_each { |x| p x + 1 }

  def my_each_with_index
    length.times do |index|
      yield self[index], index
    end
  end

  #array = [1, 2, 3, 4]
  #array.my_each_with_index { |x, i| puts ("element #{x} at index #{i}") }

  def my_select
    selected = []
    my_each do |ele|
      selected.push(ele) if yield ele
    end
    selected
  end

  #array = [1, 2, 3, 4]
  #p array.my_select { |x| x % 2 == 0 }

  def my_all?
    my_each do |item|
      return false unless yield(item)
    end
    true
  end

  #array = [1, 1, 1, 1]
  #p array.my_all? { |x| x == 1 }
  #p array.my_all? { |x| x == 2 }

  def my_any?
    my_each do |ele|
      return true if yield ele
    end
    false
  end

  #array = [1, 2, 3, 4]
  #p array.my_any? { |x| x == 7 }
  #p array.my_any? { |x| x == 3 }

  def my_none?
    my_each do |item|
      return true unless yield(item)
    end
    false
  end

  #array = [1, 2, 3, 4]
  #p array.my_none? { |x| x == 7 }
  #p array.my_none? { |x| x == 3 }

  def my_count
    count = 0
    my_each do |item|
      count += 1 if yield item
    end
    count
  end

  #array = [1, 7, 3, 7]
  #p array.my_count { |x| x == 7 }

  def my_map
    new_arr = []
    my_each do |item|
      new_arr << yield(item)
    end
    new_arr
  end

  #array = [1, 7, 3, 7]
  #p array.my_map { |x| x * 7 }

  def my_inject
    result = 0
    my_each do |i|
      result = yield result, i
    end
    result
  end

  def my_inject(*arg)
    begin
      if arg.length.positive?
        accumulator = arg[0]
        i = 0
      elsif arg.length.zero?
        accumulator = first
        i = 1
      end

      (i..(size - 1)).my_each do |index|
        accumulator = yield accumulator, *self[index]
      end
      accumulator
    rescue LocalJumpError
      puts "Please pass a block to this method!"
    rescue NoMethodError
      puts "Only concatination(+) would work for non-integers"
    end
  end
end

# array = [2, 3, 4]
# p array.my_inject { |x, y| x / y}
