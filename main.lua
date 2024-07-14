local animation = require("animation")
local icon = require("icons")
local duckgame = require("duckgame")

local background 
local currentGame

function love.load()
    love.window.setMode(1600, 1033)
    love.window.setTitle("WEP✨")

    animation.load()
    icon.load()
    duckgame.load()

    background = love.graphics.newImage("assets/background.png")

    -- Set the initial game
    currentGame = "main"
end

function love.update(dt)
    if currentGame == "main" then
        animation.update(dt)
    elseif currentGame == "duckgame" then
        duckgame.update(dt)
    end
end

function love.draw()
    if currentGame == "main" then
        love.graphics.draw(background, 0, 0)

        if not icon.isLightOn() then
            love.graphics.setColor(0, 0, 0)
            love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
            love.graphics.setColor(1, 1, 1)  
        end

        animation.draw()
        icon.draw()
    elseif currentGame == "duckgame" then
        duckgame.draw()
    end
end

function love.mousepressed(x, y, button)
    if currentGame == "main" then
        icon.mousepressed(x, y, button)
    end
end

function love.keypressed(key)
    if key == "1" then
        currentGame = "main"
    elseif key == "2" then
        currentGame = "duckgame"
    end
end

