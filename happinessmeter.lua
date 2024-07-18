local animation = require("animation")
local icon = require("icons")

local background 
local girl, duck
local girlScaleFactor, duckScaleFactor
local girlWidth, girlHeight, girlX, girlY, girlSpeed
local ducks, duckWidth, duckHeight, duckSpeed, duckSpawnTime, duckTimer
local score, gameFont, gameMessage

local happinessMeterImages = {}
local happinessLevel
local happinessIncreaseThreshold

function love.load()
    love.window.setMode(1600, 1033)
    love.window.setTitle("WEP✨")

    animation.load()
    icon.load()

    background = love.graphics.newImage("assets/background.png")
    
    girl = love.graphics.newImage("assets/happyR.png")
    duck = love.graphics.newImage("assets/cuteduck.png")
    
    girlScaleFactor = 0.36
    duckScaleFactor = 0.16
    
    girlWidth = girl:getWidth() * girlScaleFactor
    girlHeight = girl:getHeight() * girlScaleFactor
    girlX = (love.graphics.getWidth() - girlWidth) / 2
    girlY = love.graphics.getHeight() - girlHeight
    girlSpeed = 300
    
    ducks = {}
    duckWidth = duck:getWidth() * duckScaleFactor
    duckHeight = duck:getHeight() * duckScaleFactor
    duckSpeed = 200
    duckSpawnTime = 1
    duckTimer = 0
    
    score = 0
    gameFont = love.graphics.newFont(24)
    gameMessage = "Avoid the falling ducks!"
    
    for i = 1, 5 do
        table.insert(happinessMeterImages, love.graphics.newImage("assets/meters/happiness_meter (" .. i .. ").png"))
    end
    happinessLevel = 5
    happinessIncreaseThreshold = 20
end

function love.update(dt)
    animation.update(dt)
    
    if love.keyboard.isDown("left") then
        girlX = girlX - girlSpeed * dt
    elseif love.keyboard.isDown("right") then
        girlX = girlX + girlSpeed * dt
    end

    if girlX < 0 then
        girlX = 0
    elseif girlX > love.graphics.getWidth() - girlWidth then
        girlX = love.graphics.getWidth() - girlWidth
    end

    duckTimer = duckTimer - dt
    if duckTimer <= 0 then
        table.insert(ducks, {x = math.random(0, love.graphics.getWidth() - duckWidth), y = -duckHeight})
        duckTimer = duckSpawnTime
    end

    for i, d in ipairs(ducks) do
        d.y = d.y + duckSpeed * dt

        if d.y + duckHeight > girlY and d.x < girlX + girlWidth and d.x + duckWidth > girlX then
            gameMessage = "Oh no! You got hit by a duck! Final score: " .. score
            love.timer.sleep(2)
            love.event.quit()
        end
    end

    for i = #ducks, 1, -1 do
        if ducks[i].y > love.graphics.getHeight() then
            table.remove(ducks, i)
            score = score + 1
            gameMessage = "Nice dodge! Score: " .. score
            
            if score >= 100 then
                gameMessage = "Congratulations! You won with a score of 100!"
                love.timer.sleep(2)
                love.event.quit()
            end

            if score % happinessIncreaseThreshold == 0 and happinessLevel > 1 then
                happinessLevel = happinessLevel - 1
            end
        end
    end
end

function love.draw()
    love.graphics.draw(background, 0, 0)

    if not icon.isLightOn() then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1)  
    end

    animation.draw()
    icon.draw()

    love.graphics.draw(girl, girlX, love.graphics.getHeight() - girlHeight, 0, girlScaleFactor, girlScaleFactor)
    
    for i, d in ipairs(ducks) do
        love.graphics.draw(duck, d.x, d.y, 0, duckScaleFactor, duckScaleFactor)
    end
    
    love.graphics.setFont(gameFont)
    
    love.graphics.print("Score: " .. score, 10, 10)
    love.graphics.printf(gameMessage, 0, 50, love.graphics.getWidth(), "center")

    love.graphics.draw(happinessMeterImages[happinessLevel], love.graphics.getWidth() - 200, 10)
end

function love.mousepressed(x, y, button)
    icon.mousepressed(x, y, button)
end

