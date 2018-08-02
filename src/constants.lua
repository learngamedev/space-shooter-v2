WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

VIRTUAL_WIDTH = 1028
VIRTUAL_HEIGHT = 720

SHIPS_SPRITESHEET = love.graphics.newImage("assets/graphics/ships.png")

BGM = love.audio.newSource("assets/sounds/bgm.ogg", "static")
BGM:setLooping(true)
BGM:play()