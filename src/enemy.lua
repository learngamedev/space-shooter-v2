Enemy = Class {}

Enemies = {}

ENEMY_QUADS_PROPERTIES = {
    ["minion"] = {
        x = 56, y = 295,
        width = 27, height = 25,
        speed = 100, hp = 20
    },
    ["octoboss"] = {
        x = 0, y = 295,
        width = 56, height = 51,
        speed = 200, hp = 300
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
    self.m_type = type
    self.m_formX, self.m_formY = formX, formY
    self.m_formReached = false
    self.m_posReached = false
    -- Fixed a bug where type is first nil and then back to normal after 1 frame
    self.m_speed = ENEMY_QUADS_PROPERTIES[self.m_type or "minion"].speed
    self.m_hp = ENEMY_QUADS_PROPERTIES[self.m_type or "minion"].hp
end

function Enemy:render()
    love.graphics.draw(SHIPS_SPRITESHEET, ENEMY_QUADS[self.m_type], self.m_x, self.m_y)
end

function Enemy:update(dt)
    if (not self.m_formReached) then
        Enemy:moveToFormation(self, dt, self.m_formX, self.m_formY)
    elseif (self.m_posReached) then
        
    end
end

function Enemy:moveToFormation(self, dt, formX, formY)
    Enemy:move(self, dt, formX, formY)
    if (self.m_posReached) then
        self.m_formReached = true
        self.m_posReached = false
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
    elseif (self.m_y ~= self.m_formY) then
        local deltaY = self.m_formY - self.m_y
        if (deltaY > 0) then
            self.m_y = math.min(self.m_formY, self.m_y + deltaY / deltaY * self.m_speed * dt)
        elseif (deltaY < 0) then
            self.m_y = math.max(self.m_formY, self.m_y - deltaY / deltaY * self.m_speed * dt)
        end
    end
    if (newX == self.m_x) and (self.m_y == self.m_formY) then
        self.m_posReached = true
    end
end