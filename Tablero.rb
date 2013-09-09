class Tablero
	attr_accessor :fichas, :tablero, :n, :fichas_jugadores, :turnos
	def initialize(jugadores)
		@pasos={1=>[],2=>[],3=>[],1=>[]}
		generar_fichas # Genera las 28 fichas que tiene el dominó
		@historial 
		@n = jugadores.length # Número de jugadores
		definir_turnos # Define la variable @turnos
		@fichas_jugadores = Hash.new
		asignar_fichas # Asigna las fichas a cada jugador
		@jugadores = jugadores
		@tablero = Array.new  
		@paso = 0
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
	def asignar_fichas
		i = 1
		while i <= @n
			@fichas_jugadores[i] = []
			i += 1
		end
		fichas_pp = 28/@n
		fichas_temp = @fichas
		k = 0
		while k < fichas_pp
			@fichas_jugadores.each do |j|
				r = rand(fichas_temp.size)
				j[1] << @fichas[r] # j[0] es el id del jugador, j[1] es un array con sus fichas
				@fichas.delete_at(r)
			end
			k += 1
		end
		generar_fichas
	end
	def juego
		while !fin_del_juego
			@turnos.each do |t|
				ficha = @jugadores[t-1].jugar(@fichas_jugadores[t], @tablero, @turnos, nil, t) # ficha es un hash como sigue: {:id_ficha => 22, :posicion => 0, :orientacion => 1 }
				if @fichas_jugadores[t].include?(@fichas[ficha[:id_ficha]])
					exito = turno(ficha, t)
					if exito
						@paso = 0
						puts "El jugador "+t.to_s+" no pasa."
					else
						pasos(t,@tablero)
						@paso += 1
						puts "El jugador "+t.to_s+" pasa."
					end
				else
					puts "El jugador "+t.to_s+" pasa."
					@paso += 1
				end
			end
		end
	end
	def definir_turnos
		jugadores = []
		k = 1
		while k <= @n
			jugadores << k
			k += 1
		end
		turnos = []
		while turnos.length < @n
			r = rand(jugadores.length)
			turnos << jugadores[r]
			jugadores.delete_at(r)

		end
		@turnos = turnos
	end
	def fin_del_juego
		return @paso >= @n
	end
	def turno(ficha, id_jugador)
		id_ficha = ficha[:id_ficha]
		posicion = ficha[:posicion]
		orientacion = ficha[:orientacion]

		if !@tablero.empty?
			izq_ficha_izq = ficha_izq[0]
			der_ficha_der = ficha_izq[1]

			f = ficha_orientada(@fichas[id_ficha],orientacion)
			if posicion == 0
				if izq_ficha_izq == f[1]
					@tablero.unshift({:id_ficha => id_ficha, :orientacion => orientacion, :id_jugador => id_jugador})
					@fichas_jugadores[id_jugador].delete(@fichas[id_ficha])
					return true
				else
					return false
				end
			elsif posicion == 1
				if der_ficha_der == f[0]
					@tablero << {:id_ficha => id_ficha, :orientacion => orientacion, :id_jugador => id_jugador}
					@fichas_jugadores[id_jugador].delete(@fichas[id_ficha])
					return true
				else
					return false
				end
			end
		else
			@tablero << {:id_ficha => id_ficha, :orientacion => orientacion, :id_jugador => id_jugador}
			@fichas_jugadores[id_jugador].delete(@fichas[id_ficha])
			return true
		end
	end
	def ficha_izq
		ficha_juego = @tablero.first
		ficha = @fichas[ficha_juego[:id_ficha]]
		return ficha_orientada(ficha,ficha_juego[:orientacion])
	end
	def ficha_der
		ficha_juego = @tablero.last
		ficha = @fichas[ficha_juego[:id_ficha]]
		return ficha_orientada(ficha,ficha_juego[:orientacion])
	end
	def ficha_orientada(ficha,orientacion)
		if orientacion == 1
			return ficha.reverse
		else
			return ficha
		end
	end
	def mostrar_partida
		partida = []
		@tablero.each do |turno|
			partida << ficha_orientada(@fichas[turno[:id_ficha]],turno[:orientacion])
	end
		return partida
	end
	def pasos(jugador,tablero)
		@pasos[jugador] << ficha_orientada(@fichas[tablero[tablero.length-1][:id_ficha]],@fichas[tablero[tablero.length-1][:orientacion]])[1]
		@pasos[jugador] << ficha_orientada(@fichas[tablero[0][:id_ficha]],@fichas[tablero[tablero.length-1][:orientacion]])[0]
	end
end



