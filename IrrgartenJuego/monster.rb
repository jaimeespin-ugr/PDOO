module Irrgarten
  class Monster < LabyrinthCharacter
    INITIAL_HEALTH = 5

    def initialize(name, intelligence, strenght)
      super(name, intelligence, strenght, INITIAL_HEALTH)

      @row = -1
      @col = -1
    end

    def dead
      super
    end

    def attack
      Dice.intensity(@strength)
    end

    def set_pos(row, col)
      super(row, col)
    end

    def to_s
      super.to_s
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
