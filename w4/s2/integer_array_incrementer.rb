class IntegerArrayIncrementer
  def increment(arr)
    arr[0..-2] + [arr[-1] + 1]
  end
end
