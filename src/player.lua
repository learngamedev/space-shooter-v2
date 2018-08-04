Player = Class{}

local SPRITEWIDTH = 46
local SPRITEHEIGHT = 45
local SPRITEQUAD = love.graphics.newQuad(0, 51, SPRITEWIDTH, SPRITEHEIGHT, SHIPS_SPRITESHEET:getDimensions())
local SPEED = 150
local COOLDOWN_SPEED = 50

function Player:init()
    self.m_x = love.graphics.getWidth() / 2 - SPRITEWIDTH / 2
    self.m_y = love.graphics.getHeight() / 2 - SPRITEHEIGHT / 2
    self.m_currentPowerup = "single"
    self.m_cooldowntimer = 0
end

function Player:render()
    love.graphics.draw(SHIPS_SPRITESHEET, SPRITEQUAD, self.m_x, self.m_y)
end

function Player:update(dt)
    Player:move(self, dt)
    Player:shoot(self, dt)

    -- Update cooldown timer
    self.m_cooldowntimer = math.max(0, self.m_cooldowntimer - COOLDOWN_SPEED * dt)
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
    if (love.keyboard.wasPressed("space")) and (self.m_cooldowntimer == 0) then
        SINGLE:play()

        -- Start cooldown timer
        self.m_cooldowntimer = BULLET_QUADS_PROPERTIES[self.m_currentPowerup].cooldown

        -- Calculate total width of each layer of bullets to align center to player
        local bullets = BULLET_QUADS_PROPERTIES[self.m_currentPowerup].bullets
        local totalWidth = 0
        for i = 1, bullets do
            totalWidth = i * BULLET_QUADS_PROPERTIES[self.m_currentPowerup].width
        end
        -- Calculate first X of the most left bullet
        if (bullets >= 2) then totalWidth = totalWidth + 5 * bullets end
        local firstLeftX = self.m_x + SPRITEWIDTH / 2 - totalWidth / 2
        -- Generate bullets after being aligned center to player
        for i = 0, bullets - 1 do
            table.insert(Bullets, Bullet())
            Bullets[#Bullets]:init(firstLeftX + i * 20, self.m_y, self.m_currentPowerup)
        end
    end
end