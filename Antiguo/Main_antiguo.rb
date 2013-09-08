require 'Tablero.rb'
T = Tablero.new
juego = []
juego << {:ficha => 1, :jugador => 2, :sentido => 0}
juego << {:ficha => 4, :jugador => 0, :sentido => 0}
juego.unshift({8989 => 3223})
juego.push(:lol => 32)
puts T.fichas.inspect
h = Hash.new
i = 0
while i<4
	h[i] = []
	i += 1
end
puts h.inspect
h.each do |lol|
	lol[1] << 23
end
h.each do |lol|
	puts lol[1].inspect
end

v = [3,4,1]
a = 0
while a<5
	v.each do |e|
		puts e
	end
	puts "--"
	a += 1
end
fichitas = Hash.new
k = 0
txt = ""
txt += "id_ficha"+"\t"+"ficha"+"\n"
T.fichas.each do |ficha|
	txt += k.to_s+"\t\t\t"+ficha.inspect.to_s+"\n"
	k += 1
end
puts txt