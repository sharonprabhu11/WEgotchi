local animation = require("animation")
local icon = require("icons")
local duckgame = require("duckgame")

local background 

function love.load()
    love.window.setMode(1600, 1033)
    love.window.setTitle("WEP✨")

    animation.load()
    icon.load()

    background = love.graphics.newImage("assets/background.png")

    duckgame.load()
end

function love.update(dt)
    animation.update(dt)
    
    duckgame.update(dt)
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

    duckgame.draw()
end

function love.mousepressed(x, y, button)
    icon.mousepressed(x, y, button)
end

