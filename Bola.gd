extends CSGSphere3D

var bola_x = []
var bola_y = []
var bola_t = []
var linhas = []
var cont = 0
var frametime = 0.0

func read_data_from_list(list):
	for line in list:
		var time
		var x
		var y
		line = line.replace(",", ".")
		var linearr = line.split("\t")
		for i in range(len(linearr)):
			if i == 0:
				time = float(linearr[i])
			elif i == 1:
				x = float(linearr[i])
			elif i == 2:
				y = float(linearr[i])
		if time != null:
			bola_t.append(time)
		if x != null:
			bola_x.append(x)
		if y != null:
			bola_y.append(y)

# Called when the node enters the scene tree for the first time.
func _ready():	
	var file = FileAccess.open("res://trajetoria_bola.txt", FileAccess.READ)
	while not file.eof_reached():
		linhas.append(file.get_line())
	read_data_from_list(linhas)
	position = Vector3(bola_x[0],position.y,bola_y[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	frametime += delta
	if frametime >= bola_t[cont] and bola_t[cont] != 20:
		position.x = bola_x[cont]
		position.z = bola_y[cont]
		cont+=1
