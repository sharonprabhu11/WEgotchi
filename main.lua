local icon = require("icons")
local animation = require("animation")
local icon = require("icons")
local health_meter = require("health_meter")
local eat = require("eat")
local med = require("med")
local game = require("game")

local background 

function love.load()
    love.window.setMode(1600, 1033)
    love.window.setTitle("WEP✨")

    icon.load()
    animation.load()
    icon.load()
    health_meter.load()
    eat.load()
    med.load()
    game.load()

    background = love.graphics.newImage("assets/background.png")
end

function love.update(dt)
    
    animation.update(dt)
    health_meter.update(dt)
    eat.update(dt)
    med.update(dt)
    game.update(dt)
end

function love.draw()
    love.graphics.draw(background, 0, 0)

    if not icon.isLightOn() then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1)
    end

    icon.draw()
    animation.draw()
    health_meter.draw()
    eat.draw()
    med.draw()
    game.draw()
end

function love.mousepressed(x, y, button)
    icon.mousepressed(x, y, button)
end
