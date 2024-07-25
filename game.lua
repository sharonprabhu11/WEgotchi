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
local gameActive = false  
local endTimer = 0 

function game.load()
    -- Load assets
    background = love.graphics.newImage("assets/gamebackground.png")
    bgWidth, bgHeight = background:getDimensions()
    windowWidth, windowHeight = love.graphics.getDimensions()
    scaleX = windowWidth / bgWidth
    scaleY = windowHeight / bgHeight

    girl = love.graphics.newImage("assets/girl.png")
    duck = love.graphics.newImage("assets/duck.png")

    girlWidth, girlHeight = girl:getDimensions()
    girlX = 100
    girlY = windowHeight / 2
    girlSpeed = 300 

    duckWidth, duckHeight = duck:getDimensions()
    ducks = {}
    duckSpeed = 200 
    duckSpawnTime = 1.5 
    duckTimer = duckSpawnTime 

    score = 0
    gameFont = love.graphics.newFont(30)
    love.graphics.setFont(gameFont)

    gameMessage = ""
end

function game.start()
    gameActive = true
    score = 0
    ducks = {}
    duckTimer = duckSpawnTime
    gameMessage = ""
end

function game.update(dt)
    if not gameActive then
        return
    end

    girlY = girlY + (girlSpeed * dt)
    if love.keyboard.isDown("w") then
        girlY = girlY - (girlSpeed * dt * 2)
    elseif love.keyboard.isDown("s") then
        girlY = girlY + (girlSpeed * dt * 2)
    end

    if girlY < 0 then
        girlY = 0
    elseif girlY > windowHeight - girlHeight then
        girlY = windowHeight - girlHeight
    end

    duckTimer = duckTimer - dt
    if duckTimer <= 0 then
        duckTimer = duckSpawnTime
        local newDuck = {x = windowWidth, y = love.math.random(0, windowHeight - duckHeight)}
        table.insert(ducks, newDuck)
    end

    for i, d in ipairs(ducks) do
        d.x = d.x - (duckSpeed * dt)
        if d.x < -duckWidth then
            table.remove(ducks, i)
            score = score - 1
        elseif d.x < girlX + girlWidth and d.y < girlY + girlHeight and girlX < d.x + duckWidth and girlY < d.y + duckHeight then
            table.remove(ducks, i)
            score = score + 1
        end
    end

    if score >= 10 then 
        gameActive = false 
        gameMessage = "You win!"
        endTimer = love.timer.getTime() + 3
    elseif score <= -5 then
        gameActive = false
        gameMessage = "You lose!"
        endTimer = love.timer.getTime() + 3
    end

    if not gameActive and love.timer.getTime() > endTimer then
        gameMessage = ""
    end
end

function game.draw()
    love.graphics.push()
    love.graphics.scale(scaleX, scaleY)
    love.graphics.draw(background, 0, 0)
    love.graphics.pop()

    love.graphics.draw(girl, girlX, girlY)

    for i, d in ipairs(ducks) do
        love.graphics.draw(duck, d.x, d.y)
    end

    love.graphics.print("Score: " .. score, 10, 10)

    if not gameActive and gameMessage ~= "" then
        love.graphics.printf(gameMessage, 0, windowHeight / 2 - 50, windowWidth, "center")
    end
end

return game

