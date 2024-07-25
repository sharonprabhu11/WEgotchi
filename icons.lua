local icons = {}
local eat = require("eat")
local med = require("med")
local game = require("game")

local iconSprites = {}
local iconPositions = {}
local iconSelected = 1
local iconScale = 0.35

local lightOffIcon
local lightOnIcon
local lightIcon
local lightIconScale = 0.3
local lightOn = true
local sleepImage
local bgnight

local eatIconClicked = false
local gameIconClicked = false

local screen_width, screen_height = love.graphics.getDimensions()
local backButton = {
    x = screen_width * 0.06,
    y = screen_height * 0.87,
    width = screen_width * 0.03,
    height = screen_height * 0.05
}

local OKButton = {
    x = screen_width * 0.12,
    y = screen_height * 0.87,
    width = screen_width * 0.03,
    height = screen_height * 0.05
}

local forwardButton = {
    x = screen_width * 0.18,
    y = screen_height * 0.87,
    width = screen_width * 0.03,
    height = screen_height * 0.05
}

function icons.load()
    iconSprites = {
        love.graphics.newImage("assets/icons/clean.png"),
        love.graphics.newImage("assets/icons/food.png"),
        love.graphics.newImage("assets/icons/game.png"),
        love.graphics.newImage("assets/icons/medicine.png")
    }

    lightOnIcon = love.graphics.newImage("assets/icons/light_on.png")
    lightOffIcon = love.graphics.newImage("assets/icons/light_off.png")
    lightIcon = lightOnIcon

    sleepImage = love.graphics.newImage("assets/girl/sleep.png")
    bgnight = love.graphics.newImage("assets/bgnight.png")

    iconSelected = 1

    local iconSpacing = screen_width / 4.5
    local iconX = screen_width * 0.03
    for i, iconImg in ipairs(iconSprites) do
        table.insert(iconPositions, { x = iconX, y = screen_height * 0.05 })
        iconX = iconX + iconSpacing
    end

    table.insert(iconSprites, lightIcon)
    table.insert(iconPositions, { x = screen_width * 0.8, y = screen_height * 0.7 })
end

function icons.draw()
    if not lightOn then
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(bgnight, 0, 0, 0, screen_width / bgnight:getWidth(), screen_height / bgnight:getHeight())
        love.graphics.draw(lightOffIcon, screen_width * 0.81, screen_height * 0.71, 0, lightIconScale)
    else
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

        -- forward/back nav buttons
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", backButton.x, backButton.y, backButton.width, backButton.height)

        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", forwardButton.x, forwardButton.y, forwardButton.width, forwardButton.height)
    end
    -- ok buttons
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", OKButton.x, OKButton.y, OKButton.width, OKButton.height)
end

function icons.selectNext()
    iconSelected = iconSelected + 1
    if iconSelected > #iconSprites then
        iconSelected = 1
    end
end

function icons.selectPrevious()
    iconSelected = iconSelected - 1
    if iconSelected < 1 then
        iconSelected = #iconSprites
    end
end

function icons.executeAction()
    if iconSelected == 1 then
        -- clean func
    elseif iconSelected == 2 then
        eatIconClicked = true  
        eat.start()
    elseif iconSelected == 3 then
        gameIconClicked = true
        game.start()
    elseif iconSelected == 4 then
        medIconClicked = true
        med.start()
    elseif iconSelected == 5 then
        icons.toggleLight()
    end
end

function icons.toggleLight()
    lightOn = not lightOn
    if lightOn then
        lightIcon = lightOnIcon
    else
        lightIcon = lightOffIcon
    end
end

function icons.isLightOn()
    return lightOn
end

function icons.shouldStartGame()
    return iconSelected == 3
end

function icons.mousepressed(x, y, button)
    if button == 1 then
        if x >= backButton.x and x <= backButton.x + backButton.width and
           y >= backButton.y and y <= backButton.y + backButton.height then
            icons.selectPrevious()
        end

        if x >= forwardButton.x and x <= forwardButton.x + forwardButton.width and
           y >= forwardButton.y and y <= forwardButton.y + forwardButton.height then
            icons.selectNext()
        end

        if x >= OKButton.x and x <= OKButton.x + OKButton.width and
           y >= OKButton.y and y <= OKButton.y + OKButton.height then
            icons.executeAction()
        end
    end
end

function icons.resetEatIconClicked()
    eatIconClicked = false
end

function icons.isEatIconClicked()
    return eatIconClicked
end

function icons.resetGameIconClicked()
    gameIconClicked = false
end

function icons.isGameIconClicked()
    return gameIconClicked
end

function icons.resetMedIconClicked()
    medIconClicked = false
end

function icons.isMedIconClicked()
    return medIconClicked
end

return icons

