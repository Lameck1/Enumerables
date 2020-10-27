class Array
  def my_each
    for item in self
      yield(item)
    end
  end
end

arr = [1, 2, 3]
arr.my_each do
  |x| 
  puts x + 10
  end

  class Array
    def my_each_with_index
      for item in self
        yield(item)
      end
    end
  end