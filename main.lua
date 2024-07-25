local intro = require("intro")
local icon = require("icons")
local animation = require("animation")
local hunger = require("hunger_meter")
local energy = require("energy_meter")
local happy = require("happiness_meter")
local eat = require("eat")
local med = require("med")
local game = require("game")
local saveData = require("saveData")

local background
local pixelFont
local bgnight

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
    bgnight = love.graphics.newImage("assets/bgnight.png") -- Load the night background image

    local savedData = saveData.loadData()
    if savedData then
        local currentTime = os.time()
        local elapsedTime = currentTime - savedData.time

        hunger.setPercentage(savedData.hungerPercent, elapsedTime)
        energy.setPercentage(savedData.energyPercent, elapsedTime)
        happy.setPercentage(savedData.happyPercent, elapsedTime)
    end
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
        if icon.isLightOn() then
            love.graphics.draw(background, 0, 0)
        else
            love.graphics.draw(bgnight, 0, 0) -- Draw the night background when light is off
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

function love.quit()
    local data = {
        time = os.time(),
        hungerPercent = hunger.percentage(),
        energyPercent = energy.percentage(),
        happyPercent = happy.percentage()
    }
    saveData.saveData(data)
end

