class IntegerArrayIncrementer
  def increment(arr)
    new_arr = arr[0..-2] + [arr[-1] + 1]

    if new_arr[-1] == 10 then
      return [1, 0]
    end

    return new_arr
  end
end