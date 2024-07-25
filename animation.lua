local icon = require("icons")
local happiness = require('happiness_meter')
local energy = require('energy_meter')
local hunger = require('hunger_meter')
local anim = {}

local girlSprites = {}
local currentSprite
local showAnimation = true
local animationTimer = 0
local animationSpeed = 1
local direction = "L"
local sleep
local gameOver = false

function anim.load()
    girlSprites = {
        happyL = love.graphics.newImage("assets/girl/happyL.png"),
        happyR = love.graphics.newImage("assets/girl/happyR.png"),
        neutL = love.graphics.newImage("assets/girl/neutL.png"),
        neutR = love.graphics.newImage("assets/girl/neutR.png"),
        sadL = love.graphics.newImage("assets/girl/angryL.png"),
        sadR = love.graphics.newImage("assets/girl/angryR.png"),
        cryL = love.graphics.newImage("assets/girl/cryL.png"),
        cryR = love.graphics.newImage("assets/girl/cryR.png"),
        dead = love.graphics.newImage("assets/girl/dead.png"),
        stinkyL = love.graphics.newImage("assets/girl/stinkyL.png"),
        stinkyR = love.graphics.newImage("assets/girl/stinkyR.png")
    }
    currentSprite = girlSprites.neutL
    sleep = love.graphics.newImage("assets/girl/sleep.png")
end

function anim.update(dt)
    if gameOver then
        return
    end

    if showAnimation and icon.isLightOn() then
        local totalPercent = (energy.percentage() + happiness.percentage() + hunger.percentage()) / 3
        print(totalPercent)
        
        if totalPercent == 0 then
            currentSprite = girlSprites.dead
            gameOver = true
        else
            if totalPercent <= 20 then
                currentSprite = (direction == "L") and girlSprites.cryL or girlSprites.cryR
            elseif totalPercent <= 40 then
                currentSprite = (direction == "L") and girlSprites.sadL or girlSprites.sadR
            elseif totalPercent <= 60 then
                currentSprite = (direction == "L") and girlSprites.neutL or girlSprites.neutR
            else
                currentSprite = (direction == "L") and girlSprites.happyL or girlSprites.happyR
            end
            if happiness.percentage() < 30 then
                currentSprite = (direction == "L") and girlSprites.stinkyL or girlSprites.stinkyR
            end
        end

        animationTimer = animationTimer + dt
        if animationTimer >= animationSpeed then
            animationTimer = animationTimer - animationSpeed
            if direction == "L" then
                direction = "R"
            else
                direction = "L"
            end
        end
    end

    energy.update(dt)  
    happiness.update(dt)
    hunger.update(dt)
end

function anim.draw()
    if gameOver then
        drawDeathPopup()
        return
    end

    if icon.isLightOn() then
        love.graphics.draw(currentSprite, 550, 425)
    else
        love.graphics.draw(sleep, 550, 500)
    end
end

function drawDeathPopup()
    local width, height = love.graphics.getDimensions()
    local popupWidth, popupHeight = 300, 100
    local popupX = (width - popupWidth) / 2
    local popupY = (height - popupHeight) / 2

    love.graphics.setColor(0, 0, 0, 0.7)
    love.graphics.rectangle("fill", popupX, popupY, popupWidth, popupHeight)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("SHE DIED!", popupX, popupY + 40, popupWidth, "center")
end

return anim
