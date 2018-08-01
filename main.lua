require("./src/dependencies")

function love.load()
    -- Keyboard and mouse input handler
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}

    player = Player()
    getBulletQuads()
end

function love.draw()
    love.graphics.setColor(0, 255, 0)
    love.graphics.print("FPS: "..love.timer.getFPS())
    love.graphics.setColor(255, 255, 255)

    player:render()
    for k, v in ipairs(Bullets) do
        v:render()
    end

    printString("Hello, world", 0, 100)
end

function love.update(dt)
    player:update(dt)
    
    for k, v in ipairs(Bullets) do
        v:update(dt)
    end

    -- Reset keyboard input
    love.keyboard.keysPressed = {}
end