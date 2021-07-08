class Army
  def initialize(army)
    @army = army
  end

  def attack(enemy_army)
    @army.each do |warrior|
      warrior.take_turn(enemy_army, self)
      break unless enemy_army.able_to_war?
    end
  end

  def able_to_war?
    @army = @army.select { |warrior| warrior.in_battle? }
    @army.length.positive?
  end

  def to_s
    @army.map.with_index { |warrior, idx| "#{idx + 1}) #{warrior.name}" }.join("\n")
  end

  def length
    @army.length
  end

  def get(idx, exlude = [])
    (@army - exlude)[idx]
  end

  def sample
    @army.sample
  end

  def check_army
    @army.each do |warrior|
      puts(warrior)
    end
    puts
  end

  def print_list(exclude = [])
    (@army - exclude).each_with_index do |warrior, idx|
      puts("#{idx + 1}) #{warrior.name}")
    end
  end
end
