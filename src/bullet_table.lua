Bullet_Table = {}

function Bullet_Table:init()
    self.m_table = {}
end

function Bullet_Table:render()
    for k, v in ipairs(self.m_table) do
        v:render()
    end
end

function Bullet_Table:update(dt)
    for k, v in ipairs(self.m_table) do
        v:update(dt)
    end
end