require_relative 'combatElement'
module Irrgarten
  class Weapon < CombatElement
    def initialize(power, uses)
      super(power, uses)
    end

    def attack
      produceeffect
    end

    def to_s
      'W[' + super.to_s + ']'
    end

    public_class_method :new
  end
end
