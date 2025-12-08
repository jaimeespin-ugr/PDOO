module Irrgarten
  class CombatElement
    def initialize(effect, uses)
      @effect = effect
      @uses = uses
    end

    protected

    def produceeffect
      if @uses > 0
        @uses -= 1
        @effect
      else
        0
      end
    end

    public

    def discard
      Dice.discard_element(@uses)
    end

    def to_s
      efecto = @effect.nil? ? ' ' : @effect.to_s
      usos = @uses.nil? ? ' ' : @uses.to_s
      efecto + ' ' + usos
    end

    private_class_method :new
  end
end
