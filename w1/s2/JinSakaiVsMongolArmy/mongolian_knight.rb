require_relative 'knight'

class MongolianKnight < Knight
  def initialize(name, hitpoint, attack_damage)
    super
    @has_fleed = false
  end

  def damaged(attack_damage)
    super
    try_to_flee if 0 < @hitpoint && @hitpoint <= 50
  end

  def try_to_flee
    if rand(2) == 0
      @has_fleed = true
      puts("#{@name} has fled the battlefield with #{@hitpoint} hitpoints left")
      return true
    end

    false
  end

  def in_battle?
    super && !@has_fleed
  end
end
