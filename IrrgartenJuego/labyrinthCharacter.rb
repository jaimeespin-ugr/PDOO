module Irrgarten
  class LabyrinthCharacter
    def initialize(name, intelligence, strength, health)
      @name = name
      @intelligence = intelligence
      @strength = strength
      @health = health
      @row = nil
      @col = nil
    end

    def copia_labchar(lc)
      @name = lc.name
      @intelligence = lc.intelligence
      @strength = lc.strength
      @health = lc.health
      @row = lc.row
      @col = lc.col
    end

    def dead
      muerto = false
      muerto = true if @health == 0
      muerto
    end

    protected

    def get_intelligence
      @intelligence
    end

    def get_strength
      @strength
    end

    def get_health
      @health
    end

    def set_health(health)
      @health = health
    end

    def set_pos(row, col)
      @row = row
      @col = col
    end

    def to_s
      'Nombre: ' + @name.to_s + ',inteligencia: ' + @intelligence.to_s + ', fuerza: ' + @strength.to_s + ', salud: ' + @health.to_s + ', fila: ' + @row.to_s + ', columna: ' + @col.to_s
    end

    def got_wounded
      @health -= 1
    end
  end
  attr_reader :name, :intelligence, :strength, :health, :row, :col
end
