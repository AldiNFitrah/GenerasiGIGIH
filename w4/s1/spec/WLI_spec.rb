require_relative '../WLI.rb'

describe WLI do
  it 'contains 0 name will print no one' do
    wli = WLI.new

    expect(wli.likes).to(eq('no one likes this'))
  end

  it 'contains 1 name will print with s' do
    wli = WLI.new
    wli.names = ['Peter']
    expect(wli.likes).to(eq('Peter likes this'))
  end

  it 'contains 2 name will print without s' do
    wli = WLI.new
    wli.names = ['Jacob', 'Alex']
    expect(wli.likes).to(eq('Jacob and Alex like this'))
  end

  it 'contains 3 name will print without s' do
    wli = WLI.new
    wli.names = ['Max', 'John', 'Mark']
    expect(wli.likes).to(eq('Max, John and Mark like this'))
  end

  it 'contains 4 name will print only 2 names and like without s' do
    wli = WLI.new
    wli.names = ['Max', 'John', 'Mark', 'Alex']
    expect(wli.likes).to(eq('Max, John and 2 others like this'))
  end

  it 'contains 10 name will print only 2 names and like without s' do
    wli = WLI.new
    wli.names = ['Max', 'John', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']
    expect(wli.likes).to(eq('Max, John and 8 others like this'))
  end
end
