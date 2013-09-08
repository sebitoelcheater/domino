require 'Tablero.rb'
require 'Seba.rb'
jugadores = []
jugadores << Seba.new
jugadores << Seba.new
T = Tablero2.new(jugadores)
puts "Fichas jugadores: "+T.fichas_jugadores.inspect
T.juego
puts T.mostrar_partida.inspect
puts T.tablero.inspect