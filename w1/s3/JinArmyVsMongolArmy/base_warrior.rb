class BaseWarrior
  attr_reader :name

  def initialize(name, hitpoint, attack_damage)
    @name = name
    @hitpoint = hitpoint
    @attack_damage = attack_damage
  end

  def take_turn(enemy_army, *_args, **_kwargs)
    warrior_to_be_attacked = enemy_army.sample
    attack(warrior_to_be_attacked)
  end

  def attack(other_warrior)
    other_warrior.damaged(@attack_damage)
  end

  def damaged(damage)
    @hitpoint -= damage

    if !alive?
      puts("#{@name} dies")
    end
  end

  def to_s
    return "#{@name} has #{@hitpoint} hitpoints and #{@attack_damage} attack damage"
  end

  def alive?
    return @hitpoint.positive?
  end

  def in_battle?
    return alive?
  end
end
