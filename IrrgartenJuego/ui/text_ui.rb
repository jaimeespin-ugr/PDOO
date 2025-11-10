require 'io/console'
require_relative '../directions'
require_relative '../game_state'

module Irrgarten
  module UI
    class TextUI
      def show_game(game_state)
        print "\e[2J\e[H"

        puts '--- LABERINTO ---'
        puts game_state.labyrinth
        puts

        puts '--- JUGADORES ---'
        puts game_state.players
        puts '--- MONSTRUOS ---'
        puts game_state.monsters
        puts '-------------------'

        puts "Turno del jugador: #{game_state.current_player}"
        puts "¡¡¡ EL JUGADOR #{game_state.current_player} HA GANADO !!!" if game_state.winner
        puts

        puts '--- LOG ---'
        puts game_state.log
        puts '-----------'

        print 'Elige una dirección (Flechas del cursor): '

        STDIN.raw!
        input = STDIN.getch

        if input == "\e"
          begin
            input << STDIN.read_nonblock(3)
          rescue StandardError
            nil
          end
          begin
            input << STDIN.read_nonblock(2)
          rescue StandardError
            nil
          end
        end

        STDIN.cooked!

        case input
        when "\e[A"
          puts 'ARRIBA'
          Directions::UP
        when "\e[B"
          puts 'ABAJO'
          Directions::DOWN
        when "\e[C"
          puts 'DERECHA'
          Directions::RIGHT
        when "\e[D"
          puts 'IZQUIERDA'
          Directions::LEFT
        when "\u0003"
          puts "\n¡Partida interrumpida!"
          exit 130
        else
          next_move
        end
      end
    end
  end
end
