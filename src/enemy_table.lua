Enemy_Table = Class {}

function Enemy_Table:init()
    self.m_table = {}
end

function Enemy_Table:render()
    for k, v in ipairs(self.m_table) do
        v:render()
    end
end

function Enemy_Table:update(dt)
    -- Check for bullets' collisions with enemies
    for k, e in ipairs(self.m_table) do
        local enemy = ENEMY_QUADS_PROPERTIES[e.m_type]
        e:update(dt)

        for key, b in ipairs(Bullet_Table.m_table) do
            local bullet = BULLET_QUADS_PROPERTIES[b.m_type]
            if checkCollision(e.m_x, e.m_y, enemy.width, enemy.height, b.m_x, b.m_y, bullet.width, bullet.height) then
                e.m_hp = e.m_hp - bullet.damage
                table.remove(Bullet_Table.m_table, key)
                if (e.m_hp <= 0) then
                    table.remove(self.m_table, k)
                    return nil
                end
                break
            end
        end
    end
end

function Enemy_Table:add(x, y, type, formX, formY)
    table.insert(self.m_table, Enemy())
    self.m_table[#self.m_table]:init(x, y, type, formX, formY)
end