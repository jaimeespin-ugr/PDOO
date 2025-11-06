class Dice
  MAX_USES = 5                  # número máximo de usos de armas y escudos
  MAX_INTELLIGENCE = 10.0       # valor máximo para la inteligencia de jugadores y monstruos
  MAX_STRENGTH = 10.0           # valor máximo para la fuerza de jugadores y monstruos
  RESURRECT_PROB = 0.3          # probabilidad de resurrección por turno
  WEAPONS_REWARD = 2            # número máximo de armas recibidas al ganar un combate
  SHIELDS_REWARD = 3            # número máximo de escudos recibidos al ganar un combate
  HEALTH_REWARD = 5             # número máximo de unidades de salud recibidas al ganar un combate
  MAX_ATTACK = 3                # máxima potencia de las armas
  MAX_SHIELD = 2                # máxima potencia de los escudos

  @@generator = Random.new

  def random_pos(max)
    @@generator.rand(0...max)
  end

  def who_starts(nplayers)
    @@generator.rand(0...nplayers)
  end

  def random_intelligence
    @@generator.rand(0...MAX_INTELLIGENCE)
  end

  def random_strength
    @@generator.rand(0...MAX_STRENGTH)
  end

  def resurrect_player
    @@generator.rand < RESURRECT_PROB
  end

  def weapons_reward
    @@generator.rand(0..WEAPONS_REWARD)
  end

  def shields_reward
    @@generator.rand(0..SHIELDS_REWARD)
  end

  def health_reward
    @@generator.rand(0..HEALTH_REWARD)
  end

  def weapon_power
    @@generator.rand(0...MAX_ATTACK)
  end

  def shield_power
    @@generator.rand(0...MAX_SHIELD)
  end

  def uses_left
    @@generator.rand(0..MAX_USES)
  end

  def intensity(competence)
    @@generator.rand(0...competence)
  end

  def discard_element(usesLeft)
    probability = 1.0 - (usesLeft.to_f / MAX_USES)
    @@generator.rand < probability
  end
end
