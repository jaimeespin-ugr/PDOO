require_relative 'weapon'
require_relative 'shield'
require_relative 'labyrinthCharacter'

module Irrgarten
  class Player < LabyrinthCharacter
    MAX_WEAPONS = 2
    MAX_SHIELD = 3
    INITIAL_HEALTH = 10
    HITS2LOSE = 3

    def initialize(number, intelligence, strenght)
      super(number, intelligence, strenght, INITIAL_HEALTH)
      @number = number
      @weapons = []
      @shields = []
      @consecutive_hits = 0
    end

    def copia(lc)
      copia_labchar(lc)
      @weapons = lc.weapons
      @shields = lc.shields
      @consecutivehits = lc.consecutivehits
      @number = lc.number
    end

    def resurrect
      @health = INITIAL_HEALTH
      @weapons = []
      @shields = []
      @consecutive_hits = 0
    end

    def set_pos(row, col)
      super(row, col)
    end

    def dead
      super
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
      @strength + sum_weapons
    end

    def defend(recieved_attack)
      manage_hit(recieved_attack)
    end

    def receive_reward
      w_reward = Dice.weapons_reward
      s_reward = Dice.shields_reward

      (1..w_reward).each do
        receive_weapon(new_weapon)
      end

      (1..s_reward).each do
        receive_shield(new_shield)
      end
      extra_health = Dice.health_reward
      @health += extra_health
    end

    def to_s
      super.to_s
    end

    attr_reader :number,:col,:row,:intelligence,:strength,:shields,:weapons,:consecutive_hits

    private

    def receive_weapon(w)
      @weapons.each do|ih|
        if ih.is_a?(Weapon)
          discard=ih.discard
          if discard
            @weapons.delete(ih)
          end
        end
      end
      size=@weapons.size
      if size<MAX_WEAPONS && w.is_a?(Weapon)
        @weapons[size]=w
      end
    end

    def receive_shield(s)
      @shields.each do |wi|
        if wi.is_a?(Shield)
          d=wi.discard
          if d
            @shields.delete(wi)
          end
        end
      end
      size=@shields.size
      if size<MAX_SHIELD && s.is_a?(Shield)
        @shields[size]=s
      end
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
