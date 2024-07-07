-- Load images for the girl and the duck
local girl
local duck

-- Table to store ducks
local ducks = {}

-- Variables to control the girl's position and speed
local girlX = 400
local girlY = 550
local girlSpeed = 200

-- Duck falling speed
local duckSpeed = 150

-- Scaling factors for the images
local scale = 0.2  -- Slightly increased scale

-- Minimum distance between ducks when they are spawned
local minDuckSpacing = 50

-- Function to load assets
function love.load()
    girl = love.graphics.newImage("girl.jpeg")
    duck = love.graphics.newImage("duck.jpeg")
    love.window.setMode(800, 600)
    love.window.setTitle("Save the Girl from the Ducks!")
end

-- Function to update game state
function love.update(dt)
    -- Move the girl left or right
    if love.keyboard.isDown("left") then
        girlX = girlX - girlSpeed * dt
    elseif love.keyboard.isDown("right") then
        girlX = girlX + girlSpeed * dt
    end

    -- Keep the girl within the window bounds
    if girlX < 0 then girlX = 0 end
    if girlX > love.graphics.getWidth() - girl:getWidth() * scale then
        girlX = love.graphics.getWidth() - girl:getWidth() * scale
    end

    -- Add a new duck every 1 second
    if math.random() < dt then
        local newDuckX = math.random(0, love.graphics.getWidth() - duck:getWidth() * scale)
        
        -- Ensure the new duck does not overlap with any existing ducks
        local canAddDuck = true
        for _, d in ipairs(ducks) do
            if math.abs(d.x - newDuckX) < minDuckSpacing then
                canAddDuck = false
                break
            end
        end

        if canAddDuck then
            local newDuck = { x = newDuckX, y = -duck:getHeight() * scale }
            table.insert(ducks, newDuck)
        end
    end

    -- Move ducks down
    for i, d in ipairs(ducks) do
        d.y = d.y + duckSpeed * dt

        -- Check for collision with the girl
        if d.y + duck:getHeight() * scale > girlY and d.x + duck:getWidth() * scale > girlX and d.x < girlX + girl:getWidth() * scale then
            love.event.quit("Game Over: You got hit by a duck!")
        end
    end

    -- Remove ducks that have fallen off the screen
    for i = #ducks, 1, -1 do
        if ducks[i].y > love.graphics.getHeight() then
            table.remove(ducks, i)
        end
    end
end

-- Function to draw everything
function love.draw()
    love.graphics.draw(girl, girlX, girlY, 0, scale, scale)
    for _, d in ipairs(ducks) do
        love.graphics.draw(duck, d.x, d.y, 0, scale, scale)
    end
end

