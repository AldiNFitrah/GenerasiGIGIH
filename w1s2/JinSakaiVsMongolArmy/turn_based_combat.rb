class TurnBasedCombat
  # army1 will start the turn
  def initialize(army1, army2)
    @army1 = army1
    @army2 = army2

    @is_army1_turn = true

    puts('-------------------- GAME START --------------------')
  end

  def battle_till_die
    turn_count = 1
    while @army1.able_to_war? && @army2.able_to_war?
      puts("-------------------- TURN #{turn_count} --------------------")
      turn_count += 1
      battle

    end
  end

  def battle
    if @is_army1_turn
      @army1.attack(@army2)
    else
      @army2.attack(@army1)
    end

    @is_army1_turn = !@is_army1_turn
    puts
  end

  def print_loser
    if @army1.alive?
      puts("#{@army2.name} dies.")
    else
      puts("#{@army1.name} dies.")
    end
  end
end
