class Monster
  INITIAL_HEALTH=5

  def initialize(name, intelligence, strenght)
    @name = name.to_s
    @intelligence = intelligence.to_f
    @strenght = strenght.to_f

    @health = INITIAL_HEALTH
    @row = -1
    @col = -1
  end

  def dead
    @health<=0
  end

  def attack
    dado=Dice.new
    dado.intensity(@strenght)
  end

  def setPos(row, col)
    @row=row.to_i
    @col=col.to_i
  end

  def to_s()
    "Name: "+@name+"\n"+
    "Intelligence: "+@intelligence+"\n"+
    "Strength: "+@strength+"\n"+
    "Health: "+@health+"\n"+
    "["+@row+","+@col+"]";
  end

  def defend(recievedAttack)
    #Siguiente práctica
  end
  private

  def gotWounded()
    @health-=1.0
  end

end