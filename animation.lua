local anim = {}

local girlSprites = {}
local currentSprite
local showAnimation = true
local animationTimer = 0
local animationSpeed = 1
local animationIndex = 1

function anim.load()
    girlSprites = {
        love.graphics.newImage("assets/girl/neutL.png"),
        love.graphics.newImage("assets/girl/neutR.png"),
    }
    currentSprite = girlSprites[1]
end

function anim.update(dt)
    if showAnimation then
        animationTimer = animationTimer + dt
        if animationTimer >= animationSpeed then
            animationTimer = animationTimer - animationSpeed
            animationIndex = animationIndex % #girlSprites + 1
            currentSprite = girlSprites[animationIndex]
        end
    end
end

function anim.draw()
    love.graphics.draw(currentSprite, 550, 425)
end

return anim
