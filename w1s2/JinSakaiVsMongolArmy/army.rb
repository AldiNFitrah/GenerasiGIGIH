class Army
  def initialize(army)
    @army = army
  end

  def attack(other_army)
    @army.each do |knight|
      enemy = other_army.find_active_knight
      knight.attack(enemy) if knight.in_battle? && !enemy.nil?
    end
  end

  def able_to_war?
    !find_active_knight.nil?
  end

  def find_active_knight
    @army.each do |knight|
      return knight if knight.in_battle?
    end

    nil
  end
end
