require_relative '../base_warrior'

class MongolianWarrior < BaseWarrior
  def initialize(name, hitpoint, attack_damage)
    super
    @has_fleed = false
  end

  def damaged(attack_damage)
    super
    try_to_flee if able_to_flee
  end

  def able_to_flee
    alive? && @hitpoint <= 50
  end

  def try_to_flee
    if rand(2) == 0
      @has_fleed = true
      puts("#{@name} has fled the battlefield with #{@hitpoint} hitpoints left")
      return true
    end

    return false
  end

  def in_battle?
    return !@has_fleed && super
  end
end
