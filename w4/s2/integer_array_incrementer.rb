class IntegerArrayIncrementer
  def increment(arr)
    new_arr = arr[0..-2] + [arr[-1] + 1]

    current_idx = arr.length - 1

    until new_arr[current_idx] != 10 || current_idx < 0 do
      new_arr[current_idx] = 0

      if current_idx - 1 < 0 then
        new_arr.unshift(1)
      else
        new_arr[current_idx - 1] += 1
      end

      current_idx -= 1
    end

    return new_arr
  end
end
