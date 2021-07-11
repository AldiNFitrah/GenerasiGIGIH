class Army
  def initialize(army)
    @army = army
  end

  def attack(enemy_army)
    @army.each do |warrior|
      warrior.take_turn(enemy_army, self)

      if !enemy_army.able_to_war?
        break
      end
    end
  end

  def able_to_war?
    @army = @army.select { |warrior| warrior.in_battle? }
    return @army.length.positive?
  end

  def to_s
    return @army.map.with_index(1) { |warrior, idx| "#{idx}) #{warrior.name}" }.join("\n")
  end

  def length(exclude = [])
    return (@army - exclude).length
  end

  def get(idx, exlude = [])
    return (@army - exlude)[idx]
  end

  def sample
    return @army.sample
  end

  def check_army
    @army.each do |warrior|
      puts(warrior)
    end
    puts
  end

  def print_list(exclude = [])
    (@army - exclude).each.with_index(1) do |warrior, idx|
      puts("#{idx}) #{warrior.name}")
    end
  end
end
