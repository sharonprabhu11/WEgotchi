local icons = {}
local eat = require("eat")
local med = require("med")
local game = require("game")
local clean = require("cleaning")

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

local medIconClicked = false
local eatIconClicked = false
local gameIconClicked = false
local cleanIconClicked = false

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

    local iconSpacing = 320
    local iconX = 50
    for i, iconImg in ipairs(iconSprites) do
        table.insert(iconPositions, { x = iconX, y = 0 })
        iconX = iconX + iconSpacing
    end

    table.insert(iconSprites, lightIcon)
    table.insert(iconPositions, { x = 1300, y = 750 })
end

function icons.draw()
    if not lightOn then
        love.graphics.setColor(1, 1, 1) 

       
        local windowWidth, windowHeight = love.graphics.getDimensions()
        
       
        local imgWidth, imgHeight = bgnight:getDimensions()
     
        local scaleX = windowWidth / imgWidth
        local scaleY = windowHeight / imgHeight
        local scale = math.min(scaleX, scaleY)
        
       
        local x = (windowWidth - imgWidth * scale) / 2
        local y = (windowHeight - imgHeight * scale) / 2
        
      
        love.graphics.draw(bgnight, x, y, 0, scale, scale)
        love.graphics.draw(lightOffIcon, 1305, 750, 0, 0.38)
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
        cleanIconClicked = true
        clean.start()
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

function icons.stopMainGameMusic()
    if mainGameSource and mainGameSource:isPlaying() then
        mainGameSource:stop()
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

        if x >= OKButton.x and x <= OKButton.x + OKButton.width and y >= OKButton.y and y <= OKButton.y + OKButton.height then
            icons.executeAction()
            icons.stopMainGameMusic()
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

function icons.resetCleanIconClicked()
    cleanIconClicked = false
end

function icons.isCleanIconClicked()
    return cleanIconClicked
end

-- Expose the buttons for external access
icons.backButton = backButton
icons.OKButton = OKButton
icons.forwardButton = forwardButton

return icons
