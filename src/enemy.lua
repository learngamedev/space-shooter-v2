Enemy = Class {}

Enemies = {}

ENEMY_QUADS_PROPERTIES = {
    ["minion"] = {
        x = 56, y = 295,
        width = 27, height = 25,
        speed = 100, hp = 20
    },
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
    -- Fixed a bug where type is first nil and then back to normal after 1 frame
    self.m_speed = ENEMY_QUADS_PROPERTIES[self.m_type or "minion"].speed
    self.m_hp = ENEMY_QUADS_PROPERTIES[self.m_type or "minion"].hp
end

function Enemy:render()
    love.graphics.draw(SHIPS_SPRITESHEET, ENEMY_QUADS[self.m_type], self.m_x, self.m_y)
end

function Enemy:update(dt)
    Enemy:moveToFormation(self, dt)
end

function Enemy:moveToFormation(self, dt)
    if (self.m_x ~= self.m_formX) then
        local deltaX = self.m_formX - self.m_x
        if (deltaX > 0) then
            self.m_x = math.min(self.m_formX, self.m_x + deltaX / deltaX * self.m_speed * dt)
        elseif (deltaX < 0) then
            self.m_x = math.max(self.m_formX, self.m_x - deltaX / deltaX * self.m_speed * dt)
        end
    elseif (self.m_y ~= self.m_formY) then
        local deltaY = self.m_formY - self.m_y
        if (deltaY > 0) then
            self.m_y = math.min(self.m_formY, self.m_y + deltaY / deltaY * self.m_speed * dt)
        elseif (deltaY < 0) then
            self.m_y = math.max(self.m_formY, self.m_y - deltaY / deltaY * self.m_speed * dt)
        end
    end
end