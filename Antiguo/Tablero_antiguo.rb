class Tablero
	attr_accessor :fichas
	def initialize()
		generar_fichas
		@Yoshi = [] # Jugador 1
		@Sam = [] # Jugador 2
		@Seba = [] # Jugador 3
		@Mati = [] # Jugador 4
		asignar_fichas
		generar_fichas #Regenerar las fichas, ya que fueron borradas en el método asignar_fichas
		@juego = []
	end
	def generar_fichas()
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
		fichas_pp = 28/4
		fichas_temp = @fichas

		k = 0
		while k<fichas_pp
			r = rand(fichas_temp.size)
			@Yoshi << fichas_temp[r]
			fichas_temp.delete_at(r)
			r = rand(fichas_temp.size)
			@Sam << fichas_temp[r]
			fichas_temp.delete_at(r)
			r = rand(fichas_temp.size)
			@Seba << fichas_temp[r]
			fichas_temp.delete_at(r)
			r = rand(fichas_temp.size)
			@Mati << fichas_temp[r]
			fichas_temp.delete_at(r)
			k += 1
		end
		i = 0
	end
	def turno(id_ficha, sentido, id_jugador, posicion)
		izq_ficha_izq = ficha_izq[0]
		der_ficha_der = ficha_izq[1]
		f = ficha_orientada(@ficha[id_ficha],sentido)
		if posicion == 0
			if izq_ficha_izq == f[1]
				@juego.unshift({:id_ficha => id_ficha, :sentido => sentido, :id_jugador => id_jugador})
			end
		elsif posicion == 1
			if der_ficha_der == f[0]
				@juego << {:id_ficha => id_ficha, :sentido => sentido, :id_jugador => id_jugador}
			end
		end
	end
	def ficha_izq
		ficha_juego = @juego.first
		ficha = @fichas[ficha_juego[:id_ficha]]
		return ficha_orientada(ficha,ficha_juego[:sentido])
	end
	def ficha_der
		ficha_juego = @juego.last
		ficha = @fichas[ficha_juego[:id_ficha]]
		return ficha_orientada(ficha,ficha_juego[:sentido])
	end
	def ficha_orientada(ficha,sentido)
		if sentido == 1
			return ficha.reverse
		else
			return fichas
		end
	end
end