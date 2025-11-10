#!/usr/bin/env ruby
# Cargar los archivos necesarios desde sus módulos/directorios
# Asume que este script está en el directorio raíz,
# junto a la carpeta 'irrgarten'.
require_relative './game'
require_relative './ui/text_ui'
require_relative './controller/controller'

# --- Ejecución Principal ---

begin
  # 1. Crear la vista
  # Asumiendo que TextUI está en Irrgarten::UI
  view = Irrgarten::UI::TextUI.new

  # 2. Crear el modelo del juego
  # El constructor de Game necesita el número de jugadores [cite: 460]
  n_players = 2 # Asumimos 2 jugadores
  game = Irrgarten::Game.new(n_players)

  # 3. Crear el controlador
  # Asumiendo que Controller está en Irrgarten::Controller
  # y que recibe el juego y la vista [cite: 531]
  controller = Irrgarten::Controller::Controller.new(game, view)

  # 4. Iniciar la partida
  controller.play
rescue Interrupt
  # Manejar salida con Ctrl+C
  puts "\nPartida interrumpida. ¡Adiós!"
rescue StandardError => e
  # Manejar otros posibles errores
  puts "Ha ocurrido un error inesperado: #{e.message}"
  puts e.backtrace
end
