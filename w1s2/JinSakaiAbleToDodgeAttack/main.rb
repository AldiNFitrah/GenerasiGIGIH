require_relative 'agile_knight'
require_relative 'knight'
require_relative 'turn_based_combat'

knight1 = AgileKnight.new('Jin Sakai', 100, 50, 80)
knight2 = Knight.new('Khotun Khan', 500, 50)

turn_based_combat = TurnBasedCombat.new(knight1, knight2)
turn_based_combat.battle_till_die
turn_based_combat.print_loser
