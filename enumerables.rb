require_relative 'helpers'
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = self
    arr = arr.to_a if arr.class == Range
    arr = arr.to_a if arr.class == Hash

    size.times do |index|
      yield arr[index]
    end
    self
  end

  # array = [1, 2, 3, 4]
  # array.my_each { |x| p x.to_s  }

  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    arr = *self
    size.times do |index|
      yield arr[index], index
    end
    self
  end

  # array = [1, 2, 3, 4]
  # array.my_each_with_index { |x, i| puts ("element #{x} at index #{i}") }

  def my_select
    return to_enum(:my_each) unless block_given?

    selected = []
    my_each do |ele|
      selected.push(ele) if yield ele
    end
    selected
  end

  # array = [1, 2, 3, 4]
  # p array.my_select { |x| x % 2 == 0 }

  def my_all?(*arg)
    return Helper.match_by_type_all(self, arg[0]) if arg.length.positive?

    # block is not given and falsy element is found, => FALSE
    my_each { |item| return false unless item || block_given? }
    # block is not given and falsy element is not found, => TRUE
    return true unless block_given?

    my_each do |item|
      return false unless yield(item)
    end
    true
  end

  # array = [2, 7, 8, 9]
  # p array.my_all?(Numeric)
  # p array.my_all? { |x| x.length == 3}

  def my_any?(*arg)
    return Helper.match_by_type_any(self, arg[0]) if arg.length.positive?
    # block is not given and truthy element is found => TRUE
    my_each { |item| return true if item && !block_given? }
    # block is not given and truthy element is not found => FALSE
    return false unless block_given?

    my_each do |item|
      return true if yield item
    end
    false
  end

  # array = [1, 2, 3, 4]
  # p array.my_any? { |x| x == 7 }
  # p array.my_any? { |x| x == 3 }

  def my_none?
    my_each do |item|
      return true unless yield(item)
    end
    false
  end

  # array = [1, 2, 3, 4]
  # p array.my_none? { |x| x == 7 }
  # p array.my_none? { |x| x == 3 }

  def my_count
    count = 0
    my_each do |item|
      count += 1 if yield item
    end
    count
  end

  # array = [1, 7, 3, 7]
  # p array.my_count { |x| x == 7 }

  def my_map(*arg, &block)
    return to_enum(:my_each) unless block_given?

    # takes a proc or block, will only use proc if both are provided
    new_arr = []
    if arg.length.positive?
      proc = arg[0]
    elsif arg.length.zero? && block
      proc = block
    end
    my_each do |item|
      new_arr.push(proc.call(item))
    end
    new_arr
  end

  # array = [1, 7, 3, 7]
  # p array.my_map { |x| x * 7 }

  def my_inject(*arg)
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
    puts 'Please pass a block to this method!'
  rescue NoMethodError
    puts 'Only concatination(+) would work for non-integers'
  end
end

# array = [2, 3, 4]
# p array.my_inject { |x, y| x / y}
