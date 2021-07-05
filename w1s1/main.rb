require_relative "knight.rb"
require_relative "turn_based_combat.rb"

knight1 = Knight.new("Jin Sakai", 100, 50, 80)
knight2 = Knight.new("Khotun Khan", 500, 50)

turn_based_combat = TurnBasedCombat.new(knight1, knight2)
turn_based_combat.battle_till_die()
turn_based_combat.print_loser()
