require_relative 'mongolian_knight'

class Swordsman < MongolianKnight
  def attack(other_knight)
    puts "#{@name} cuts #{other_knight.name}"
    super
  end
end
