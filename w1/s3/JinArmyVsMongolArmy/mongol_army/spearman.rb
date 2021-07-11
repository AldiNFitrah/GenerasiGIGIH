require_relative './mongolian_warrior'

class Spearman < MongolianWarrior
  def attack(other_knight)
    puts("#{@name} thrusts #{other_knight.name} with #{@attack_damage} damage")
    super
  end
end
