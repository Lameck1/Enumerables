class Array
  def my_each
    for item in self
      yield(item)
    end
  end

  def my_each_with_index
    self.length.times do |index|
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

  def my_all
    for item in self
      return false unless yield(item) 
       
    end
true
  end

end

arr = ["Tom", "Tom", "Tom"]
# arr.my_each do |x|
#   puts x + 10
# end

p arr.my_all { |person| person == "Tom" }
