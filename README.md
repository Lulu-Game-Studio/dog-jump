# Dog Platformer 🐶🎮

Dog Platformer es un juego de **plataformas 2D** donde controlas a un perro que salta entre plataformas, recoge monedas y se enfrenta a enemigos hasta llegar al jefe final, un gato naranja. 🐱

## Características principales ⭐

- Plataformas 2D estilo clásico, con mapa lineal de inicio a fin.
- Jugabilidad inspirada en los platformers tipo Mario.
- Sistema de vidas, trampas y recolectables.
- Escenas de interfaz básicas: pausa, opciones, victoria y derrota.

## Mecánicas de juego 🕹️

- El perro puede **saltar** para avanzar por el nivel y subirse a plataformas.
- Puede **matar enemigos saltando encima de ellos**.
- El jefe (gato) recibe daño cuando el jugador le salta en la cabeza; necesita 3 golpes para ser derrotado.
- El jugador tiene **3 vidas** ❤️; al recibir 3 golpes pierde la partida.
- Trampas:
  - Huecos al vacío que matan instantáneamente.
  - Pinchos y sierras que quitan 1 vida.
- Monedas:
  - Al recoger cierta cantidad de monedas (ejemplo: 100) el jugador recupera 1 punto de vida. 🪙
  - Las monedas podrían usarse más adelante para comprar skins para el perro.

## Interfaz de usuario 🧩

Elementos visibles durante la partida:

- Contador de **monedas** recogidas. 🪙
- Indicador de **vidas** restantes. ❤️

Escenas de interfaz implementadas:

- `pause.tscn` – Menú de pausa ⏸️.
- `options.tscn` – Opciones (volumen general, pantalla completa y botón Back) ⚙️.
- `winner.tscn` – Pantalla de victoria con botón de siguiente nivel y volver al menú 🏆.
- `loser.tscn` – Pantalla de derrota con botones de reintentar y volver al menú 💀.

## Enemigos 👾

- Enemigos básicos:
  - Rana.
  - Zorro.
- Jefe:
  - Gato naranja con 3 vidas, al que se le hace daño saltando en la cabeza. 😼

## Animaciones del personaje 🎞️

El perro cuenta con:

- Animación **Idle**, alternando entre cagar y ladrar mientras está quieto.
- Animación de **caminar** para moverse por el mapa.
- Animación de **saltar** para avanzar y atacar enemigos.

## Recursos gráficos y de sonido 📦🎵

Recursos previstos (sujetos a cambios):

- Personajes y enemigos:
  - Frogs Pixel Asset Pack – Pop Shop Packs  
	https://pop-shop-packs.itch.io/frogs-pixel-asset-pack
  - Cats Pixel Asset Pack – Pop Shop Packs  
	https://pop-shop-packs.itch.io/cats-pixel-asset-pack
  - 2D Pixel Art Fox Sprites – Elthen  
	https://elthen.itch.io/2d-pixel-art-fox-sprites

- Tilesets y escenarios:
  - Treasure Hunters – Pixel Frog  
	https://pixelfrog-assets.itch.io/treasure-hunters
  - Brackeys Platformer Bundle – Brackeys Games  
	https://brackeysgames.itch.io/brackeys-platformer-bundle
  - Pixel Adventure 1 – Pixel Frog  
	https://pixelfrog-assets.itch.io/pixel-adventure-1
  - Pixel Platformer – Kenney  
	https://kenney-assets.itch.io/pixel-platformer

- Sonido / música:
  - Pista de música principal (Mureka)  
	https://www.mureka.ai/song-detail/PMXyW9MFANUs5W9SqRiDqr?is_from_share=1

Revisar las licencias de cada asset antes de publicar el juego. ✅

## Estado del proyecto 🚧

Proyecto en desarrollo inicial:

- Motor: Godot 4.
- Implementadas escenas de menú (pausa, opciones, victoria, derrota).
- Pendiente:
  - Diseñar los niveles.
  - Implementar todos los enemigos y el jefe.
  - Sistema completo de monedas, vidas y skins.
