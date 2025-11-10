module Irrgarten
  class Monster
    INITIAL_HEALTH = 5

    def initialize(name, intelligence, strenght)
      @name = name.to_s
      @intelligence = intelligence.to_f
      @strenght = strenght.to_f

      @health = INITIAL_HEALTH
      @row = -1
      @col = -1
    end

    def dead
      @health <= 0
    end

    def attack
      Dice.intensity(@strenght)
    end

    def set_pos(row, col)
      @row = row.to_i
      @col = col.to_i
    end

    def to_s
      "Name: #{@name}\n" +
        "Intelligence: #{@intelligence}\n" +
        "Strength: #{@strength}\n" +
        "Health: #{@health}\n" +
        "[#{@row},#{@col}]"
    end

    def defend(recieved_attack)
      is_dead = dead
      if is_dead
        defensive_energy = Dice.intensity(@intelligence)
        if defensive_energy < recieved_attack
          got_wounded
          is_dead = dead
        end
      end
      is_dead
    end

    private

    def got_wounded
      @health -= 1.0
    end
  end
end
