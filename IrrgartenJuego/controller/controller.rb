require_relative '../game'
require_relative '../ui/text_ui'

module Irrgarten
  module Controller
    # Controlador que coordina el modelo (Game) y la vista (TextUI).
    class Controller
      # Constructor que enlaza el modelo y la vista[cite: 532].
      def initialize(game, view)
        @game = game
        @view = view
      end

      # Inicia el bucle principal del juego.
      # Se ejecuta mientras no haya un ganador.
      def play
        until @game.finished?

          # 2. Pedir la siguiente dirección al jugador
          direction = @view.show_game(@game.get_game_state)

          # 3. Ejecutar el siguiente paso del juego
          @game.next_step(direction)
        end

        # 4. Mostrar el estado final cuando el juego ha terminado
        @view.show_game(@game.get_game_state)
      end
    end # class Controller
  end # module Controller
end # module Irrgarten
