extends CSGSphere3D

var bola
var distbola = 99999
var bolapos = Vector3(0.0,0.0,0.0)

var robo_x = []
var robo_y = []
var robo_t = []
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
			robo_t.append(time)
		if x != null:
			robo_x.append(x)
		if y != null:
			robo_y.append(y)

# Called when the node enters the scene tree for the first time.
func _ready():
	bola = get_node("/root/Node3D/Bola")
	var file = FileAccess.open("res://trajetoria_robo.txt", FileAccess.READ)
	while not file.eof_reached():
		linhas.append(file.get_line())
	read_data_from_list(linhas)
	position = Vector3(robo_x[0],position.y,robo_y[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	frametime += delta
	if robo_t[cont] != null and distbola > 0.2:
		if frametime >= robo_t[cont] and robo_t[cont] != 20 and (cont < len(robo_x) and cont < len(robo_y)):
			distbola = sqrt((bola.position.x - position.x)**2 + (bola.position.z - position.z)**2)
			print(distbola)
			bolapos = Vector3(bola.position.x,bola.position.y,bola.position.z)
			if robo_x[cont] != null:
				position.x = robo_x[cont]
			if robo_y[cont] != null:
				position.z = robo_y[cont]
			cont+=1
	else:
		bola.position.x = bolapos.x
		bola.position.y = bolapos.y
		bola.position.z = bolapos.z
