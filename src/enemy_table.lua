EnemyTable = Class {}

function EnemyTable:init()
    self.table = {}
end

function EnemyTable:render()
    for k, v in ipairs(self.table) do
        v:render()
    end
end

function EnemyTable:update(dt)
    -- Check for bullets' collisions with enemies
    for k, e in ipairs(self.table) do
        local enemy = ENEMY_QUADS_PROPERTIES[e.m_type]
        e:update(dt)

        for key, b in ipairs(Bullets) do
            local bullet = BULLET_QUADS_PROPERTIES[b.m_type]
            if checkCollision(e.m_x, e.m_y, enemy.width, enemy.height, b.m_x, b.m_y, bullet.width, bullet.height) then
                e.m_hp = e.m_hp - bullet.damage
                table.remove(Bullets, key)
                if (e.m_hp <= 0) then
                    table.remove(self.table, k)
                    return nil
                end
                break
            end
        end
    end
end

function EnemyTable:add(x, y, type, formX, formY)
    table.insert(self.table, Enemy())
    self.table[#self.table]:init(x, y, type, formX, formY)
end