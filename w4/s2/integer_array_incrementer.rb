class IntegerArrayIncrementer
  def increment(arr)
    new_arr = arr[0..-2] + [arr[-1] + 1]

    if new_arr[-1] == 10 then
      if new_arr.length == 1 then
        return [1, 0]
      elsif new_arr.length == 2 then
        if new_arr[0] == 9
          return [1, 0, 0]
        else
          return [new_arr[0] + 1, 0]
        end
      end
    end

    return new_arr
  end
end
