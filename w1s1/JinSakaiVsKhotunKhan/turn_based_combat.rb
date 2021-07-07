class TurnBasedCombat
  # knight1 will start the turn
  def initialize(knight1, knight2)
    @knight1 = knight1
    @knight2 = knight2

    @is_knight1_turn = true
  end

  def battle_till_die
    while @knight1.alive? && @knight2.alive?
      battle
      puts
    end
  end

  def battle
    if @is_knight1_turn
      @knight1.attack(@knight2)
    else
      @knight2.attack(@knight1)
    end

    @is_knight1_turn = !@is_knight1_turn
  end

  def print_loser
    if @knight1.alive?
      puts("#{@knight2.name} dies.")
    else
      puts("#{@knight1.name} dies.")
    end
  end
end
