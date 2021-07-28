require_relative "../integer_array_incrementer.rb"

describe IntegerArrayIncrementer do
  it 'given [0] should return [1]' do
    input = [0]
    expected_output = [1]

    actual_output = IntegerArrayIncrementer.new.increment(input)

    expect(actual_output).to(eq(expected_output))
  end

  it 'given [1] should return [2]' do
    input = [1]
    expected_output = [2]

    actual_output = IntegerArrayIncrementer.new.increment(input)

    expect(actual_output).to(eq(expected_output))
  end
  
  it 'given [9] should return [1, 0]' do
    input = [9]
    expected_output = [10]
  
    actual_output = IntegerArrayIncrementer.new.increment(input)
  
    expect(actual_output).to(eq(expected_output))
    input
  end
end
