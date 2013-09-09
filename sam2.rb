class Sam2
	def initialize
		@fichas =[[0, 0], [1, 0], [1, 1], [2, 0], [2, 1], [2, 2], [3, 0], [3, 1], [3, 2], [3, 3], [4, 0], [4, 1], [4, 2], [4, 3], [4, 4], [5, 0], [5, 1], [5, 2], [5, 3], [5, 4], [5, 5], [6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6]]
		i=0
		@ids = Array.new
		@fichas.each do |j|
			@ids[j[0],j[1]]=i
			i=+1
		end
	end
	def jugar(mano,mesa,turnos,pasos,mi_id)
		@mano=mano
		@mesa=mesa
		@turnos=turnos
		@pasos=pasos
		@mi_id=mi_id
		jugadas_factibles(mano,mesa)
		if @fichas_factibles.empty?
			nil
		else
			estrategia_puntaje
			entregar_ficha_usar(mesa)
		end
	end
	def jugadas_factibles(mano, mesa)
		@fichas_factibles=[]
		ficha_izq=@fichas[mesa[0][:id_ficha]]
		ficha_der=@fichas[mesa[mesa.length-1][:id_ficha]]
		mano.each do |ficha|
			if ficha.include?(ficha_izq[1]) or ficha.include?(ficha_der[1]) or orficha.include?(ficha_der[0]) or ficha.include?(ficha_izq[0]) 
				@fichas_factibles << ficha
			end
		end
	end
	def estrategia_nopasar(fichas_factibles)
		sum=-1
		fichas_factibles.each do |ficha_factible|
			mano_aux=@mano
			existencia=[0,0,0,0,0,0,0]	
			mano_aux.delete_at(ficha_factible)
			7.times do |i|
				if existencia[i]==0 && (ficha_factible[0]==i || ficha_factible[1]=i)
					existencia[i]=1
				end
			end
			sum_posible=0
			existencia.each do |existe|
				sum_posible+=existe
			end
			if sum_posible>sum
				@ficha_usar=ficha_factible
			elsif sum_posible==sum
				decidir_puntaje(ficha_factible)
			else
				@ficha_usar
			end
		end
	end
	def estrategia_puntaje(fichas_factibles)
		fichas_factibles.each do |ficha_factible|
			putaje_ficha_factible=ficha_factible[0]+ficha_factible[1]
			putaje_ficha_usar=ficha_factible[0]+ficha_factible[1]
			if puntaje_ficha_factible<puntaje_ficha_usar
				@ficha_usar=@ficha_factible
			elsif puntaje_ficha_factible==puntaje_ficha_usar 
				decidir_nopasar(ficha_factible)
			else
				@ficha_usar
			end
		end
	end
	def decidir_puntaje(ficha_factible)
		if ficha_factible[0]+ficha_factible[1]<@ficha_usar[0]+@ficha_usar[1]
			@ficha_usar=ficha_factible
		elsif ficha_factible[0]+ficha_factible[1]==@ficha_usar[0]+@ficha_usar[1]
			decidir_desviacion(ficha_factible)
		else
			@ficha_usar
		end
	end
	def decidir_nopasar(ficha_factible)
		sum=-1
		mano_factible=@mano
		mano_usar=@mano
		existencia_factible=[0,0,0,0,0,0,0]
		existencia_usar=[0,0,0,0,0,0,0]	
		mano_factible.delete_at(ficha_factible)
		mano_usar.delete_at(@ficha_usar)
		7.times do |i|
			if existencia_factible[i]==0 && (ficha_factible[0]==i || ficha_factible[1]=i)
				existencia_factible[i]=1
			end
			if existencia_usar[i]==0 && (@ficha_usar[0]==i || @ficha_usar[1]=i)
				existencia_usar[i]=1
			end
		end
		sum_factible=0
		sum_usar=0
		existencia_factible.each do |existe|
			sum_factible+=existe
		end
		existencia_usar.each do |existe|
			sum_usar+=existe
		end
		if sum_usar>sum_factible
			@ficha_usar=ficha_factible
		elsif sum_posible==sum
			decidir_puntaje(ficha_factible)
		else
			@ficha_usar
		end
	end	
	def decidir_desviacion(ficha_factible)
		cantidades_factible=[0,0,0,0,0,0,0]
		cantidades_usar=[0,0,0,0,0,0,0]
		mano_aux_factible=@mano
		mano_aux_usar=@mano
		mano_aux_factible.delete_at(ficha_factible)
		mano_aux_usar.delete_at(@ficha_usar)
		mano_aux_factible.each do |ficha|
			cantidades_factible[ficha[1]]+=1
			cantidades_factible[ficha[2]]+=1
		end
		mano_aux_usar.each do |ficha|
			cantidades_usar[ficha[1]]+=1
			cantidades_usar[ficha[2]]+=1
		end
		d_factible=desviacion(cantidades_factible)
		d_usar=desviacion(cantidades_usar)
		if d_factible<d_usar
			@ficha_usar=ficha_factible
		elsif d_factible==d_usar
			if rand(1)==0
				@ficha_usar
			else
				@ficha_usar=ficha_factible
			end  
		else
			@ficha_usar
		end
	end
	def desviacion(array)
		media=0
		desv=0
		array_f=[]
		array.each do |numero|
			if numero=!0
				array_f << numero
			end
		end
		array_f.each do |numero|
			media+=numero
		end
		media=media/array_f.length
		array_f.each do |numero|
			desv+=(media-numero)**2
		end
		desv/array_f.length
 	end
 	def entregar_ficha_usar(mesa)
 		id_ficha=@ids[@ficha_usar[0],@ficha_usar[1]]
 		ficha_izq=@fichas[mesa[0][:id_ficha]]
		ficha_der=@fichas[mesa[mesa.length-1][:id_ficha]]
		@posicion=[]
		@orientacion=[]
 		if ficha_izq[0]==@ficha_usar[0]
 				@orientacion << 1
 				@posicion << 0
 		elsif ficha_izq[0]==@ficha_usar[1]
  				@orientacion << 0
 				@posicion << 0
 		end
 		if ficha_der[1]==@ficha_usar[0]
 				@orientacion << 0
 				@posicion << 1
 		elsif ficha_der[1]==@ficha_usar[1]
  				@orientacion <<  1
 				@posicion << 1
 		end
 		orientacion_posicion(id_ficha) #si supiera los turnos + los "pasos", redefinir mejor
		{:id_ficha => id_ficha, :orientacion => @orientacion[@r], :posicion => @posicion[@r]}
 	end
 	def orientacion_posicion(id_ficha)
 		mano_aux=@mano
 		mano_aux.delete_at(ficha[id_ficha])
 		puntaje=0
 		mano_aux.each do |ficha|
 			puntaje+=ficha[1]+ficha[0]
 		end
 		4.times do |i|
 			if turnos[i]==@mi_id
 				if turnos[i+1]
 					siguiente_jugador=turnos[i+1]
 				else
 					siguiente_jugador=turnos[0]
 				end
 			end
		end
		@r=0
		@orientacion.length.times do |i|
			if @pasos[siguiente_jugador].include?(ficha_orientada(ficha[id_ficha],@orientacion[i]))
				@r=i
			elsif @pasos[siguiente_jugador].include?(ficha_orientada(ficha[id_ficha],@orientacion[i]))
				@r=i
			end
		end
 	end
 	 def ficha_orientada(ficha,orientacion)
		if orientacion == 1
			return ficha.reverse
		else
			return ficha
		end
	end
end