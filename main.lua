require("./src/dependencies")

function love.load()
    -- Screen setup (resolution, fullscreen, anti-aliasing, etc.)
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = false})

    -- Keyboard input handler
    love.keyboard.keysPressed = {}

    -- Mouse input handler
    love.mouse.buttonsPressed = {}
end

function love.draw()
    push:start()

    push:finish()

    love.graphics.setColor(0, 255, 0)
    love.graphics.print("FPS: "..love.timer.getFPS())
    love.graphics.setColor(255, 255, 255)
end

function love.update(dt)
    -- Reset keyboard input
    love.keyboard.keysPressed = {}
end