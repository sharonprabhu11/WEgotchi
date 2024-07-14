local duckgame = {}

function duckgame.load()
    background = love.graphics.newImage("backgroundDUCKGAME.png")
    girl = love.graphics.newImage("happyR.png")
    duck = love.graphics.newImage("cuteduck.png")
    
    girlScaleFactor = 0.36
    duckScaleFactor = 0.2
    
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
end

function duckgame.update(dt)
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

function duckgame.draw()
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(girl, girlX, love.graphics.getHeight() - girlHeight, 0, girlScaleFactor, girlScaleFactor)
    
    for i, d in ipairs(ducks) do
        love.graphics.draw(duck, d.x, d.y, 0, duckScaleFactor, duckScaleFactor)
    end
    
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: " .. score, 10, 10)
    love.graphics.printf(gameMessage, 0, 50, love.graphics.getWidth(), "center")
end

return duckgame

