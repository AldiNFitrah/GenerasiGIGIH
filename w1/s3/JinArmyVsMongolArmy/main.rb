require_relative './army'
require_relative './hero'
require_relative './mongol_army/archer'
require_relative './mongol_army/spearman'
require_relative './mongol_army/swordsman'
require_relative './turn_based_combat'
require_relative './warrior'

army1 = Army.new([Hero.new('Jin Sakai', 100, 50, 80),
                  Warrior.new('Yuna', 90, 45),
                  Warrior.new('Sensei Ishikawa', 80, 60)])

puts

army2 = Army.new([Archer.new('Mongol Archer', 80, 40),
                  Spearman.new('Mongol Spearman', 120, 60),
                  Swordsman.new('Mongol Swordsman', 100, 50)])

turn_based_combat = TurnBasedCombat.new(army1, army2)
turn_based_combat.battle_till_die
