WINDOW_WIDTH = 640
WINDOW_HEIGHT = 480

VIRTUAL_WIDTH = 1028
VIRTUAL_HEIGHT = 720

SHIPS_SPRITESHEET = love.graphics.newImage("assets/graphics/ships.png")
HUD_SPRITESHEET = love.graphics.newImage("assets/graphics/hud.png")

BGM = love.audio.newSource("assets/sounds/bgm.ogg", "stream")
BGM:setLooping(true)
BGM:setVolume(0.2)
BGM:play()

SINGLE = love.audio.newSource("assets/sounds/single.wav", "static")
HURT = love.audio.newSource("assets/sounds/hurt.wav", "static")

math.randomseed(os.time())
