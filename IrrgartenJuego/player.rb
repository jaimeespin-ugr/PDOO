require_relative 'weapon'
require_relative 'shield'

module Irrgarten
  class Player
    MAX_WEAPONS = 2
    MAX_SHIELD = 3
    INITIAL_HEALTH = 10
    HITS2LOSE = 3

    def initialize(number, intelligence, strenght)
      @number = number.to_c
      @intelligence = intelligence.to_f
      @strenght = strenght.to_f

      @name = "Player # #{number.to_c}"

      @health = INITIAL_HEALTH
      @weapons = []
      @shields = []
      @consecutive_hits = 0
    end

    def resurrect
      @health = INITIAL_HEALTH
      @weapons = []
      @shields = []
      @consecutive_hits = 0
    end

    def get_row
      @row
    end

    def get_col
      @col
    end

    def get_number
      @number
    end

    def set_pos(row, col)
      @row = row.to_i
      @col = col.to_i
    end

    def dead
      @health <= 0
    end

    def move(direction, valid_moves)
      size = valid_moves.size
      contained = valid_moves.include?(direction)

      if size > 0 && !contained
        valid_moves[0]
      else
        direction
      end
    end

    def attack
      @strenght + sum_weapons
    end

    def defend(recieved_attack)
      manage_hit(recieved_attack)
    end

    def receive_reward
      w_reward = Dice.weapons_reward
      s_reward = Dice.shields_reward

      (1..w_reward).each do
        recieve_weapon(new_weapon)
      end

      (1..s_reward).each do
        recieve_shield(new_shield)
      end
      extra_health = Dice.health_reward
      @health += extra_health
    end

    def to_s
      "Name: #{@name}\n" \
      "Intelligence: #{@intelligence}\n" \
      "Strength: #{@strenght}\n" \
      "Health: #{@health}\n" \
      "[#{@row},#{@col}]\n" \
      "Items: #{@weapons.size} Armas, #{@shields.size} Escudos\n" \
      "Consecutive Hits: #{@consecutive_hits}"
    end

    private

    def recieve_weapon(w)
      @weapons.delete_if(&:discard)
      @weapons << w if @weapons.size < MAX_WEAPONS
    end

    def recieve_shield(s)
      @shields.delete_if(&:discard)
      @shields << s if @shields.size < MAX_SHIELD
    end

    def new_weapon
      Weapon.new(Dice.weapon_power, Dice.uses_left)
    end

    def new_shield
      Shield.new(Dice.shield_power, Dice.uses_left)
    end

    def sum_weapons
      sum = 0
      @weapons.each do |element|
        sum += element.attack
      end
      sum
    end

    def sum_shields
      sum = 0
      @shields.each do |element|
        sum += element.protect
      end
      sum
    end

    def defensive_energy
      @intelligence + sum_shields
    end

    def manage_hit(recieved_attack)
      defense = defensive_energy
      if defense < recieved_attack
        got_wounded
        inc_consecutive_hits
      else
        reset_hits
      end

      if @consecutive_hits == HITS2LOSE || dead
        reset_hits
        lose = true
      else
        lose = false
      end

      lose
    end

    def reset_hits
      @consecutive_hits = 0
    end

    def got_wounded
      @health -= 1
    end

    def inc_consecutive_hits
      @consecutive_hits += 1
    end
  end
end
