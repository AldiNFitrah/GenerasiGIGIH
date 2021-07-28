require ""

describe IntegerArrayIncrementer do
  it 'given [0] should return [1]' do
    input = [0]
    expected_output = [1]

    actual_output = IntegerArrayIncrementer.new.increment(input)

    expect(actual_output).to(eq(expected_output))
  end
end
