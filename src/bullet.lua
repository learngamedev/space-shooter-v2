Bullet = Class {}

Bullets = {}

local BULLETS_SPRITESHEET = love.graphics.newImage("assets/graphics/bullets.png")
local SPEED = 260

local BULLET_QUADS = {}
BULLET_QUADS.dWidth = BULLETS_SPRITESHEET:getWidth()
BULLET_QUADS.dHeight = BULLETS_SPRITESHEET:getHeight()

BULLET_QUADS_PROPERTIES = {
    ["single"] = {
        x = 0, y = 0,
        width = 10, height = 10,
        cooldown = 50, bullets = 1,
        damage = 10
    },
    ["double"] = {
        x = 10, y = 0,
        width = 8, height = 17,
        cooldown = 80, bullets = 2
    },
    ["triple"] = {
        x = 37, y = 0,
        width = 12, height = 17,
        cooldown = 90, bullets = 3
    }
}

function getBulletQuads()
    for k, v in pairs(BULLET_QUADS_PROPERTIES) do
        BULLET_QUADS[k] = getNewQuad(v, BULLET_QUADS.dWidth, BULLET_QUADS.dHeight)
    end
end

function Bullet:init(x, y, type)
    self.m_x = x
    self.m_y = y
    self.m_type = type
end

function Bullet:render()
    love.graphics.draw(BULLETS_SPRITESHEET, BULLET_QUADS[self.m_type or "single"], self.m_x, self.m_y)
end

function Bullet:update(dt)
    if (self.m_y >= -10) then
        self.m_y = self.m_y - SPEED * dt
    else
        table.remove(Bullets, 1) -- remove the first existing bullet shot
    end
end