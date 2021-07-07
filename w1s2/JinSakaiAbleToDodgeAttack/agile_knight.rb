require_relative 'knight'

class AgileKnight < Knight
  def initialize(name, hitpoint, attack_damage, agility)
    super(name, hitpoint, attack_damage)
    @agility = agility
  end

  def damaged(damage)
    if dodgeable?
      dodge_attack
    else
      super
    end
  end

  def dodge_attack
    puts("#{@name} deflects the attack")
  end

  def dodgeable?
    rand(100) < @agility
  end
end
