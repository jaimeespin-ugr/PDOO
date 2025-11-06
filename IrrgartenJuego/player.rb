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

  def move(direction, velidMoves)
    # siguiente práctica
  end

  def attack
    @strenght + @sumWeapons
  end

  def defend(recievedAttack)
    manage_hit(recievedAttack)
  end

  def recieved_reward
    # siguiente práctica
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
    # proxima práctica
  end

  def recieve_shield(s)
    # proxima práctica
  end

  def new_weapon
    dado = Dice.new
    Weapon.new(dado.weaponPower, dado.usesLeft)
  end

  def new_shield
    dado = Dice.new
    Shield.new(dado.shieldPower, dado.usesLeft)
  end

  def sum_weapons
    sum = 0
    @weapons.each do |element|
      sum += weapons[element].attack
    end
    sum
  end

  def sum_shields
    sum = 0
    @shields.each do |element|
      sum += shields[element].protect
    end
    sum
  end

  def defensive_energy
    @intelligence + sum_shields
  end

  def manage_hit
    # proxima práctica
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
