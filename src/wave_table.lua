Wave_Table = {}

function Wave_Table:init()
    self.m_waveCount = tonumber(love.filesystem.read("data/enemies.txt", 1), 10)
    self.m_currentWave = 1
    self.m_initWave = true
    self.m_annouceNewWaveTimer = 200

    for i = 1, self.m_waveCount do
        Wave_Table[i] = {}
        Wave_Table[i].enemies = {}
    end

    -- Read enemies positions from file and add to according Wave_Table[i].enemies
    for line in love.filesystem.lines("data/enemies.txt") do
        wave, x, y, etype, formX, formY = string.match(line, "(%d+) (%d+) (%d+) (%a+) (%d+) (%d+)")
        -- turn read strings into numbers
        wave, x, y, formX, formY = tonumber(wave), tonumber(x), tonumber(y), tonumber(formX), tonumber(formY)

        -- skip nil wave at start
        if (wave ~= nil) then table.insert(Wave_Table[tonumber(wave)].enemies, { x, y, etype, formX, formY }) end
    end
end

function Wave_Table:render()
    if (self.m_annouceNewWaveTimer ~= 0) then
        printString("Wave "..self.m_currentWave, WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2)
    end

    print(self.m_annouceNewWaveTimer)
end

function Wave_Table:update(dt)
    -- If init new wave, start timer, countdown timer
    if (self.m_initWave) then self.m_annouceNewWaveTimer = 100 end
    if (self.m_annouceNewWaveTimer ~= 0) then 
        self.m_annouceNewWaveTimer =  math.max(0, self.m_annouceNewWaveTimer - 50 * dt)
    end

    -- Initialize new wave with new enemies
    if (self.m_initWave) then
        for k, v in ipairs((Wave_Table[self.m_currentWave]).enemies) do
            Enemy_Table:add(v[1], v[2], v[3], v[4], v[5])
        end
        self.m_initWave = false
    end

    -- If run out of enemy, init new wave
    if (#Enemy_Table.m_table == 0) then
        self.m_currentWave = self.m_currentWave + 1
        self.m_initWave = true
    end
end