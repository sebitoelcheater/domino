require 'Tablero.rb'
require 'Seba.rb'
jugadores = []
jugadores << Seba.new
T = Tablero.new(jugadores)
puts "Fichas jugadores: "+T.fichas_jugadores.inspect
T.juego
puts T.mostrar_partida.inspect
puts T.tablero.inspect
puts Seba.new.maximo([2,29])