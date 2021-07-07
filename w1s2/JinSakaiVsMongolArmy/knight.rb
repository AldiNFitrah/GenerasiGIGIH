class Knight
  attr_reader :name

  def initialize(name, hitpoint, attack_damage)
    @name = name
    @hitpoint = hitpoint
    @attack_damage = attack_damage

    puts "#{self}\n\n"
  end

  def attack(other_knight)
    puts "#{@name} attacks #{other_knight.name} with #{@attack_damage} damage"
    other_knight.damaged(@attack_damage)
  end

  def damaged(damage)
    @hitpoint -= damage
    puts "#{self}\n\n"

    puts "#{@name} dies" unless alive?
  end

  def to_s
    "#{@name} has #{@hitpoint} hitpoints and #{@attack_damage} attack damage"
  end

  def alive?
    @hitpoint.positive?
  end

  def in_battle?
    alive?
  end
end
