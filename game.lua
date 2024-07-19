local game = {}

local background 
local girl, duck
local girlScaleFactor, duckScaleFactor
local girlWidth, girlHeight, girlX, girlY, girlSpeed
local ducks, duckWidth, duckHeight, duckSpeed, duckSpawnTime, duckTimer
local score, gameFont, gameMessage
local bgWidth, bgHeight
local windowWidth, windowHeight
local scaleX, scaleY
local gameActive = false  -- Track if the game is active

function game.load()
    -- Load assets
    background = love.graphics.newImage("assets/gamebackground.png")
    bgWidth, bgHeight = background:getDimensions()
    windowWidth, windowHeight = love.graphics.getDimensions()
    scaleX = windowWidth / bgWidth
    scaleY = windowHeight / bgHeight

    girl = love.graphics.newImage("assets/girl/happyR.png")
    duck = love.graphics.newImage("assets/duck.png")
    
    girlScaleFactor = 0.36  
    duckScaleFactor = 0.2   
    
    girlWidth = girl:getWidth() * girlScaleFactor
    girlHeight = girl:getHeight() * girlScaleFactor
    girlSpeed = 300
    
    duckWidth = duck:getWidth() * duckScaleFactor
    duckHeight = duck:getHeight() * duckScaleFactor
    duckSpeed = 200
    duckSpawnTime = 1
    
    gameFont = love.graphics.newFont(24)
end

function game.start()
    -- Initialize game state
    gameActive = true
    girlX = (love.graphics.getWidth() - girlWidth) / 2
    girlY = love.graphics.getHeight() - girlHeight
    ducks = {}
    duckTimer = duckSpawnTime
    score = 0
    gameMessage = "Avoid the falling ducks!"
end

function game.update(dt)
    if not gameActive then return end

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
        end
    end
end

function game.draw()
    if not gameActive then return end

    love.graphics.draw(background, 0, 0, 0, scaleX, scaleY)
    love.graphics.draw(girl, girlX, girlY, 0, girlScaleFactor, girlScaleFactor)
    
    for i, d in ipairs(ducks) do
        love.graphics.draw(duck, d.x, d.y, 0, duckScaleFactor, duckScaleFactor)
    end
    
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: " .. score, 10, 10)
    love.graphics.printf(gameMessage, 0, 50, love.graphics.getWidth(), "center")
end

return game
