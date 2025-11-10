module Irrgarten
  class GameState
    attr_accessor :labyrinth, :players, :monsters, :current_player, :winner, :log

    # Inicializa el estado del juego con los atributos usados en test_p1.rb
    def initialize(labyrinth, players, monsters, current_player, winner, log)
      @labyrinth = labyrinth.to_s
      @players = players.to_s
      @monster = monsters.to_s
      @current_player = current_player.to_i
      @winner = winner
      @log = log.to_s
    end

    def getLabyrinth
      @labyrinth
    end

    def getPlayers
      @players
    end

    def getMonster
      @monster
    end

    def getCurrentPlayer
      @current_player
    end

    def isWinner
      @winner
    end

    def getLog
      @log
    end
  end
end
