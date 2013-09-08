class Mati
	attr_accessor :Mati

	def init(Mati)
	generar_fichas
	end

	def fichas_candidatas(mis_fichas, tablero)   #pasar como argumento la lista de las fichas en mano  y el tablero para ver fichas en juego, 
												 #retornar la lista de las que sirven. 

		arreglo = mis_fichas[@jugadores.select { |a| a= "Mati" }][1]
		candidates=[]
		if tablero.empty?
			candidates=arreglo
		else
			ficha_der_tablero = @fichas[tablero.last[:id_ficha]][(tablero.last[:orientacion]-1).abs]
			ficha_izq_tablero = @fichas[tablero.first[:id_ficha]][tablero.first[:orientacion]]
			candidates_izq=[]
			candidates_der=[]

			while i< arreglo.length
				if arreglo[i][0]==ficha_izq_tablero || arreglo[i][1]==ficha_izq_tablero
					candidates_izq.push(arreglo[i])
				end
				if arreglo[i][0]==ficha_der_tablero || arreglo[i][1]==ficha_der_tablero
					candidates_der.push(arreglo[i])
				end
				i+=1
			end
			candidates.push(candidates_der)
			candidates.push(candidates_izq)
		end
		return candidates
	end
	def choose_the_best(candidates) #De nuestra lista con fichas aptas para jugarse, escoge la de mayor suma y devuelve la ficha [a,b]
		maxsum=0
		while i<candidates.length
			sum=candidates[i][0]+candidates[i][1]
			if sum>maxsum
				maxsum=sum
				ficha=candidates[i]

			end
			i+=1
		end
		return ficha
	end

	def historial(tablero)  # devuelve un arreglo de tamaño 7 (7 fichas) con la cantidad de veces que aparecen en el tablero.
		arreglo= Array.new(7,0)
		while i< tablero.length
			a=tablero[i][0]
			b=tablero[i][1]
			arreglo[a]+=1
			arreglo[b]+=1
			i+=1
		end
		return arreglo #arreglo de historiales de valores 
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
end