local hunger = {}

local icon = require("icons")

local hunger_meter = {}
local hunger_meter_percent = 100
local current_hunger_meter_sprite

function hunger.load()
    for i = 1, 5 do
        hunger_meter[i] = love.graphics.newImage("assets/meters/hunger_meter (" .. i .. ").png")
    end
    current_hunger_meter_sprite = hunger_meter[1]
end

function hunger.update(dt)

    if icon.isEatIconClicked() then
        increaseHunger(100)
        icon.resetEatIconClicked()  
    end


    local decrease_rate = 2
    hunger_meter_percent = hunger_meter_percent - dt * decrease_rate
    if hunger_meter_percent < 0 then
        hunger_meter_percent = 0
    end

    local meter_index = math.ceil((1 - hunger_meter_percent / 100) * #hunger_meter)
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

function hunger.percentage()
    return hunger_meter_percent
end

function hunger.draw()
    love.graphics.draw(current_hunger_meter_sprite, 1117, 13, 0, 0.85)
end

return hunger
