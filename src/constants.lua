WINDOW_WIDTH = 640
WINDOW_HEIGHT = 480

VIRTUAL_WIDTH = 1028
VIRTUAL_HEIGHT = 720

SHIPS_SPRITESHEET = love.graphics.newImage("assets/graphics/ships.png")

BGM = love.audio.newSource("assets/sounds/bgm.ogg", "stream")
BGM:setLooping(true)
BGM:setVolume(0.5)
BGM:play()

SINGLE = love.audio.newSource("assets/sounds/single.wav", "static")

