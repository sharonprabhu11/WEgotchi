local icon = require("icons")

local anim = {}

local girlSprites = {}
local currentSprite
local showAnimation = true
local animationTimer = 0
local animationSpeed = 1
local animationIndex = 1
local sleep

function anim.load()
    girlSprites = {
        love.graphics.newImage("assets/girl/neutL.png"),
        love.graphics.newImage("assets/girl/neutR.png"),
    }
    currentSprite = girlSprites[1]
    sleep = love.graphics.newImage("assets/girl/sleep.png")
end

function anim.update(dt)
    if showAnimation and icon.isLightOn() then
        animationTimer = animationTimer + dt
        if animationTimer >= animationSpeed then
            animationTimer = animationTimer - animationSpeed
            animationIndex = animationIndex % #girlSprites + 1
            currentSprite = girlSprites[animationIndex]
        end
    end
end

function anim.draw()
    if icon.isLightOn() then
        love.graphics.draw(currentSprite, 550, 425)
    else
        love.graphics.draw(sleep, 550, 500)
    end
end

return anim
