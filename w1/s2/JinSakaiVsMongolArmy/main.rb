require_relative 'agile_knight'
require_relative 'army'
require_relative 'archer'
require_relative 'spearman'
require_relative 'swordsman'
require_relative 'knight'
require_relative 'turn_based_combat'

army1 = Army.new([AgileKnight.new('Jin Sakai', 100, 400, 80)])
army2 = Army.new([
                   Archer.new('Mongolian Archer', 500, 50),
                   Spearman.new('Mongolian Spearman', 500, 50),
                   Swordsman.new('Mongolian Swordsman', 500, 50)
                 ])

turn_based_combat = TurnBasedCombat.new(army1, army2)
turn_based_combat.battle_till_die
