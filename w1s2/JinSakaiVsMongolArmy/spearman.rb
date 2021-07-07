require_relative 'mongolian_knight'

class Spearman < MongolianKnight
  def attack(other_knight)
    puts "#{@name} thrusts #{other_knight.name}"
    super
  end
end
