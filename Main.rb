require 'Tablero.rb'
T = Tablero.new
juego = []
juego << {:ficha => 1, :jugador => 2, :sentido => 0}
juego << {:ficha => 4, :jugador => 0, :sentido => 0}
juego.unshift({8989 => 3223})
juego.push(:lol => 32)
puts T.fichas.inspect