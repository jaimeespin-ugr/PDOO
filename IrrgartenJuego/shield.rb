require_relative 'combatElement'
module Irrgarten
  class Shield < CombatElement
    def initialize(protection, uses)
      super(protection, uses)
    end

    def protect
      produceeffect
    end

    def to_s
      'W[' + super.to_s + ']'
    end

    public_class_method :new
  end
end
