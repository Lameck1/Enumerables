module Helper
  def self.match_by_type_all(arg, type)
    case type
    when Regexp
      arg.my_each do |item|
        return false unless type.match(item.to_s)
      end
    when Class
      arg.my_each do |item|
        return false unless item.is_a?(type)
      end
    else
      arg.my_each do |item|
        return false unless item == type
      end
    end
    true
  end

  def self.match_by_type_any(arg, type)
    case type
    when Regexp
      arg.my_each do |item|
        return true if type.match(ele.to_s)
      end
    when Class
      arg.my_each do |item|
        return true if ele.is_a?(type)
      end
    else
      arg.my_each do |item|
        return true if item == type
      end
    end
    false
  end
end
