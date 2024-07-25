local icon = {}

local lightOn = false
local funIconClicked = false
local eatIconClicked = false
local medIconClicked = false

local icons = {}

local windowWidth, windowHeight

function icon.load()
    icons.light = love.graphics.newImage("assets/icons/light.png")
    icons.fun = love.graphics.newImage("assets/icons/fun.png")
    icons.eat = love.graphics.newImage("assets/icons/eat.png")
    icons.med = love.graphics.newImage("assets/icons/med.png")
    windowWidth, windowHeight = love.graphics.getDimensions()
end

function icon.draw()
    love.graphics.push()
    love.graphics.scale(windowWidth / 1920, windowHeight / 1080) -- Assuming original design resolution is 1920x1080
    love.graphics.draw(icons.light, 100, 100)
    love.graphics.draw(icons.fun, 200, 100)
    love.graphics.draw(icons.eat, 300, 100)
    love.graphics.draw(icons.med, 400, 100)
    love.graphics.pop()
end

function icon.mousepressed(x, y, button)
    if button == 1 then
        if x >= 100 and x <= 100 + icons.light:getWidth() and y >= 100 and y <= 100 + icons.light:getHeight() then
            lightOn = not lightOn
        elseif x >= 200 and x <= 200 + icons.fun:getWidth() and y >= 100 and y <= 100 + icons.fun:getHeight() then
            funIconClicked = true
        elseif x >= 300 and x <= 300 + icons.eat:getWidth() and y >= 100 and y <= 100 + icons.eat:getHeight() then
            eatIconClicked = true
        elseif x >= 400 and x <= 400 + icons.med:getWidth() and y >= 100 and y <= 100 + icons.med:getHeight() then
            medIconClicked = true
        end
    end
end

function icon.isLightOn()
    return lightOn
end

function icon.isFunIconClicked()
    return funIconClicked
end

function icon.resetFunIconClicked()
    funIconClicked = false
end

function icon.isEatIconClicked()
    return eatIconClicked
end

function icon.resetEatIconClicked()
    eatIconClicked = false
end

function icon.isMedIconClicked()
    return medIconClicked
end

function icon.resetMedIconClicked()
    medIconClicked = false
end

return icon

