class Seba
	def initialize
		generar_fichas
	end
	def jugar(mis_fichas, tablero, turnos, pasos, id_jugador)
		if tablero.empty?
			id_ficha = maximo(contar_fichas(mis_fichas))
			return {:id_ficha => id_ficha , :posicion => 0, :orientacion => 0 }
		end
		ficha_der = @fichas[tablero.last[:id_ficha]][(tablero.last[:orientacion]-1).abs]
		ficha_izq = @fichas[tablero.first[:id_ficha]][tablero.first[:orientacion]]
		factible = factibles(mis_fichas, tablero, ficha_izq, ficha_der)
		conteo = contar_fichas(factible)
		n = maximo(conteo) # el número que más se repite
		
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
	def factibles(mis_fichas, tablero, ficha_izq, ficha_der)
		factible = []
		mis_fichas.each do |ficha|
			if ficha.include?(ficha_izq) or ficha.include?(ficha_der)
				factible << ficha
			end
		end
		return factible
	end
	def contar_fichas(mis_fichas)
		contabilidad = Array.new(7){ |i| 0 }
		mis_fichas.each do |ficha|
			contabilidad[ficha[0]] += 1
			contabilidad[ficha[1]] += 1
		end
		return contabilidad
	end
	def contar_tablero(tablero)
		contabilidad = Array.new(7){ |i| 0 }
		tablero.each do |ficha_tablero|
			ficha = @fichas[ficha_tablero[:id_ficha]]
			contabilidad[ficha[:id_ficha][0]] += 1
			contabilidad[ficha[:id_ficha][1]] += 1
		end
		return contabilidad
	end
	def maximo(arreglo)
		i_max = 0
		max = 0
		k = 0
		arreglo.each do |e|
			if e > max
				i_max = k
				max = e
			end
			k+=1
		end
		return i_max
	end
	def configuracion(ficha, ficha_izq, ficha_der) # Retornará un hash ej: {:posicion => 1, orientacion => 0}
	end
end