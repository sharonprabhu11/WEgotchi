local intro = require("intro")
local icon = require("icons")
local animation = require("animation")
local hunger = require("hunger_meter")
local energy = require("energy_meter")
local happy = require("happiness_meter")
local eat = require("eat")
local med = require("med")
local game = require("game")

local background
local pixelFont

function love.load()
    love.window.setMode(1600, 1033)
    love.window.setTitle("WEP✨")

    pixelFont = love.graphics.newFont("assets/fonts/pixelfont.otf", 20)

    intro.load(pixelFont)
    icon.load()
    animation.load()
    hunger.load()
    energy.load()
    happy.load()
    eat.load()
    med.load()
    game.load()

    background = love.graphics.newImage("assets/background.png")
end

function love.update(dt)
    if intro.isActive() then
        intro.update(dt)
    else
        animation.update(dt)
        hunger.update(dt)
        energy.update(dt)
        happy.update(dt)
        eat.update(dt)
        med.update(dt)
        game.update(dt)
    end
end

function love.draw()
    if intro.isActive() then
        love.graphics.clear(1, 1, 0.8)
        intro.draw()
    else
        love.graphics.draw(background, 0, 0)

        if not icon.isLightOn() then
            love.graphics.setColor(0, 0, 0)
            love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
            love.graphics.setColor(1, 1, 1)
        end

        icon.draw()
        animation.draw()
        hunger.draw()
        energy.draw()
        happy.draw()
        eat.draw()
        med.draw()
        game.draw()

        love.graphics.setFont(pixelFont)
    end
end

function love.mousepressed(x, y, button)
    if intro.isActive() then
        intro.mousepressed(x, y, button)
    else
        icon.mousepressed(x, y, button)
    end
end
