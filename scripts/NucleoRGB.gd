extends MeshInstance3D

@onready var lampada = $OmniLight3D

# Configurações
@export var velocidade_rgb: float = 0.5
@export var intensidade_neon: float = 5.0 # Brilho do objeto
@export var intensidade_luz: float = 2.0  # Força da iluminação nas peças

var modo_rgb = true
var hue_atual = 0.0

func _input(event):
	if event.is_action_pressed("alternar_luz"):
		alternar_modo()

func alternar_modo():
	modo_rgb = !modo_rgb
	if not modo_rgb:
		aplicar_cor(Color.WHITE)

func _process(delta):
	if modo_rgb:
		hue_atual += delta * velocidade_rgb
		if hue_atual > 1.0:
			hue_atual = 0.0
		var cor_rainbow = Color.from_hsv(hue_atual, 1.0, 1.0)
		aplicar_cor(cor_rainbow)

func aplicar_cor(cor: Color):
	# 1. Configura a Lâmpada (Iluminação do ambiente)
	if lampada:
		lampada.light_color = cor
		lampada.light_energy = intensidade_luz # AQUI ESTÁ O SEGREDO!
	
	# 2. Configura o Material (O brilho visual da esfera)
	var material = get_active_material(0)
	if material:
		material.emission = cor
		material.emission_energy_multiplier = intensidade_neon
