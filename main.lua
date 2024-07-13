local animation = require("animation")
local icon = require("icons")

local background 

function love.load()
    love.window.setMode(1600, 1033)
    love.window.setTitle("WEP✨")

    animation.load()
    icon.load()

    background = love.graphics.newImage("assets/background.png")
end

function love.update(dt)
    animation.update(dt)
end

function love.draw()
    love.graphics.draw(background, 0, 0)

    animation.draw()
    icon.draw()
end

function love.mousepressed(x, y, button)
    icon.mousepressed(x, y, button)
end