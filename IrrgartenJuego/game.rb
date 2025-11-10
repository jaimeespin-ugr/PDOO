require_relative 'game_character'
require_relative 'player'
require_relative 'monster'
require_relative 'labyrinth'
require_relative 'dice'
require_relative 'orientation'
module Irrgarten
  class Game
    NUM_PLAYERS = 2
    NUM_MONSTERS = 3
    DEFAULT_N_ROWS = 10
    DEFAULT_N_COLS = 10
    DEFAULT_EXIT_ROW = 0
    DEFAULT_EXIT_COL = 9
    DEFAULT_INTELLIGENCE = 10.0
    DEFAULT_STRENGTH = 10.0

    MAX_ROUNDS = 1
    def initialize(nplayers)
      @monsters = []
      @log = ''

      @players = []

      (0...nplayers).each do |i|
        new_player = Player.new((i + 1).to_s, DEFAULT_INTELLIGENCE, DEFAULT_STRENGTH)
        @players << new_player
      end

      @labyrinth = Labyrinth.new(DEFAULT_N_ROWS, DEFAULT_N_COLS, DEFAULT_EXIT_ROW, DEFAULT_EXIT_COL)

      @current_player_index = Dice.who_starts(nplayers)

      @current_player = @players[@current_player_index]

      configure_labyrinth

      @labyrinth.spread_players(@players)
    end

    def finished?
      @labyrinth.have_a_winner?
    end

    def next_step(preferred_direction)
      @log = ''
      dead = @current_player.dead
      if !dead
        direction = actual_direction(preferred_direction)
        log_player_no_orders if direction != preferred_direction
        monster = @labyrinth.put_player(direction, @current_player)
        if monster.nil?
          log_no_monster
        else
          winner = combat(monster)
          manage_reward(winner)
        end
      else
        manage_resurrection
      end
    end

    def get_game_state
      GameState.new(
        @labyrinth.to_s,
        @players.to_s,
        @monsters.to_s,
        @current_player_index,
        finished?,
        @log
      )
    end

    private

    def configure_labyrinth
      @labyrinth.add_block(Orientation::VERTICAL, 2, 2, 5)
      @labyrinth.add_block(Orientation::HORIZONTAL, 7, 1, 6)

      monster1 = Monster.new('Monster1', Dice.random_intelligence, Dice.random_strength)
      @monsters << monster1
      @labyrinth.add_monster(2, 3, monster1)
    end

    def next_player
      @current_player_index = (@current_player_index + 1) % @players.size
      @current_player = @players[@current_player_index]
    end

    def log_player_won
      @log += "Jugador gana combate: #{@current_player}\n"
    end

    def log_monster_won
      @log += "Monstruo gana combate: #{@monsters[@current_player_index]}\n"
    end

    def log_resurrected
      @log += "Jugador resucitado: #{@current_player}\n"
    end

    def log_player_skip_turn
      @log += "Jugador pierde turno por estar muerto: #{@current_player}\n"
    end

    def log_player_no_orders
      @log += "No fue posible seguir las instrucciones \n"
    end

    def log_no_monster
      @log += "Jugador en celda vacía/no fue posible moverse \n"
    end

    def log_rounds(rounds, max)
      @log += "Se han producido #{rounds} de #{max} rondas de combate"
    end

    def actual_direction(preferred_direction)
      current_row = @current_player.get_row
      current_col = @current_player.get_col
      valid_moves = @labyrinth.valid_moves(current_row, current_col)
      output = @current_player.move(preferred_direction, valid_moves)
    end

    def combat(monster)
      rounds = 0
      winner = GameCharacter::PLAYER
      player_attack = @current_player.attack
      lose = monster.defend(player_attack)

      while !lose && rounds < MAX_ROUNDS
        winner = GameCharacter::MONSTER
        rounds += 1
        monster_attack = monster.attack
        lose = @current_player.defend(monster_attack)
        next if lose

        player_attack = @current_player.attack
        winner = GameCharacter::PLAYER
        lose = monster.defend(player_attack)
      end
      log_rounds(rounds, MAX_ROUNDS)
      winner
    end

    def manage_reward(winner)
      if winner == GameCharacter::PLAYER
        @current_player.receive_reward
        log_player_won
      else
        log_monster_won
      end
    end

    def manage_resurrection
      resurrect = Dice.resurrect_player
      if resurrect
        @current_player.resurrect
        log_resurrected
      else
        log_player_skip_turn
      end
    end
  end
end
