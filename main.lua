require("./src/dependencies")

function love.load()
    -- Keyboard and mouse input handler
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}

    player = Player()
    getBulletQuads()
    getEnemyQuads()

    Enemy_Table:init()
    Bullet_Table:init()
    Wave_Table:init()
end

function love.draw()
    Background:render()
    player:render()
    Bullet_Table:render()
    Enemy_Table:render()
    Wave_Table:render()
    watchFPS()
end

function love.update(dt)
    if (dt < 1) then
        Background:update(dt)
        player:update(dt)
        Bullet_Table:update(dt)
        Enemy_Table:update(dt)
        Wave_Table:update(dt)
    end
    -- Reset keyboard input
    love.keyboard.keysPressed = {}
end