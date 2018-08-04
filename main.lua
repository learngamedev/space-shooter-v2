require("./src/dependencies")

function love.load()
    -- Keyboard and mouse input handler
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}

    player = Player()
    getBulletQuads()
    getEnemyQuads()

    enemyTable = EnemyTable()
    enemyTable:init()

    enemyTable:add(-30, 50, "minion", 50, 50)
    enemyTable:add(-30, 90, "minion", 90, 90)
    enemyTable:add(-30, 120, "minion", 120, 120)
    enemyTable:add(-30, 150, "minion", 150, 150)
    enemyTable:add(-30, 180, "minion", 180, 180)
    enemyTable:add(300, -380, "octoboss", 300, 200)
end

function love.draw()
    Background:render()

    player:render()
    for k, v in ipairs(Bullets) do
        v:render()
    end

    enemyTable:render()

    watchFPS()
end

function love.update(dt)
    if (dt < 1) then
        Background:update(dt)

        player:update(dt)

        for k, v in ipairs(Bullets) do
            v:update(dt)
        end

        enemyTable:update(dt)
    end
    -- Reset keyboard input
    love.keyboard.keysPressed = {}
end