Player = Class {}

local SPRITEWIDTH = 46
local SPRITEHEIGHT = 45
local SPRITEQUAD = love.graphics.newQuad(0, 51, SPRITEWIDTH, SPRITEHEIGHT, SHIPS_SPRITESHEET:getDimensions())

local HEALTHBARWIDTH = 98
local HEALTHBARHEIGHT = 32
local HEALTHBARQUAD = love.graphics.newQuad(0, 82, HEALTHBARWIDTH, HEALTHBARHEIGHT, HUD_SPRITESHEET:getDimensions())
local HEALTHBARLEFT = 80
local HEALTHBARFILLQUAD

local SPEED = 150
local COOLDOWN_SPEED = 50

local PROTECT_TIMER = 0
local PROTECT_COOLDOWN = 50

function Player:init()
    self.m_x = love.graphics.getWidth() / 2 - SPRITEWIDTH / 2
    self.m_y = love.graphics.getHeight() / 2 - SPRITEHEIGHT / 2
    self.m_width, self.m_height = SPRITEWIDTH, SPRITEHEIGHT
    self.m_currentPowerup = "single"
    self.m_cooldowntimer = 0

    self.m_HP = 100
    self.m_HPx = WINDOW_WIDTH - HEALTHBARWIDTH
    self.m_HPy = 0
end

function Player:render()
    -- When player is hurt, make it transparent
    if (PROTECT_TIMER ~= 0) then
        love.graphics.setColor(1, 1, 1, 0.7)
        love.graphics.draw(SHIPS_SPRITESHEET, SPRITEQUAD, self.m_x, self.m_y)
        love.graphics.setColor(255, 255, 255)
    else love.graphics.draw(SHIPS_SPRITESHEET, SPRITEQUAD, self.m_x, self.m_y) end

    -- Render health bar of player
    love.graphics.draw(HUD_SPRITESHEET, HEALTHBARQUAD, self.m_HPx, self.m_HPy)
    HEALTHBARFILLQUAD = love.graphics.newQuad(0, 64, HEALTHBARLEFT, 18, HUD_SPRITESHEET:getDimensions())
    love.graphics.draw(HUD_SPRITESHEET, HEALTHBARFILLQUAD, self.m_HPx + 9, self.m_HPy + 7)
end

function Player:update(dt)
    Player:move(self, dt)
    Player:shoot(self, dt)
    Player:hurt(self, dt)

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
            table.insert(Bullet_Table.m_table, Bullet())
            local last = #Bullet_Table.m_table
            Bullet_Table.m_table[last]:init(firstLeftX + i * 20, self.m_y, self.m_currentPowerup)
        end
    end
end

function Player:hurt(self, dt)
    local hitbox = { x = self.m_x + 6, y = self.m_y + 6, w = 34, h = 34 }
    if (PROTECT_TIMER == 0) then
        for k, v in ipairs(Enemy_Table.m_table) do
            -- if hit enemy, minus health, start cooldown timer
            local e = ENEMY_QUADS_PROPERTIES[v.m_type]
            local e_hb = { x = v.m_x + e.hitbox.dX, y = v.m_y + e.hitbox.dY, w = e.hitbox.w, h = e.hitbox.h}
            love.graphics.rectangle("fill", e_hb.x, e_hb.y, e_hb.w, e_hb.h)
            if (checkCollision(hitbox.x, hitbox.y, hitbox.w, hitbox.h, e_hb.x, e_hb.y, e_hb.w, e_hb.h)) then
                HEALTHBARLEFT = HEALTHBARLEFT - 80 / 100 * 20
                self.m_HP = self.m_HP - 20
                PROTECT_TIMER = 120
                HURT:play()
                break
            end
        end
    else PROTECT_TIMER = math.max(0, PROTECT_TIMER - PROTECT_COOLDOWN * dt) end

    if (self.m_HP <= 0) then
        love.event.quit()
    end
end