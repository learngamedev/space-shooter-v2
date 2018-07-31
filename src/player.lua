Player = Class{}

local SPRITEWIDTH = 46
local SPRITEHEIGHT = 45
local SPRITEQUAD = love.graphics.newQuad(0, 51, SPRITEWIDTH, SPRITEHEIGHT, SHIPS_SPRITESHEET:getDimensions())
local SPEED = 150

function Player:init()
    self.m_x = love.graphics.getWidth() / 2 - SPRITEWIDTH / 2
    self.m_y = love.graphics.getHeight() / 2 - SPRITEHEIGHT / 2
end

function Player:render()
    love.graphics.draw(SHIPS_SPRITESHEET, SPRITEQUAD, self.m_x, self.m_y)
end

function Player:update(dt)
    Player:move(self, dt)
    Player:shoot(self, dt)
end

function Player:move(self, dt)
    if (love.keyboard.isDown("up")) then
        self.m_y = math.max(0, self.m_y - SPEED * dt)
    elseif (love.keyboard.isDown("down")) then
        self.m_y = math.min(WINDOW_HEIGHT - SPRITEHEIGHT, self.m_y + SPEED * dt)
    end
    if (love.keyboard.isDown("left")) then
        self.m_x = math.max(0, self.m_x - SPEED * dt)
    elseif (love.keyboard.isDown("right")) then
        self.m_x = math.min(WINDOW_WIDTH - SPRITEWIDTH, self.m_x + SPEED * dt)
    end
end

function Player:shoot(self, dt)
    if (love.keyboard.wasPressed("space")) then
        table.insert(Bullets, Bullet())
        Bullets[#Bullets]:init(self.m_x + SPRITEWIDTH / 2 - 5, self.m_y)
    end
end