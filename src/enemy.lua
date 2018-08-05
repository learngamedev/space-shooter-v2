Enemy = Class {}

Enemies = {}

ENEMY_QUADS_PROPERTIES = {
    ["minion"] = {
        x = 56, y = 295,
        width = 27, height = 25,
        speed = 70, hp = 40,
        hitbox = { dX = 2, dY = 3, w = 23, h = 20 }
    },
    ["octoboss"] = {
        x = 0, y = 295,
        width = 56, height = 51,
        speed = 45, hp = 400,
        hitbox = { dX = 5, dY = 4, w = 46, h = 42 }
    }
}

local ENEMY_QUADS = {}

function getEnemyQuads()
    for k, v in pairs(ENEMY_QUADS_PROPERTIES) do
        ENEMY_QUADS[k] = getNewQuad(v, SHIPS_SPRITESHEET:getWidth(), SHIPS_SPRITESHEET:getHeight())
    end
end

function Enemy:init(x, y, type, formX, formY)
    self.m_x, self.m_y = x, y
    -- Fixed a bug where type is first nil and then back to normal after 1 frame
    self.m_type = type or "minion"
    self.m_width, self.m_height = ENEMY_QUADS_PROPERTIES[self.m_type].width, ENEMY_QUADS_PROPERTIES[self.m_type].height
    self.m_formX, self.m_formY = formX, formY

    self.m_formReached = false
    self.m_posReached = false
    -- Random positions
    self.m_randX = nil
    self.m_randY = nil
    self.m_speed = ENEMY_QUADS_PROPERTIES[self.m_type].speed
    self.m_hp = ENEMY_QUADS_PROPERTIES[self.m_type].hp
end

function Enemy:render()
    love.graphics.draw(SHIPS_SPRITESHEET, ENEMY_QUADS[self.m_type], self.m_x, self.m_y)
end

function Enemy:update(dt)
    if (not self.m_formReached) then
        Enemy:moveToFormation(self, dt, self.m_formX, self.m_formY)
    else
        if (self.m_type == "octoboss") then
            Enemy:chasePlayer(self, dt)
        else
            -- If reached position, get a random new one
            if (self.m_posReached) then
                self.m_randX, self.m_randY = Enemy:getRandomPos(self)
                self.m_posReached = false
            else Enemy:move(self, dt, self.m_randX, self.m_randY) end
        end
    end
end

function Enemy:moveToFormation(self, dt, formX, formY)
    Enemy:move(self, dt, formX, formY)
    if (self.m_posReached) then
        self.m_formReached = true
    end
end

function Enemy:move(self, dt, newX, newY)
    if (self.m_x ~= newX) then
        local deltaX = newX - self.m_x
        if (deltaX > 0) then
            self.m_x = math.min(newX, self.m_x + deltaX / deltaX * self.m_speed * dt)
        elseif (deltaX < 0) then
            self.m_x = math.max(newX, self.m_x - deltaX / deltaX * self.m_speed * dt)
        end
    end
    
    if (self.m_y ~= newY) then
        local deltaY = newY - self.m_y
        if (deltaY > 0) then
            self.m_y = math.min(newY, self.m_y + deltaY / deltaY * self.m_speed * dt)
        elseif (deltaY < 0) then
            self.m_y = math.max(newY, self.m_y - deltaY / deltaY * self.m_speed * dt)
        end
    end

    if (self.m_x == newX) and (self.m_y == newY) then
        self.m_posReached = true
    end
end

function Enemy:getRandomPos(self)
    local randX = math.random(WINDOW_WIDTH - ENEMY_QUADS_PROPERTIES[self.m_type].width)
    local randY = math.random(WINDOW_HEIGHT - ENEMY_QUADS_PROPERTIES[self.m_type].height)
    return randX, randY
end

function Enemy:chasePlayer(self, dt)
    Enemy:move(self, dt, player.m_x, player.m_y)
end