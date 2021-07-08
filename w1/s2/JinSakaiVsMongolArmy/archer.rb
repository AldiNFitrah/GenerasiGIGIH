require_relative 'mongolian_knight'

class Archer < MongolianKnight
  def attack(other_knight)
    puts "#{@name} shoots #{other_knight.name}"
    super
  end
end
