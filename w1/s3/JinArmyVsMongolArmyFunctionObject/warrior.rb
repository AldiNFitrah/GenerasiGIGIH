require_relative 'base_warrior'

class Warrior < BaseWarrior
  def attack(other_warrior)
    puts("#{@name} attacks #{other_warrior.name} with #{@attack_damage} attack damage")
    super
  end

  protected
  def get_treatment(treatment_amount)
    @hitpoint += treatment_amount
  end
end
