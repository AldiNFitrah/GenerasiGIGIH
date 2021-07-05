class Knight

    def initialize(name, hitpoint, attack_damage)
        @name = name
        @hitpoint = hitpoint
        @attack_damage = attack_damage

        puts "#{self}\n\n"
    end

    def attack(other_knight)
        puts "#{@name} attacks #{other_knight.name} with #{@attack_damage} damage"
        other_knight.damaged(@attack_damage)
    end

    def damaged(damage)
        @hitpoint -= damage
        puts self
    end

    def to_s()
        return "#{@name} has #{@hitpoint} hitpoints and #{@attack_damage} attack damage"
    end

    def is_alive?()
        return @hitpoint > 0
    end

    def name()
        return @name
    end

end
