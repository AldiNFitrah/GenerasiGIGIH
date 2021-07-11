class TurnBasedCombat
  # army1 will start the turn
  def initialize(army1, army2)
    @army1 = army1
    @army2 = army2
  end

  def battle_till_die
    turn_count = 1

    loop do
      puts("==================== TURN #{turn_count} ====================\n\n")
      @army1.check_army
      @army2.check_army

      @army1.attack(@army2)
      if !@army2.able_to_war?
        break
      end
      puts
      
      @army2.attack(@army1)
      if !@army1.able_to_war?
        break
      end
      puts

      turn_count += 1
    end
  end
end
