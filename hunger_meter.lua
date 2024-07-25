local hunger = {}

local icon = require("icons")

local hunger_meter = {}
local hunger_meter_percent = 100
local current_hunger_meter_sprite

local windowWidth, windowHeight

function hunger.load()
    for i = 1, 5 do
        hunger_meter[i] = love.graphics.newImage("assets/meters/hunger_meter (" .. i .. ").png")
    end
    current_hunger_meter_sprite = hunger_meter[1]
    windowWidth, windowHeight = love.graphics.getDimensions()
end

function hunger.update(dt)
    if icon.isEatIconClicked() then
        increaseHunger(20)
        icon.resetEatIconClicked()
    end

    local decrease_rate = 1
    hunger_meter_percent = hunger_meter_percent - dt * decrease_rate
    if hunger_meter_percent < 0 then
        hunger_meter_percent = 0
    end

    local meter_index = math.ceil((hunger_meter_percent / 100) * #hunger_meter)
    if meter_index < 1 then
        meter_index = 1
    elseif meter_index > #hunger_meter then
        meter_index = #hunger_meter
    end

    current_hunger_meter_sprite = hunger_meter[meter_index]
end

function increaseHunger(amount)
    hunger_meter_percent = hunger_meter_percent + amount
    if hunger_meter_percent > 100 then
        hunger_meter_percent = 100
    end
end

function hunger.draw()
    love.graphics.push()
    love.graphics.scale(windowWidth / 1920, windowHeight / 1080) -- Assuming original design resolution is 1920x1080
    love.graphics.draw(current_hunger_meter_sprite, 1212, 157, 0, 0.85)
    love.graphics.pop()
end

return hunger

