class Array
  def my_each
    each do |item|
      yield(item)
    end
  end

  def my_each_with_index
    length.times do |index|
      yield self[index], index
    end
  end

  def my_select
    selected = []
    my_each do |ele|
      selected.push(ele) if yield ele
    end
    p selected
  end

  def my_all?
    each do |item|
      return false unless yield(item)
    end
    true
  end

  def my_any?
    my_each do |ele|
      return true if yield ele
    end
    false
  end

  def my_none?
    each do |item|
      return true unless yield(item)
    end
    false
  end


end

arr = [1,1,1,1]
# arr.my_each do |x|
#   puts x + 10
# end

p arr.my_none? { |ele| ele == 2 }
