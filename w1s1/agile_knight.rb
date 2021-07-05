require_relative "knight.rb"

class AgileKnight < Knight
    
    def damaged(damage)
        # rand(5) will generate num between 0..4
        # probability of returning 0 is 20%
        if rand(5) == 0
            @hitpoint -= damage
        else
            dodge_attack()
        end

        puts(self)
    end

    def dodge_attack()
        puts("#{@name} deflects the attack")
    end
end
