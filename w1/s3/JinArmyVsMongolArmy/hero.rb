require_relative './warrior'

class Hero < Warrior

  def initialize(name, hitpoint, attack_damage, agility)
    super(name, hitpoint, attack_damage)
    @agility = agility
  end

  def take_turn(enemy_army, own_army)
    loop do
      if own_army.length(exclude = [self]) > 0
        is_hero_can_heal = true
      end

      puts("As #{@name}, what do you want to do this turn?")
      puts('1) Attack an enemy')
      puts('2) Heal an ally') if is_hero_can_heal

      hero_choice = gets.chomp

      case hero_choice
      when '1'
        ask_to_attack(enemy_army)
      when '2'
        if is_hero_can_heal
          ask_to_heal(own_army)
        else
          puts("\nPlease input a valid number")
          next
        end
      else
        puts("\nPlease input a valid number")
        next
      end

      break
    end
  end

  def ask_to_attack(enemy_army)
    hero_choice = nil
    loop do
      puts('Which enemy do you want to attack?')
      enemy_army.print_list

      begin
        hero_choice = gets.chomp.to_i
        raise StandardError if hero_choice < 1 || hero_choice > enemy_army.length

        break
      rescue StandardError => e
        p(e)
        puts("\nPlease input a valid number")
      end
    end

    enemy_to_be_attacked = enemy_army.get(hero_choice - 1)
    attack(enemy_to_be_attacked)
  end

  def ask_to_heal(own_army)
    hero_choice = nil
    loop do
      puts('Which ally do you want to heal?')
      own_army.print_list([self])

      begin
        hero_choice = gets.chomp.to_i
        raise StandardError if hero_choice < 1 || hero_choice > own_army.length - 1

        break
      rescue StandardError
        puts("\nPlease input a valid number")
      end
    end

    ally_to_be_healed = own_army.get(hero_choice - 1, [self])
    heal(ally_to_be_healed)
  end

  def heal(ally)
    restored_hitpoints = 20
    ally.get_treatment(restored_hitpoints)
    puts("#{@name} heals #{ally.name}, restoring #{restored_hitpoints} hitpoints")
  end

  def damaged(damage)
    if dodgeable?
      dodge_attack
    else
      super
    end
  end

  def dodge_attack
    puts("#{@name} deflects the attack")
  end

  def dodgeable?
    rand(100) < @agility
  end
end
