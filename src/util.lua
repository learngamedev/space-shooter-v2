-- AABB collision check
function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and
    x2 < x1 + w1 and
    y1 < y2 + h2 and
    y2 < y1 + h1
end

-- Keyboard input handler
function love.keypressed(key)
    -- Turn on/off debug mode
    if key == "rctrl" then --set to whatever key you want to use
        debug.debug()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

-- Mouse input handler
function love.mousepressed(x, y, button, istouch, presses)
    love.mouse.buttonsPressed[button] = true
end

function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function getNewQuad(properties, dWidth, dHeight)
    local pro = properties
    return love.graphics.newQuad(pro.x, pro.y, pro.width, pro.height, dWidth, dHeight)
end

-- Utility get string table func
function getStringTable(str)
    local table_string = {}
    str:gsub(".", function(c) table.insert(table_string, c) end)
    return table_string
end

-- Generate quads for letters from font file format: .png
local FONTCONTENT = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
local TABLE_FONTCONTENT = getStringTable(FONTCONTENT)
local FONTIMAGE = love.graphics.newImage("assets/fonts/normal.png")

function getLetterQuads()
    local letter_quads = {}

    local k = 0
    for i = 0, 7 do
        for j = 0, 14 do
            if (i == 6) and (j == 5) then
                return letter_quads
            end

            k = k + 1
            local quad = love.graphics.newQuad(j * 20, i * 20, 20, 20, FONTIMAGE:getDimensions())
            letter_quads[tostring(TABLE_FONTCONTENT[k])] = quad
        end
    end
end

-- Print custom string in bitmap sprite font
function printString(text, x, y)
    table_text = getStringTable(text)
    local Letter_Quads = getLetterQuads()

    for i = 0, #table_text - 1 do
        love.graphics.draw(FONTIMAGE, Letter_Quads[table_text[i+1]], x + i * 17, y)
    end
end

-- Watch FPS
function watchFPS()
    love.graphics.setColor(0, 255, 0)
    love.graphics.print("FPS: " ..love.timer.getFPS())
    love.graphics.setColor(255, 255, 255)
end