module Irrgarten
  class Shield
    def initialize(protection, uses)
      @protection = protection.to_f
      @uses = uses.to_i
    end

    def protect
      if @uses > 0
        @uses -= 1
        @protection
      else
        0.0
      end
    end

    def to_s
      "W[#{@protection}, #{@uses}]"
    end

    def discard
      Dice.discard_element(@uses)
    end
  end
end
