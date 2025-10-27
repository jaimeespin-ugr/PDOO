class Player
  MAX_WEAPONS=2
  MAX_SHIELD=3
  INITIAL_HEALTH=10
  HITS2LOSE=3

  def initialize(number, intelligence, strenght)
    @number = name.to_c
    @intelligence = intelligence.to_f
    @strenght = strenght.to_f

    @name = "Player #"+number.to_c
  end

  def resurrect
    @health = INITIAL_HEALTH
    @weapons = []
    @shields = []
    @consecutiveHits = 0
  end

  def getRow
    @row
  end

  def getCol
    @col
  end
  
  def getNumber
    @number
  end

  def setPos(row, col)
    @row=row.to_i
    @col=col.to_i
  end

  def dead
    @health<=0
  end

  def move(direction, velidMoves)
    #siguiente práctica
  end

  def attack
    @strenght+@sumWeapons
  end

  def defend(recievedAttack)
    manageHit(recievedAttack)
  end

  def recievedReward
    #siguiente práctica
  end

  def to_s()
    "Name: "+@name+"\n"+
    "Intelligence: "+@intelligence+"\n"+
    "Strength: "+@strength+"\n"+
    "Health: "+@health+"\n"+
    "["+@row+","+@col+"]\n"+
    "Items: "+@weapons.size()+" Armas, "+@shields.size()+" Escudos\n"+
    "Consecutive Hits: "+@consecutiveHits;
  end

  private 

  def recieveWeapon(w)
    #proxima práctica
  end

  def recieveShield(s)
    #proxima práctica
  end

  def newWeapon
    dado=Dice.new
    arma=Weapon.new(dado.weaponPower(), dado.usesLeft())
    arma
  end

  def newShield
    dado=Dice.new
    shield=Shield.new(dado.shieldPower(), dado.usesLeft())
    shield
  end 
  
  def sumWeapons
    sum=0
    @weapons.each do |element|
      sum+=weapons[element].attack()
    end
    sum
  end

  def sumShields
    sum=0
    @shields.each do |element|
      sum+=shields[element].protect()
    end
    sum
  end

  

  