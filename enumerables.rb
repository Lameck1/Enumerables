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

end



arr = ["Tom", "Bob", "Marley"]
# arr.my_each do |x|
#   puts x + 10
# end

arr.my_select{|person| person != "Tom"}
