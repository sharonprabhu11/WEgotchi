local intro = {}

local font
local message = [[Our little WE gurly is preparing for her long journey ahead as a woman in STEM!
While she's busy brushing up on her collatz sequence, she might forget to eat or take a shower (it's completely normal, we promise)
soooo, it is up to you, yes, you to look after her
make sure our future leader is well fed, clean, takes her medicine, relaxed and MOST IMPORTANTLY - WELL RESTED!
we trust you, okay tc! ]]

local introduck
local rotate
local introduckX, introduckY
local changePositionInterval = 1
local timer = 0

local okayButton = {x = 0, y = 0, width = 200, height = 100}  -- Adjusted for scaling
local showIntro = true

function intro.load(pixelFont)
    font = pixelFont
    introduck = love.graphics.newImage("assets/introduck.png")
    intro.updatePositions()
end

function intro.update(dt)
    if showIntro then
        timer = timer + dt
        if timer >= changePositionInterval then
            timer = 0
            intro.updatePositions()
            rotate = math.random(1, 5)
        end
    end
end

function intro.draw()
    if showIntro then
        love.graphics.setFont(font)
        love.graphics.setColor(0.8, 0.6, 0.2)
        love.graphics.printf(message, love.graphics.getWidth() * 0.1, love.graphics.getHeight() * 0.1, love.graphics.getWidth() * 0.8, "center")
        love.graphics.setColor(0.8, 0.6, 0.2)
        love.graphics.rectangle("fill", okayButton.x, okayButton.y, okayButton.width, okayButton.height)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("okay", okayButton.x, okayButton.y + 20, okayButton.width, "center")
        
        -- Draw INTRODUCK with scaling
        love.graphics.draw(introduck, introduckX, introduckY, rotate, 0.4, 0.4)
    end
end

function intro.mousepressed(x, y, button)
    if showIntro and button == 1 then
        if x >= okayButton.x and x <= okayButton.x + okayButton.width and y >= okayButton.y and y <= okayButton.y + okayButton.height then
            showIntro = false
        end
    end
end

function intro.isActive()
    return showIntro
end

function intro.updatePositions()
    introduckX = math.random(0, love.graphics.getWidth() - introduck:getWidth() * 0.4)
    introduckY = math.random(0, love.graphics.getHeight() - introduck:getHeight() * 0.4)
    okayButton.x = love.graphics.getWidth() / 2 - okayButton.width / 2
    okayButton.y = love.graphics.getHeight() - okayButton.height - 50
end

function love.resize(w, h)
    intro.updatePositions()
end

return intro

