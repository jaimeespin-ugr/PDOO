module Irrgarten
  class FuzzyPlayer < Player
    def copia_player(other)
      super(other)
    end

    def move(direction,validmoves)
      super.move(direction,validmoves)
    end

    def attack
      super
    end

    protected
    def defensiveenergy
      super
    end

    public

    def to_s
      "Fuzzy "+super.to_s
    end

  end
end