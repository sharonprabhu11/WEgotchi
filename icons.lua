local icon = {}
local eat = require("eat")
local med = require("med")

local iconSprites = {}
local iconPositions = {}
local iconSelected = 1
local iconScale = 0.35

local lightOffIcon
local lightOnIcon
local lightIcon
local lightIconScale = 0.3
local lightOn = true  

local backButton = {
    x = 100,
    y = 900,
    width = 50,
    height = 50
}

local OKButton = {
    x = 200,
    y = 900,
    width = 50,
    height = 50
}

local forwardButton = {
    x = 300,
    y = 900,
    width = 50,
    height = 50
}

function icon.load()
    iconSprites = {
        love.graphics.newImage("assets/icons/clean.png"),
        love.graphics.newImage("assets/icons/food.png"),
        love.graphics.newImage("assets/icons/game.png"),
        love.graphics.newImage("assets/icons/medicine.png")
    }

    lightOnIcon = love.graphics.newImage("assets/icons/light_on.png")
    lightOffIcon = love.graphics.newImage("assets/icons/light_off.png")
    lightIcon = lightOnIcon  

    iconSelected = 1

    local iconSpacing = 320
    local iconX = 50
    for i, iconImg in ipairs(iconSprites) do
        table.insert(iconPositions, { x = iconX, y = 0 })
        iconX = iconX + iconSpacing
    end

    table.insert(iconSprites, lightOnIcon)
    table.insert(iconPositions, { x = 1300, y = 750 })
end

function icon.draw()
    for i, iconImg in ipairs(iconSprites) do
        local scale = iconScale
        if i == iconSelected then
            scale = iconScale * 1.1
        end
        love.graphics.draw(iconImg, iconPositions[i].x, iconPositions[i].y, 0, scale)
        if i == iconSelected then
            love.graphics.rectangle("line", iconPositions[i].x, iconPositions[i].y + 10, iconImg:getWidth() * scale, iconImg:getHeight() * scale)
        end
    end

    -- nav buttons
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", backButton.x, backButton.y, backButton.width, backButton.height)
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", OKButton.x, OKButton.y, OKButton.width, OKButton.height)
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", forwardButton.x, forwardButton.y, forwardButton.width, forwardButton.height)

end

function icon.selectNext()
    iconSelected = iconSelected + 1
    if iconSelected > #iconSprites then
        iconSelected = 1
    end
end

function icon.selectPrevious()
    iconSelected = iconSelected - 1
    if iconSelected < 1 then
        iconSelected = #iconSprites
    end
end

function icon.executeAction()
    if iconSelected == 1 then
        -- clean func
    elseif iconSelected == 2 then
        eat.start()
    elseif iconSelected == 3 then
        -- game func
    elseif iconSelected == 4 then
        med.start()
    elseif iconSelected == 5 then
        icon.toggleLight()
    end
end

function icon.toggleLight()
    lightOn = not lightOn
    if lightOn then
        lightIcon = lightOnIcon
    else
        lightIcon = lightOffIcon
    end
end

function icon.isLightOn()
    return lightOn
end

function icon.mousepressed(x, y, button)
    if button == 1 then
        if x >= backButton.x and x <= backButton.x + backButton.width and
           y >= backButton.y and y <= backButton.y + backButton.height then
            icon.selectPrevious()
        end

        if x >= forwardButton.x and x <= forwardButton.x + forwardButton.width and
           y >= forwardButton.y and y <= forwardButton.y + forwardButton.height then
            icon.selectNext()
        end

        if x >= OKButton.x and x <= OKButton.x + OKButton.width and
           y >= OKButton.y and y <= OKButton.y + OKButton.height then
            icon.executeAction()
        end
    end
end

return icon
