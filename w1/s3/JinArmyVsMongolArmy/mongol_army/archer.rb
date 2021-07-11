require_relative './mongolian_warrior'

class Archer < MongolianWarrior
  def attack(other_knight)
    puts("#{@name} shoots #{other_knight.name} with #{@attack_damage} damage")
    super
  end
end
