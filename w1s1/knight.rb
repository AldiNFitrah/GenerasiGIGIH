class Knight

    def initialize(name, hitpoint, attack_damage, agility=0)
        @name = name
        @hitpoint = hitpoint
        @attack_damage = attack_damage
        @agility = agility

        puts "#{self}\n\n"
    end

    def attack(other_knight)
        puts("#{@name} attacks #{other_knight.name} with #{@attack_damage} damage")
        other_knight.damaged(@attack_damage)
    end

    def damaged(damage)
        if rand(100) < @agility
            dodge_attack()
        else
            @hitpoint -= damage
        end

        puts(self)
    end

    def dodge_attack()
        puts("#{@name} deflects the attack")
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
