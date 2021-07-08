require_relative './mongolian_warrior'

class Swordsman < MongolianWarrior
  def attack(other_knight)
    puts("#{@name} slashes #{other_knight.name} with #{@attack_damage} damage")
    super
  end
end
