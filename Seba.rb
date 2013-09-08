class Seba
	def initialize
		generar_fichas
	end
	def jugar(mis_fichas, tablero, turnos)
		if tablero.empty?
			return {:id_ficha => 11 , :posicion => 0, :orientacion => 1 }
		end
		ficha_der = @fichas[tablero.last[:id_ficha]][(tablero.last[:orientacion]-1).abs]
		ficha_izq = @fichas[tablero.first[:id_ficha]][tablero.first[:orientacion]]
		return {:id_ficha => 2, :posicion => 0, :orientacion => 1 }
	end
	def generar_fichas
		i = 6
		fichas = []
		until i < 0
			k = i
			until k < 0 do
				fichas << [i,k]
				k -= 1
			end
			i -= 1
		end
		@fichas = fichas.reverse
	end
	def posibles_jugadas(mis_fichas, tablero, ficha_izq, ficha_der)
		mis_fichas.each do |ficha|
			if ficha.include?(ficha_izq) or ficha.include?(ficha_der)
				ficha
	end
end