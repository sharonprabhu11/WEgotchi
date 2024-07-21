-- intro.lua
local intro = {}

local font
local message = [[our little WE gurly is preparing for her long journey ahead as a woman in STEM!
while she's busy brushing up on her collatz sequence, she might forget to eat or take a shower (it's completely normal, we promise)
soooo, it is up to you, yes, you to look after her
make sure our future leader is well fed, clean, takes her medicine, relaxed and MOST IMPORTANTLY - WELL RESTED!

we trust you, okay tc! ]]
local okayButton = {x = 750, y = 800, width = 100, height = 50}
local showIntro = true

function intro.load(pixelFont)
    font = pixelFont
end

function intro.update(dt)

end

function intro.draw()
    if showIntro then
        love.graphics.setFont(font)
        love.graphics.setColor(0.8, 0.6, 0.2)
        love.graphics.printf(message, 400, 180, 800, "center")
        love.graphics.setColor(0.8, 0.6, 0.2)
        love.graphics.rectangle("fill", okayButton.x, okayButton.y, okayButton.width, okayButton.height)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("okay", okayButton.x, okayButton.y + 3, okayButton.width, "center")
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

return intro
